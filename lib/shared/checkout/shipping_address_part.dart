import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../models/shipping_address.dart';
import '../../utilities/routes.dart';



class ShippingAddressComponent extends StatelessWidget {
  final ShippingAddress shippingAddress;
  const ShippingAddressComponent({
    Key? key,
    required this.shippingAddress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Card(
      elevation: 5,
      color: Color(0xFF33333f),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  shippingAddress.fullName,
                  style: GoogleFonts.tenorSans(
                      textStyle: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.white70,
                          fontWeight: FontWeight.bold
                      )
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(AppRoutes.addAddressPageRoute);

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
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              shippingAddress.address,
              style: GoogleFonts.tenorSans(
                  textStyle: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.white70,
                  )
              ),
            ),
            Text(
              '${shippingAddress.city}, ${shippingAddress.state}, ${shippingAddress.country}',
              style: GoogleFonts.tenorSans(
                  textStyle: TextStyle(
                      color: Colors.white70,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}