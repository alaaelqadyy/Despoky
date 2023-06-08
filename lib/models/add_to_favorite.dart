import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteProduct{
  final String id;
  final String productId;
  final String description;
  final String title;
  final int price;
  final String image;
  final String size;
  final int quantity;

  FavoriteProduct({
    required this.id,
    required this.productId,
    required this.description,
    required this.title,
    required this.price,
    required this.image,
    required this.size,
    required this.quantity,
  });

  factory FavoriteProduct.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return FavoriteProduct(
      id: doc.id,
      productId: data['productId'],
      description: data['description'],
      title: data['title'],
      price: data['price'],
      image: data['image'],
      size: data['size'],
      quantity: data['quantity'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'description': description,
      'title': title,
      'price': price,
      'image': image,
      'size': size,
      'quantity': quantity,
    };
  }
}

