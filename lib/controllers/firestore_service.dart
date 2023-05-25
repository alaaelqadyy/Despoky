// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../models/Product.dart';
//
// class FirestoreService {
//   final CollectionReference _productsCollection =
//   FirebaseFirestore.instance.collection('products');
//
//   Future<void> createProduct(String category, String type, Product product) async {
//     final DocumentReference productDocRef =
//     _productsCollection.doc(category).collection(type).doc();
//
//     await productDocRef.set(product.toMap());
//   }
// }