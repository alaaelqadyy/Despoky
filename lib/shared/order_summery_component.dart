import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class OrderSummaryComponent extends StatelessWidget {
  final String title;
  final String value;
  const OrderSummaryComponent({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$title:',
          style: GoogleFonts.tenorSans(
              textStyle: TextStyle(
                  color: Colors.white70,
                  fontSize: 13.sp
              )
          )
        ),
        Text(
          value,
          style: GoogleFonts.tenorSans(
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 13.sp
            )
          ),
        ),
      ],
    );
  }
}