import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../models/delivery_method.dart';


class DeliveryMethodItem extends StatelessWidget {
  final DeliveryMethod deliveryMethod;
  const DeliveryMethodItem({
    Key? key,
    required this.deliveryMethod,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [

          Image.asset(
            deliveryMethod.image,
            fit: BoxFit.cover,
            height: 4.h,
            width: 20.w,
          ),

          SizedBox(height: 1.h),
          Text(
            '${deliveryMethod.days} days',
            style: TextStyle(
              color: Color(0xFF171725),
              fontSize: 12.sp
            ),
          ),
        ]),
      ),
    );
  }
}