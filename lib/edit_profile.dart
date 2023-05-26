import 'package:Despoky/utilities/routes.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'controllers/auth_controller.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  late AuthController _auth;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _passwordController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _auth = AuthController(context);
    final user = _auth.getCurrentUser();
    if (user != null) {
      //final displayName = user.displayName;
      // final firstName = displayName?.split(' ').first;
      // final lastName = displayName?.split(' ').last;
      //_firstNameController.text = firstName ?? '';
      //_lastNameController.text = lastName ?? '';
      _fullNameController.text = user.displayName ?? '';
      _emailController.text = user.email ?? '';
      _phoneNumberController.text = user.phoneNumber ?? '';
    }

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _animationController.forward();
  }

  Future<void> _saveProfile() async {
    final userId = _auth.getCurrentUser()?.uid;
    if (userId != null)  {
      await _auth.updateProfile(
        userId: userId,
        // firstName: _firstNameController.text,
        // lastName: _lastNameController.text,
        fullName: _fullNameController.text,
        email: _emailController.text,
        phoneNumber: _phoneNumberController.text,
        password: _passwordController.text,
        newPassword: _newPasswordController.text,
      );
      Navigator.of(context, rootNavigator: true)
           .pushNamed(AppRoutes.bottomNavBarPageRoute);

      // if(_formKey.currentState!.validate()){
      //   Navigator.of(context, rootNavigator: true)
      //     .pushNamed(AppRoutes.bottomNavBarPageRoute);
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
        backgroundColor: Color(0xFF171725),
        appBar: AppBar(
          backgroundColor: Color(0xFF171725),
          elevation: 0,
        ),
        body: Padding(
          padding: EdgeInsets.all(5.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Image.asset(
                'assets/user.png',
                width: 36.w,
                height: 10.h,
                color: Colors.white,
              ),

              SizedBox(height: 5.0.h),
              TypewriterAnimatedTextKit(
                text: ['Edit Profile'],
                textStyle: GoogleFonts.tenorSans(
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                speed: Duration(milliseconds: 200),
                textAlign: TextAlign.center,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                   // crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Form(
                        child: Column(
                          children: [
                            /*Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 40.w,
                                  child: TextFormField(
                                    controller: _firstNameController,
                                    style: TextStyle(color: Colors.grey),
                                    cursorColor: Colors.white70,
                                    decoration: InputDecoration(
                                      labelText: "First Name",
                                      labelStyle: TextStyle(color: Colors.white),
                                      hintText: _firstNameController.text,
                                      hintStyle: TextStyle(
                                        color: Colors.white70,
                                      ),
                                      fillColor: Colors.white.withOpacity(0.3),
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(2.0.h),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 40.w,
                                  child: TextFormField(
                                    controller: _lastNameController,
                                    style: TextStyle(color: Colors.grey),
                                    cursorColor: Colors.white70,
                                    decoration: InputDecoration(
                                      labelText: "Last Name",
                                      labelStyle: TextStyle(color: Colors.white),
                                      hintText: _lastNameController.text,
                                      hintStyle: TextStyle(
                                        color: Colors.white70,
                                      ),
                                      fillColor: Colors.white.withOpacity(0.3),
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(2.0.h),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),*/
                            SizedBox(height: 4.0.h),
                            TextFormField(
                              controller: _fullNameController,
                              validator: (val) =>
                              val!.isEmpty ? 'Required ' : null,

                              style: TextStyle(color: Colors.grey),
                              cursorColor: Colors.white70,
                              decoration: InputDecoration(
                                labelText: "Name",
                                labelStyle: TextStyle(color: Colors.white),
                                hintText: _fullNameController.text,
                                hintStyle: TextStyle(
                                  color: Colors.white70,
                                ),
                                fillColor: Colors.white.withOpacity(0.3),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                            SizedBox(height: 4.0.h),
                            TextFormField(
                              controller: _emailController,
                              validator: (val) =>
                              val!.isEmpty ? 'Required ' : null,

                              style: TextStyle(color: Colors.grey),
                              cursorColor: Colors.white70,
                              decoration: InputDecoration(
                                labelText: "Email",
                                labelStyle: TextStyle(color: Colors.white),
                                hintText: _emailController.text,
                                hintStyle: TextStyle(
                                  color: Colors.white70,
                                ),
                                suffixIcon: Icon(
                                  Icons.email,
                                  color: Colors.white70,
                                ),
                                fillColor: Colors.white.withOpacity(0.3),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                            SizedBox(height: 4.0.h),
                            TextFormField(
                              controller: _phoneNumberController,
                              validator: (val) =>
                              val!.isEmpty ? 'Required ' : null,

                              style: TextStyle(color: Colors.grey),
                              cursorColor: Colors.white70,
                              decoration: InputDecoration(
                                labelText: "Phone Number",
                                labelStyle: TextStyle(color: Colors.white),
                                hintText: _phoneNumberController.text,
                                hintStyle: TextStyle(
                                  color: Colors.white70,
                                ),
                                suffixIcon: Icon(
                                  Icons.phone,
                                  color: Colors.white70,
                                ),
                                fillColor: Colors.white.withOpacity(0.3),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                            SizedBox(height: 4.0.h),
                            TextFormField(
                              controller: _passwordController,
                              style: TextStyle(color: Colors.grey),
                              cursorColor: Colors.white70,
                              decoration: InputDecoration(
                                labelText: "Current Password",
                                labelStyle: TextStyle(color: Colors.white),
                                hintText: 'Current Password',
                                hintStyle: TextStyle(
                                  color: Colors.white70,
                                ),
                                suffixIcon: Icon(
                                  Icons.remove_red_eye,
                                  color: Colors.white70,
                                ),
                                fillColor: Colors.white.withOpacity(0.3),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              validator: (val) => val!.isEmpty ? 'Required' : null,
                            ),
                            SizedBox(height: 4.0.h),
                            TextFormField(
                              controller: _newPasswordController,
                              validator: (val) =>
                              val!.isEmpty ? 'Required ' : null,

                              style: TextStyle(color: Colors.grey),
                              cursorColor: Colors.white70,
                              decoration: InputDecoration(
                                labelText: "New Password",
                                labelStyle: TextStyle(color: Colors.white),
                                hintText: 'New Password',
                                hintStyle: TextStyle(
                                  color: Colors.white70,
                                ),
                                suffixIcon: Icon(
                                  Icons.panorama_fish_eye,
                                  color: Colors.white70,
                                ),
                                fillColor: Colors.white.withOpacity(0.3),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5.0.h),
                      Container(
                        width: 100.w,
                        height: 8.h,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.white,
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          onPressed: _saveProfile,
                          child: Text(
                            'SAVE',
                            style: GoogleFonts.tenorSans(
                              textStyle: TextStyle(
                                color: Color(0xFF171725),
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
