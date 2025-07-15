import 'package:flutter/material.dart';
import '../models/product_model.dart';

class InvoiceScreen extends StatelessWidget {
  final List<Product> products;
  final String deliveryAddress;
  final double totalAmount;
  final String orderId;
  final DateTime orderDate;

  const InvoiceScreen({
    super.key,
    required this.products,
    required this.deliveryAddress,
    required this.totalAmount,
    required this.orderId,
    required this.orderDate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Invoice")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Order ID: $orderId", style: const TextStyle(fontSize: 16)),
            Text(
              "Date: ${orderDate.toLocal().toString().split(' ')[0]}",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text("Delivery Address:", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(deliveryAddress),
            const Divider(height: 32),
            const Text("Products:", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final p = products[index];
                  return ListTile(
                    title: Text(p.name),
                    subtitle: Text("Qty: ${p.quantity}"),
                    trailing: Text("₹${(p.price * p.quantity).toStringAsFixed(2)}"),
                  );
                },
              ),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Total",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text("₹${totalAmount.toStringAsFixed(2)}",
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Back to Home"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
