import 'package:flutter/material.dart';
import 'package:appbar_animated/appbar_animated.dart';

import '../controllers/auth_controller.dart';

class CustomAppBar extends StatelessWidget {
  final ColorAnimated colorAnimated;

  const CustomAppBar({Key? key, required this.colorAnimated}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController _auth =AuthController(context);
    return AppBar(
      backgroundColor: colorAnimated.background,
      elevation: 0,
      leading: Image.asset(
        'assets/images/logo.png',
        color: colorAnimated.color,

      ),
      actions: [
        IconButton(
          onPressed: () {
            _auth.signOut();
          },
          icon: Icon(
            Icons.logout,
            color: colorAnimated.color,
          ),
        ),
      ],
    );
  }
}