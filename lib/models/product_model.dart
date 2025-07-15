class Product {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final String description;
  final String? category;
  final String? deliveryAddress;
  int quantity;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.description,
    this.category,
    this.deliveryAddress,
    this.quantity = 1,
  });

  // Create Product from Firestore document
  factory Product.fromMap(String id, Map<String, dynamic> map) {
    return Product(
      id: id,
      name: map['name'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      imageUrl: map['imageUrl'] ?? '',
      description: map['description'] ?? '',
      category: map['category'],
      deliveryAddress: map['deliveryAddress'],
      quantity: (map['quantity'] is int)
          ? map['quantity']
          : (map['quantity'] is double)
              ? (map['quantity'] as double).toInt()
              : 1,
    );
  }

  // Convert Product to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
      'description': description,
      'quantity': quantity,
      if (category != null) 'category': category,
      if (deliveryAddress != null) 'deliveryAddress': deliveryAddress,
    };
  }

  @override
  String toString() {
    return 'Product(id: $id, name: $name, price: $price, quantity: $quantity, category: $category, deliveryAddress: $deliveryAddress)';
  }
}
