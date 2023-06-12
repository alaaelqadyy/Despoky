import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../models/delivery_method.dart';
import '../../../models/shipping_address.dart';
import '../../shared/checkout/checkout_order_detailes.dart';
import '../../shared/checkout/deleviry_method.dart';
import '../../shared/checkout/payment_part.dart';
import '../../shared/checkout/shipping_address_part.dart';
import '../utilities/routes.dart';

class CheckoutPage extends StatelessWidget {
  // Add the subtotal parameter

  const CheckoutPage({Key? key,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Color(0xFF171725),
        elevation: 0,
        title: Text(
          'Checkout',
          style: GoogleFonts.tenorSans(
              textStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold
              )
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color(0xFF171725),
        child: Padding(
          padding: const EdgeInsets.only(right: 16.0,left: 16, top: 20.0),

          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Shipping address',
                  style: GoogleFonts.tenorSans(
                      textStyle: TextStyle(
                        fontSize: 17.sp,
                        color: Colors.white,
                      )
                  ),
                ),
                SizedBox(height: 3.h),

                ShippingAddressComponent(shippingAddress: shippingAddress.first,),

                SizedBox(height: 4.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Payment',
                      style: GoogleFonts.tenorSans(
                          textStyle: TextStyle(
                            fontSize: 17.sp,
                            color: Colors.white,
                            // fontWeight: FontWeight.bold
                          )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: InkWell(
                        onTap: () {

                        },
                        child: Text(
                          'Change',
                          style: GoogleFonts.tenorSans(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.bold
                              )
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 3.h),
                PaymentComponent(),
                SizedBox(height: 4.h),
                Text(
                  'Delivery method',
                  style: GoogleFonts.tenorSans(
                      textStyle: TextStyle(
                        fontSize: 17.sp,
                        color: Colors.white,
                        //fontWeight: FontWeight.bold
                      )
                  ),
                ),
                SizedBox(height: 3.h),


                Padding(
                  padding: const EdgeInsets.only(right: 16.0,left: 16),
                  child: SizedBox(
                    height: 11.h,
                    width: double.infinity,

                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: deliveryMethod
                          .map(
                            (e) => Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: DeliveryMethodItem(deliveryMethod: e),
                        ),
                      )
                          .toList(),
                    ),
                  ),
                ),


                SizedBox(height: 5.h),
                CheckoutOrderDetails(),
                SizedBox(height:5.h),


                Container(
                  width: 100.w,
                  height: 8.h,
                  child: TextButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                      shape: MaterialStateProperty.all<
                          RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(10),
                          )),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Thank You!\nFor choosing Bespoky'),
                            content: const Text(
                              ' Your order is being processed',
                            ),
                            icon: Icon(
                              Icons.delivery_dining,
                              color: Colors.black,
                              size: (6.h),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  {
                                    Navigator.of(context, rootNavigator: true)
                                        .pushNamed(
                                      AppRoutes.bottomNavBarPageRoute,
                                    );
                                  }
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text(
                      'SUBMIT ORDER',
                      style: GoogleFonts.tenorSans(
                        textStyle: TextStyle(
                            color: Color(0xFF171725),
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}