import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/Product.dart';
import '../models/add_to_cart.dart';
import '../models/add_to_favorite.dart';
import '../models/shipping_address.dart';
import 'auth_controller.dart';

class ServiceController {
  final BuildContext context;
  final CollectionReference _productsCollection =
  FirebaseFirestore.instance.collection('Products');
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final AuthController authController;

  ServiceController? _productService; // Declare the variable

// Check if the variable is null before initializing
  void initializeProductService() {
    if (_productService == null) {
      _productService = ServiceController(context); // Initialize the variable
    }
  }

  ServiceController(this.context)
      : authController = AuthController(
      context); // Pass BuildContext to AuthController constructor

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
      debugPrint('Get Products Error: $error');
      rethrow;
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

// Check if the product already exists in the favorites
  Future<bool> isExistInFavorites(
      FavoriteProduct favoriteProduct, String id) async {
    try {
      User? currentUser = authController.getCurrentUser();
      if (currentUser != null) {
        String userId = currentUser.uid;
        CollectionReference favCollection =
        _firestore.collection('users').doc(userId).collection('favorites');

        QuerySnapshot favSnapshot = await favCollection
            .where('productId', isEqualTo: favoriteProduct.productId)
            .get();

        // If there are any matching documents, the product already exists in favorites
        return favSnapshot.docs.isNotEmpty;
      }
    } catch (error) {
      print('Error checking favorites: $error');
      throw error;
    }

    // Return false if an error occurs or user is not logged in
    return false;
  }

  Future<void> addToFavorites(
      FavoriteProduct favoriteProduct, String id) async {
    try {
      User? currentUser = authController.getCurrentUser();
      if (currentUser != null) {
        String userId = currentUser.uid;
        CollectionReference favCollection =
        _firestore.collection('users').doc(userId).collection('favorites');

        // Check if the product already exists in the favorites
        bool existsInFavorites =
        await isExistInFavorites(favoriteProduct, userId);
        if (!existsInFavorites) {
          // Product doesn't exist in favorites, add it
          await favCollection.add(favoriteProduct.toMap());
        } else {
          // Product already exists in favorites, show a message or take appropriate action
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Product Already in Favorites'),
              content:
              Text('The selected product is already in your favorites.'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        }
      }
    } catch (error) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text(error.toString()),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }
  }

// Get the user's favorite products
  Future<List<FavoriteProduct>> getFavorites() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        QuerySnapshot snapshot = await _firestore
            .collection('users')
            .doc(user.uid)
            .collection('favorites')
            .get();
        List<FavoriteProduct> favorites = snapshot.docs
            .map((doc) => FavoriteProduct.fromSnapshot(doc))
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

// Get the user's cart
  Future<List<AddToCartModel>> getCart() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        QuerySnapshot snapshot = await _firestore
            .collection('users')
            .doc(user.uid)
            .collection('cart')
            .get();
        List<AddToCartModel> cart = snapshot.docs
            .map((doc) => AddToCartModel.fromSnapshot(doc))
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

  // Check if the product already exists in the cart
  Future<bool> isExistOnCart(AddToCartModel cartProduct, String id) async {
    try {
      User? currentUser = authController.getCurrentUser();
      if (currentUser != null) {
        String userId = currentUser.uid;
        CollectionReference cartCollection =
        _firestore.collection('users').doc(userId).collection('cart');

        QuerySnapshot cartSnapshot = await cartCollection
            .where('productId', isEqualTo: cartProduct.productId)
            .get();

        // If there are any matching documents, the product already exists in the cart
        return cartSnapshot.docs.isNotEmpty;
      }
    } catch (error) {
      print('Error checking Cart: $error');
      throw error;
    }

    // Return false if an error occurs or user is not logged in
    return false;
  }

  Future<void> addToCart(AddToCartModel cartProduct, String id) async {
    try {
      User? currentUser = authController.getCurrentUser();
      if (currentUser != null) {
        String userId = currentUser.uid;
        CollectionReference cartCollection =
        _firestore.collection('users').doc(userId).collection('cart');

        // Check if the product already exists in the cart
        bool existsInCart = await isExistOnCart(cartProduct, userId);
        if (!existsInCart) {
          // Product doesn't exist in the cart, add it
          await cartCollection.add(cartProduct.toMap());
        } else {
          // Product already exists in the cart, show a message or take appropriate action
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Product Already in Cart'),
              content: Text('The selected product is already in your cart.'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        }
      }
    } catch (error) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text(error.toString()),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
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

  Future<void> saveShippingAddress(
      String userId, ShippingAddress shippingAddress) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('shipping')
          .doc()
          .set({
        'fullName': shippingAddress.fullName,
        'country': shippingAddress.country,
        'address': shippingAddress.address,
        'city': shippingAddress.city,
        'state': shippingAddress.state,
        'zipCode': shippingAddress.zipCode,
        //'isDefault': shippingAddress.isDefault,
      });
    } catch (error) {
      throw error;
    }
  }

// Get user's shipping address
  Future<ShippingAddress> getShippingAddress(String userId) async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('shipping')
          .get();
      if (snapshot.docs.isNotEmpty) {
        final shippingData = snapshot.docs.first.data();
        final ShippingAddress shippingAddress = ShippingAddress(
          fullName: shippingData['fullName'],
          country: shippingData['country'],
          address: shippingData['address'],
          city: shippingData['city'],
          state: shippingData['state'],
          zipCode: shippingData['zipCode'],
          id: '',
        );

        return shippingAddress;
      } else {
        // No shipping address found for the user
        return ShippingAddress(
            id: '',
            fullName: '',
            country: '',
            address: '',
            city: '',
            state: '',
            zipCode: '');
      }
    } catch (error) {
      print('Error getting shipping address: $error');
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
      final adultsHatsSnapshot =
      await _productsCollection.doc('Adults').collection('Hats').get();
      final adultsHatsProducts = adultsHatsSnapshot.docs
          .map((doc) => Product.fromSnapshot(doc))
          .where((product) =>
          product.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
      final adultsGlassesSnapshot =
      await _productsCollection.doc('Adults').collection('Glasses').get();
      final adultsGlassesProducts = adultsGlassesSnapshot.docs
          .map((doc) => Product.fromSnapshot(doc))
          .where((product) =>
          product.name.toLowerCase().contains(query.toLowerCase()))
          .toList();

      final adultsEarringsSnapshot =
      await _productsCollection.doc('Adults').collection('Earrings').get();
      final adultsEarringsProducts = adultsEarringsSnapshot.docs
          .map((doc) => Product.fromSnapshot(doc))
          .where((product) =>
          product.name.toLowerCase().contains(query.toLowerCase()))
          .toList();

      final adultsTshirtsSnapshot =
      await _productsCollection.doc('Adults').collection('T-shits').get();
      final adultsTshirtsProducts = adultsTshirtsSnapshot.docs
          .map((doc) => Product.fromSnapshot(doc))
          .where((product) =>
          product.name.toLowerCase().contains(query.toLowerCase()))
          .toList();

      final childSnapshot =
      await _productsCollection.doc('Child').collection('Hats').get();
      final childProducts = childSnapshot.docs
          .map((doc) => Product.fromSnapshot(doc))
          .where((product) =>
          product.name.toLowerCase().contains(query.toLowerCase()))
          .toList();

      final childGlassesSnapshot =
      await _productsCollection.doc('Child').collection('Glasses').get();
      final childGlassesProducts = childGlassesSnapshot.docs
          .map((doc) => Product.fromSnapshot(doc))
          .where((product) =>
          product.name.toLowerCase().contains(query.toLowerCase()))
          .toList();

      // Merge the results from both collections
      final List<Product> searchResults = [
        ...adultsHatsProducts,
        ...adultsEarringsProducts,
        ...adultsGlassesProducts,
        ...adultsTshirtsProducts,
        ...childProducts,
        ...childGlassesProducts
      ];

      return searchResults;
    } catch (error) {
      print('Search Error: $error');
      throw error;
    }
  }
}
