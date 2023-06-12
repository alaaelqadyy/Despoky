import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String docId; // Add the document ID field
  final String name;
  final String description;
  final double price;
  final List<String> image;
  final List<String> color;
  final List<String> size;
  final int quantity;

  Product({
    required this.docId,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.color,
    required this.size,
    required this.quantity,
  });

  factory Product.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    final image = List<String>.from(data['image'] ?? []);
    final color = List<String>.from(data['colors'] ?? []);
    final size = List<String>.from(data['sizes'] ?? []);
    return Product(
      docId: snapshot.id, // Set the document ID field
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      price: (data['price'] ?? 0.0).toDouble(),
      image: image,
      color: color,
      size: size,
      quantity: data['quantity'] ?? 0,
    );
  }
}
