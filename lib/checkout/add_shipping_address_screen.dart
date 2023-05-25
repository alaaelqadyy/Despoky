import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../utilities/routes.dart';


class AddShippingAddressPage extends StatefulWidget {
  const AddShippingAddressPage({super.key,});

  @override
  State<AddShippingAddressPage> createState() => _AddShippingAddressPageState();
}

class _AddShippingAddressPageState extends State<AddShippingAddressPage> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _zipCodeController = TextEditingController();
  final _countryController = TextEditingController();


  final _fullNameFocusNode = FocusNode();
  final _addressFocusNode = FocusNode();
  final _cityFocusNode = FocusNode();
  final _stateFocusNode = FocusNode();
  final _zipCodeFocusNode = FocusNode();
  final _countryFocusNode = FocusNode();


  @override
  void dispose() {
    _fullNameController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipCodeController.dispose();
    _countryController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: Theme.of(context).iconTheme.copyWith(color: Color(0xFF171725)),

        title: Text("Shipping Address",
          style:GoogleFonts.tenorSans(
            textStyle: TextStyle(
              color: Color(0xFF171725),
                fontWeight: FontWeight.bold,
                fontSize: 16.sp
            )
          ),
        ),
        centerTitle: true,
      ),


      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 3.h,horizontal: 4.w),
          child: Column(
            children: [

              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    TextFormField(

                        controller: _fullNameController,
                        focusNode: _fullNameFocusNode,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () =>
                          FocusScope.of(context).requestFocus(_addressFocusNode),
                      validator: (val) => val!.isEmpty ? 'Required' : null,
                      keyboardType: TextInputType.name,

                      decoration: InputDecoration(
                        floatingLabelStyle:TextStyle(color: Color(0xFF171725), fontSize: 13.sp) ,

                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white
                            )
                        ),
                          labelText: 'Full Name',
                        labelStyle: TextStyle(fontSize: 13.sp),

                        fillColor: Colors.white,
                          filled: true,
                        ),

                      style: TextStyle(color: Color(0xFF171725)),

                    ),
                    SizedBox(height: 3.h),
                    TextFormField(
                      focusNode: _addressFocusNode,
                      controller: _addressController,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () =>
                          FocusScope.of(context).requestFocus(_countryFocusNode),
                      validator: (val) => val!.isEmpty ? 'Required' : null,
                      keyboardType: TextInputType.streetAddress,
                      decoration: InputDecoration(
                        floatingLabelStyle:TextStyle(color: Color(0xFF171725), fontSize: 13.sp) ,

                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white
                            )
                        ),
                        labelText: 'Address',
                        labelStyle: TextStyle(fontSize: 13.sp),

                        fillColor: Colors.white,
                        filled: true,
                      ),

                      style: TextStyle(color: Color(0xFF171725)),
                    ), //password
                    SizedBox(height: 3.h),
                    TextFormField(
                      focusNode: _countryFocusNode,
                      controller: _countryController,
                      textInputAction: TextInputAction.next,
                      onEditingComplete:  () =>
                          FocusScope.of(context).requestFocus(_cityFocusNode),
                      validator: (val) => val!.isEmpty ? 'Required' : null,
                      decoration: InputDecoration(
                        floatingLabelStyle:TextStyle(color: Color(0xFF171725), fontSize: 13.sp) ,

                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white
                            )
                        ),
                        labelText: 'Country',
                        labelStyle: TextStyle(fontSize: 13.sp),
                        fillColor: Colors.white,
                        filled: true,
                      ),

                      style: TextStyle(color: Color(0xFF171725)),
                    ),
                    SizedBox(height: 3.h),
                    TextFormField(
                      focusNode: _cityFocusNode,
                      controller: _cityController,
                      textInputAction: TextInputAction.next,
                      onEditingComplete:  () =>
                          FocusScope.of(context).requestFocus(_stateFocusNode),
                      validator: (val) => val!.isEmpty ? 'Required' : null,
                      decoration: InputDecoration(
                        floatingLabelStyle:TextStyle(color: Color(0xFF171725), fontSize: 13.sp) ,

                        focusedBorder: UnderlineInputBorder(

                            borderSide: BorderSide(
                                color: Colors.white
                            )
                        ),
                        labelText: 'City',
                        labelStyle: TextStyle(fontSize: 13.sp),
                        fillColor: Colors.white,
                        filled: true,
                      ),

                      style: TextStyle(color: Color(0xFF171725)),
                    ),
                    SizedBox(height: 3.h),
                    TextFormField(
                      focusNode: _stateFocusNode,
                      controller: _stateController,
                      textInputAction: TextInputAction.next,
                      onEditingComplete:  () =>
                          FocusScope.of(context).requestFocus(_zipCodeFocusNode),
                      validator: (val) => val!.isEmpty ? 'Required' : null,
                      decoration: InputDecoration(
                        floatingLabelStyle:TextStyle(color: Color(0xFF171725), fontSize: 13.sp) ,

                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white
                            )
                        ),
                        labelText: 'State',
                        labelStyle: TextStyle(fontSize: 13.sp),
                        fillColor: Colors.white,
                        filled: true,
                      ),

                      style: TextStyle(color: Color(0xFF171725)),
                    ),
                    SizedBox(height: 3.h),
                    TextFormField(
                      focusNode: _zipCodeFocusNode,
                      controller: _zipCodeController,
                      textInputAction: TextInputAction.next,
                      validator: (val) => val!.isEmpty ? 'Required' : null,
                      decoration:InputDecoration(
                        floatingLabelStyle:TextStyle(color: Color(0xFF171725), fontSize: 13.sp) ,

                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white
                            )
                        ),
                        labelText: 'Zip Code',
                        labelStyle: TextStyle(fontSize: 13.sp),
                        fillColor: Colors.white,
                        filled: true,
                      ),

                      style: TextStyle(color: Color(0xFF171725)),
                    ),

                    SizedBox(height: 6.h,),
                    Container(
                      width: 100.w,
                      height: 9.h,
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF171725)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.of(context)
                                .pushNamed(AppRoutes.checkoutPageRoute);
                          }
                        },
                        child: Text(
                          'Save Address',
                          style: GoogleFonts.tenorSans(
                            textStyle: TextStyle(
                              color: Colors.white,
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

)
    );
  }
}