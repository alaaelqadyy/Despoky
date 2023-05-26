import 'package:Despoky/controllers/auth_controller.dart';
import 'package:Despoky/utilities/routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  bool _isPasswordVisible = false;

  final _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _firstNameFocusNode = FocusNode();
  final _lastNameFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();

  late AuthController _authController;

  @override
  void initState() {
    super.initState();
    _authController = AuthController(context);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    _phoneFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Color(0xFF171725),
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 7.w, right: 7.w),
              child: Column(
                children: [
                  SizedBox(height: 10.h),
                  Text(
                    'CREATE NEW',
                    style: GoogleFonts.tenorSans(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    'ACCOUNT',
                    style: GoogleFonts.tenorSans(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  InkWell(
                    child: Text(
                      'Already a Member ? SIGN IN',
                      style: TextStyle(color: Colors.white70, fontSize: 13.sp),
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRoutes.loginPageRoute);
                    },
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 40.w,
                              child: TextFormField(
                                focusNode: _firstNameFocusNode,
                                controller: _firstNameController,
                                onEditingComplete: () =>
                                    FocusScope.of(context).requestFocus(_lastNameFocusNode),
                                textInputAction: TextInputAction.next,
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return 'Required';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.name,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xFF33333f),
                                  labelText: 'First Name',
                                  labelStyle: TextStyle(color: Colors.white70),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                            ), // firstName
                            Container(
                              width: 40.w,
                              child: TextFormField(
                                focusNode: _lastNameFocusNode,
                                controller: _lastNameController,
                                onEditingComplete: () =>
                                    FocusScope.of(context).requestFocus(_emailFocusNode),
                                textInputAction: TextInputAction.next,
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return 'Required';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.name,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xFF33333f),
                                  labelText: 'Last Name',
                                  labelStyle: TextStyle(color: Colors.white70),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                            ), //LastName
                          ],
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        TextFormField(
                          focusNode: _emailFocusNode,
                          controller: _emailController,
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () =>
                              FocusScope.of(context).requestFocus(_passwordFocusNode),
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Required';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xFF33333f),
                            labelText: 'Email',
                            labelStyle: TextStyle(color: Colors.white70),
                            suffixIcon: Icon(
                              Icons.email,
                              color: Colors.white70,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 4.h),
                        TextFormField(
                          focusNode: _passwordFocusNode,
                          controller: _passwordController,
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () =>
                              FocusScope.of(context).requestFocus(_phoneFocusNode),
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Required';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xFF33333f),
                            labelText: 'Password',
                            labelStyle: TextStyle(color: Colors.white70),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                color: Colors.white70,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ), //password
                        SizedBox(height: 4.h),
                        TextFormField(
                          focusNode: _phoneFocusNode,
                          controller: _phoneNumberController,
                          textInputAction: TextInputAction.next,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Required';
                            }
                            // Prepend "+20" to the phone number
                            String phoneNumber = "+20" + val;
                            if (!isValidEgyptPhoneNumber(phoneNumber)) {
                              return 'Invalid phone number';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.phone,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xFF33333f),
                            labelText: 'Phone Number',
                            labelStyle: TextStyle(color: Colors.white70),
                            prefixText: '+20 ', // Display "+20 " as a prefix
                            prefixStyle: TextStyle(color: Colors.white70),
                            suffixIcon: Icon(
                              Icons.phone,
                              color: Colors.white70,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Container(
                          width: 100.w,
                          height: 8.h,
                          child: TextButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                String firstName = _firstNameController.text;
                                String lastName = _lastNameController.text;
                                String email = _emailController.text;
                                String password = _passwordController.text;
                                String phoneNumber = _phoneNumberController.text;

                                _authController.registerUser(
                                  firstName,
                                  lastName,
                                  email,
                                  password,
                                  phoneNumber,
                                );
                              }
                            },
                            child: Text(
                              'SIGN UP',
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


bool isValidEgyptPhoneNumber(String phoneNumber) {
  // Remove any leading or trailing whitespace
  phoneNumber = phoneNumber.trim();

  // Remove the country code
  phoneNumber = phoneNumber.substring(3);

  // Remove any spaces or dashes in the phone number
  phoneNumber = phoneNumber.replaceAll(" ", "").replaceAll("-", "");

  // Check if the phone number consists of 11 digits
  if (phoneNumber.length != 10) {
    return false;
  }

  // Check if the phone number starts with a valid network provider code
  String providerCode = phoneNumber.substring(0, 2);
  List<String> validProviderCodes = ["10", "11", "12", "15"];
  if (!validProviderCodes.contains(providerCode)) {
    return false;
  }

  return true;
}

