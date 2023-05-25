import 'package:Despoky/utilities/routes.dart';
import 'utilities/router.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sizer/sizer.dart';

import 'controllers/firestore_service.dart';
import 'models/Product.dart';

Future<void> main() async {
  await initializeFirebase();
  runApp( MyApp());
}

Future<void> initializeFirebase() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
   MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
        builder: (context, orientation, deviceType) {
          return  MaterialApp(
            debugShowCheckedModeBanner: false,

            onGenerateRoute: onGenerateRoute,
            initialRoute: AppRoutes.loginPageRoute,
          );
        }
    );
  }

   /*final firestoreService = FirestoreService();

   final glassesProduct = Product(
     id: 'glasses123', // Add an id for the glasses product
     name: 'Glasses',
     images: ['image1.jpg', 'image2.jpg'],
     description: 'Fashionable glasses for a stylish look',
     colors: ['Black', 'Brown', 'Red'],
     quantity: 10,
     price: 29.99,
   );

   final hatsProduct = Product(
     id: 'hats456', // Add an id for the hats product
     name: 'Hats',
     images: ['image3.jpg', 'image4.jpg'],
     description: 'Stylish hats for any occasion',
     colors: ['Blue', 'Gray', 'White'],
     quantity: 5,
     price: 19.99,
   );

   await firestoreService.createProduct('child', 'Glasses', glassesProduct);
   await firestoreService.createProduct('adult', 'Hats', hatsProduct);

   print('Products created successfully!');*/
}