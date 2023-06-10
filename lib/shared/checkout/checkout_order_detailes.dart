import 'package:flutter/material.dart';

import '../order_summery_component.dart';
import 'package:sizer/sizer.dart';

class CheckoutOrderDetails extends StatelessWidget {
  final double subtotal;
  final double deliveryFee = 35.0;

  const CheckoutOrderDetails({Key? key, required this.subtotal,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double summary = subtotal + deliveryFee;
    return Column(
      children: [
        OrderSummaryComponent(title: 'Order', value: '${subtotal.toStringAsFixed(2)}\$'),
        SizedBox(height: 2.h),
        OrderSummaryComponent(title: 'Delivery', value: '${deliveryFee.toStringAsFixed(2)}\$'),
        SizedBox(height: 2.h),
        OrderSummaryComponent(title: 'Summary', value: '${summary.toStringAsFixed(2)}\$'),
      ],
    );
  }
}