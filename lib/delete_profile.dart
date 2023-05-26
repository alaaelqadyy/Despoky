import 'package:Despoky/utilities/routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:sizer/sizer.dart';


import 'controllers/auth_controller.dart';


class DeleteProfile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    late AuthController _authController = AuthController(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF171725) ,
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          width: 100.w,
          height: 100.h,
          color: Color(0xFF171725),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Padding(
                padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Deactivating your account',
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      'If you want to permanently delete your account, let us know.',
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          color: Color(0xFFDCD2D2),
                          fontSize: 13.sp,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    Container(
                      color: Color(0xFF252532),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Delete account',
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 13.sp,
                                ),
                              ),
                            ),
                            Text(
                              'Deleting your account is permanent.',
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              "When you delete your account, you won't be able to retrieve the content you have, your profile, and all of your orders will be deleted.",
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 13.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 9.h,
                    ),
                    Container(
                      width: 100.w,
                      color: Color(0xFF252532),
                      child: MaterialButton(
                        onPressed: () async {
                          await _authController.deleteUserProfile();
                        },
                        child: Text(
                          'Continue',
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              color: Colors.white70,
                              fontSize: 15.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Container(
                      width: double.infinity,
                      color: Color(0xFF252532),
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true).pushNamed(AppRoutes.bottomNavBarPageRoute);
                        },
                        child: Text(
                          'Cancel',
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              color: Colors.white70,
                              fontSize: 15.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
