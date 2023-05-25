import 'package:Despoky/shared/appbar.dart';
import 'package:appbar_animated/appbar_animated.dart';
import 'package:flutter/material.dart';
import 'package:Despoky/utilities/routes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:sizer/sizer.dart';
import 'controllers/auth_controller.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  String _userName = '';
  String _userEmail = '';
  String _userPhoneNumber = '';
  late AuthController _serviceController;

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.repeat(reverse: true);
    _serviceController = AuthController(context);

    _getUserProfile();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _getUserProfile() async {
    Map<String, dynamic> userProfile =
    await _serviceController.getUserProfile();
    setState(() {
      //_userName = _serviceController.getCurrentUser()?.displayName?? '';
      _userEmail = userProfile['email'] ?? '';
      _userName = userProfile['fullName'] ?? '';
      _userPhoneNumber = userProfile['phoneNumber'] ?? '';
    });

  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldLayoutBuilder(
      backgroundColorAppBar:
      const ColorBuilder(Colors.transparent, Color(0xFF171725)),
      textColorAppBar: const ColorBuilder(Colors.white),
      appBarBuilder: (context, colorAnimated) => CustomAppBar(
        colorAnimated: colorAnimated,
      ),
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return Scaffold(
            backgroundColor: Color(0xFF171725),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 7.w, right: 7.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        SizedBox(height: 15.h),
                        ScaleTransition(
                          scale: _animation,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 50.sp,
                            child: Icon(Icons.person,
                                size: 50.sp, color: Color(0xFF171725)),
                          ),
                        ),
                        SizedBox(height: 5.h),
                        TyperAnimatedTextKit(
                          text: ['Hello, $_userName!'],
                          textStyle: GoogleFonts.tenorSans(
                            textStyle: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          speed: Duration(milliseconds: 200),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          _userEmail,
                          style: GoogleFonts.lato(
                            textStyle:
                            TextStyle(fontSize: 14.sp, color: Colors.white),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 3.h),
                        Text(
                          _userPhoneNumber,
                          style: GoogleFonts.lato(
                            textStyle:
                            TextStyle(fontSize: 14.sp, color: Colors.white),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 8.h),
                        Container(
                          height: 8.h,
                          child: TextButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.white,
                              ),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.sp),
                                ),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context, rootNavigator: true)
                                  .pushNamed(AppRoutes.editProfilePageRoute);
                            },
                            child: Text(
                              'Edit Profile',
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF171725),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 3.h),
                        Container(
                          height: 8.h,
                          child: TextButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.redAccent,
                              ),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.sp),
                                ),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context, rootNavigator: true)
                                  .pushNamed(AppRoutes.deleteProfilePageRoute);
                            },
                            child: Text(
                              'Delete Account',
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
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
          );
        },
      ),
    );
  }
}
