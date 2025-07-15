import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/product_model.dart';

class CartService {
  static final _auth = FirebaseAuth.instance;
  static final _firestore = FirebaseFirestore.instance;

  static Future<void> addToCart(Product product, int quantity) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    final cartRef = _firestore.collection('users').doc(uid).collection('cart');
    final docRef = cartRef.doc(product.id);

    final doc = await docRef.get();

    if (doc.exists) {
      // Update quantity
      await docRef.update({
        'quantity': FieldValue.increment(quantity),
      });
    } else {
      // Add new item
      await docRef.set({
        'name': product.name,
        'price': product.price,
        'imageUrl': product.imageUrl,
        'quantity': quantity,
      });
    }
  }
}
