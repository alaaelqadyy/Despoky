import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../controllers/auth_controller.dart';

class Header extends StatelessWidget {

  late final AuthController _authController;
  @override
  Widget build(BuildContext context) {
    _authController =  AuthController(context);
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: 13.w,
                height: 15.h,
              ),
              IconButton(
                onPressed: (){
                  _authController.signOut();
                },
                icon: Icon(
                  Icons.logout,
                  color: Colors.white,
                  size: 4.h,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
