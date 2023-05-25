import 'package:Despoky/utilities/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late final BuildContext context;

  AuthController(this.context);

  // Login user with email and password
  Future<void> loginUser(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Navigator.of(context);
      Navigator.of(context, rootNavigator: true)
          .pushNamed(AppRoutes.bottomNavBarPageRoute);
    } catch (error) {
      throw error;
    }
  }

  // SignUp
  Future<void> registerUser(String firstName, String lastName, String email,
      String password, String phoneNumber) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      String userId = userCredential.user!.uid;

      await _firestore.collection('users').doc(userId).set({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'phoneNumber': phoneNumber,
      });
      Navigator.of(context).pushNamed(AppRoutes.loginPageRoute);
    } catch (error) {
      String errorMessage = 'An error occurred while registering the user.';

      if (error is FirebaseAuthException) {
        if (error.code == 'weak-password') {
          errorMessage = 'The password provided is too weak.';
        } else if (error.code == 'email-already-in-use') {
          errorMessage = 'The account already exists for the provided email.';
        }
      }
      throw errorMessage;
    }
  }

  // Retrieve the current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // Retrieve the current user data
  Future<Map<String, dynamic>> getUserProfile() async {
    try {
      String userId = getCurrentUser()?.uid?? '';
      DocumentSnapshot userSnapshot =
      await _firestore.collection('users').doc(userId).get();
      Map<String, dynamic>? userProfile =
      userSnapshot.data() as Map<String, dynamic>?;
      return userProfile ?? {};
    } catch (error) {
      print('Error getting user profile: $error');
      throw error;
    }
  }

  // Update the user profile details
  Future<void> updateProfile({
    required String userId,
    required String fullName,
    required String email,
    required String phoneNumber,
    required String password,
    required String newPassword,
  }) async {
    try {
      // Authenticate the user
      final user = getCurrentUser();
      if (user != null) {
        final credential = EmailAuthProvider.credential(
          email: user.email ?? '',
          password: password,
        );
        await user.reauthenticateWithCredential(credential);

        // Update user profile in Firestore
        await _firestore.collection('users').doc(userId).update({
          'fullName': fullName,
          'email': email,
          'phoneNumber': phoneNumber,
        });

        // Update the user's display name and email
        final displayName = '$fullName';
        await user.updateDisplayName(displayName);
        await user.updateEmail(email);

        if (phoneNumber.isNotEmpty) {
          // Update the phone number if provided
          final phoneAuthCredential = PhoneAuthProvider.credential(
            verificationId: '',
            smsCode: '',
          ); // Replace with actual verification ID and SMS code
          await user.updatePhoneNumber(phoneAuthCredential);
        }

        // Update the password if a new password is provided
        if (newPassword.isNotEmpty) {
          await user.updatePassword(newPassword);
        }
      }
      Navigator.of(context, rootNavigator: true)
          .pushNamed(AppRoutes.bottomNavBarPageRoute);
    } catch (error) {
      print('Error updating profile: $error');
      throw error;
    }
  }



  // Change the current user's password
  Future<void> changePassword(String newPassword) async {
    try {
      User? user = getCurrentUser();
      if (user != null) {
        await user.updatePassword(newPassword);
      }
    } catch (error) {
      print('Error changing password: $error');
      throw error;
    }
  }

  // Delete the user's profile and sign out
  Future<void> deleteUserProfile() async {
    try {
      // Get the currently logged-in user
      User? currentUser = getCurrentUser();
      if (currentUser != null) {
        // Delete the user's profile
        await currentUser.delete();


        // Sign out the user
        signOut();
      }
    } catch (error) {
      print('Error deleting profile: $error');
      throw error;
    }
  }

  // Sign out the current user
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      Navigator.of(context, rootNavigator: true).pushNamed(AppRoutes.loginPageRoute);
    } catch (error) {
      // Handle error
      print('Error signing out: $error');
      throw error;
    }
  }
}
