import 'package:Despoky/utilities/routes.dart';
import 'utilities/router.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sizer/sizer.dart';

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
            initialRoute: AppRoutes.bottomNavBarPageRoute,
          );
        }
    );
  }

}