import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/Product.dart';

class ServiceController {
  final CollectionReference _productsCollection =
      FirebaseFirestore.instance.collection('Products');
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

// Get products by category and type
  Future<List<Product>> getProductsByCategoryAndType(
      String category, String type) async {
    try {
      final snapshot =
          await _productsCollection.doc(category).collection(type).get();
      final products =
          snapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList();
      return products;
    } catch (error) {
// Handle get products error
      print('Get Products Error: $error');
      throw error;
    }
  }

// Remove a product from the user's favorites
  Future<void> removeFromFavorites(String userId, String productId) async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        await _firestore
            .collection('users')
            .doc(userId)
            .collection('favorites')
            .doc(productId)
            .delete();
      }
    } catch (error) {
      print('Error removing from favorites: $error');
      throw error;
    }
  }

// Add a product to the user's favorites
  Future<void> addToFavorites(String userId, String productId) async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        await _firestore
            .collection('users')
            .doc(userId)
            .collection('favorites')
            .doc(productId)
            .set({
          'productId': productId
        });
      }
    } catch (error) {
      print('Error adding to favorites: $error');
      throw error;
    }
  }

// Get the user's favorite products
  Future<List<Map<String, dynamic>>> getFavorites() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        QuerySnapshot snapshot = await _firestore
            .collection('users')
            .doc(user.uid)
            .collection('favorites')
            .get();
        List<Map<String, dynamic>> favorites = snapshot.docs
            .map((doc) => {
                  'id': doc.id,
        // Add other fields as needed
                })
            .toList();
        return favorites;
      } else {
        return [];
      }
    } catch (error) {
      print('Error getting favorites: $error');
      throw error;
    }
  }

// Add a product to the user's cart
  Future<void> addToCart(String userId, String productId) async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        await _firestore
            .collection('users')
            .doc(userId)
            .collection('cart')
            .doc(productId)
            .set({
          'productId': productId
        });
      }
    } catch (error) {
      print('Error adding to cart: $error');
      throw error;
    }
  }

// Remove a product from the user's cart
  Future<void> removeFromCart(String userId, String productId) async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        await _firestore
            .collection('users')
            .doc(userId)
            .collection('cart')
            .doc(productId)
            .delete();
      }
    } catch (error) {
      print('Error removing from cart: $error');
      throw error;
    }
  }

// Get the user's cart
  Future<List<Map<String, dynamic>>> getCart() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        QuerySnapshot snapshot = await _firestore
            .collection('users')
            .doc(user.uid)
            .collection('cart')
            .get();
        List<Map<String, dynamic>> cart = snapshot.docs
            .map((doc) => {
                  'id': doc.id,
        // Add other fields as needed
                })
            .toList();
        return cart;
      } else {
        return [];
      }
    } catch (error) {
      print('Error getting cart: $error');
      throw error;
    }
  }

// Checkout
  Future<void> checkout(String category, String type) async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        // Perform checkout operation
      }
    } catch (error) {
      // Handle checkout error
      print('Checkout Error: $error');
      throw error;
    }
  }

  // Search for Products
  Future<List<Product>> search(String query) async {
    try {
      final adultsHatsSnapshot = await _productsCollection.doc('Adults').collection('Hats').get();
      final adultsHatsProducts = adultsHatsSnapshot.docs
          .map((doc) => Product.fromSnapshot(doc))
          .where((product) => product.name.toLowerCase().contains(query.toLowerCase()))
          .toList();

      final adultsGlassesSnapshot = await _productsCollection.doc('Adults').collection('Glasses').get();
      final adultsGlassesProducts = adultsGlassesSnapshot.docs
          .map((doc) => Product.fromSnapshot(doc))
          .where((product) => product.name.toLowerCase().contains(query.toLowerCase()))
          .toList();

      final adultsEarringsSnapshot = await _productsCollection.doc('Adults').collection('Earrings').get();
      final adultsEarringsProducts = adultsEarringsSnapshot.docs
          .map((doc) => Product.fromSnapshot(doc))
          .where((product) => product.name.toLowerCase().contains(query.toLowerCase()))
          .toList();

      final adultsTshirtsSnapshot = await _productsCollection.doc('Adults').collection('T-shits').get();
      final adultsTshirtsProducts = adultsTshirtsSnapshot.docs
          .map((doc) => Product.fromSnapshot(doc))
          .where((product) => product.name.toLowerCase().contains(query.toLowerCase()))
          .toList();

      final childSnapshot = await _productsCollection.doc('Child').collection('Hats').get();
      final childProducts = childSnapshot.docs
          .map((doc) => Product.fromSnapshot(doc))
          .where((product) => product.name.toLowerCase().contains(query.toLowerCase()))
          .toList();

      final childGlassesSnapshot = await _productsCollection.doc('Child').collection('Glasses').get();
      final childGlassesProducts = childGlassesSnapshot.docs
          .map((doc) => Product.fromSnapshot(doc))
          .where((product) => product.name.toLowerCase().contains(query.toLowerCase()))
          .toList();

      // Merge the results from both collections
      final List<Product> searchResults = [...adultsHatsProducts,...adultsEarringsProducts,...adultsGlassesProducts,...adultsTshirtsProducts, ...childProducts, ...childGlassesProducts];

      return searchResults;
    } catch (error) {
      print('Search Error: $error');
      throw error;
    }
  }


}
