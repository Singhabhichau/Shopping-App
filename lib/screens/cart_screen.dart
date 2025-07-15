import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product_model.dart';
import 'invoice_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return const Scaffold(
        body: Center(child: Text("You must be logged in to view your cart")),
      );
    }

    final cartRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('cart');

    return Scaffold(
      appBar: AppBar(title: const Text("Your Cart")),
      body: StreamBuilder<QuerySnapshot>(
        stream: cartRef.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Error loading cart"));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("Cart is empty"));
          }

          final cartDocs = snapshot.data!.docs;

          final List<Product> products = [];
          double total = 0;

          for (var doc in cartDocs) {
            final data = doc.data() as Map<String, dynamic>;

            final product = Product.fromMap(doc.id, data);
            total += product.price * product.quantity;
            products.add(product);
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (_, index) {
                    final product = products[index];
                    return ListTile(
                      leading: product.imageUrl.isNotEmpty
                          ? Image.network(product.imageUrl, width: 50, height: 50, fit: BoxFit.cover)
                          : const Icon(Icons.image_not_supported),
                      title: Text(product.name),
                      subtitle: Text("₹${product.price} × ${product.quantity}"),
                      trailing: Text(
                        "₹${(product.price * product.quantity).toStringAsFixed(2)}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    );
                  },
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Total:",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                    Text("₹${total.toStringAsFixed(2)}",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => InvoiceScreen(
                            products: products,
                            deliveryAddress: "123 Main Street, India", // replace with actual address
                            totalAmount: total,
                            orderId: DateTime.now().millisecondsSinceEpoch.toString(),
                            orderDate: DateTime.now(),
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(14)),
                    child: const Text("Proceed to Checkout"),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
