import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:Despoky/utilities/assets.dart';

class PaymentComponent extends StatelessWidget {
  const PaymentComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(16.0)),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child:Image.asset(
                  appAssets.masterCard,
                  fit: BoxFit.cover,
                  height: 6.h,
                width: 16.w,
              )

            ),
          ),

          Text('**** **** **** 2718', style: TextStyle(color: Colors.white70, fontSize: 13.sp),),
        ],
      ),
    );
  }
}