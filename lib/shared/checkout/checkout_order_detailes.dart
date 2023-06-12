import 'package:flutter/material.dart';

import '../order_summery_component.dart';
import 'package:sizer/sizer.dart';

class CheckoutOrderDetails extends StatelessWidget {

  final double subtotall = 397;
  final double deliveryFee = 50.0;

  const CheckoutOrderDetails({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double summary = subtotall + deliveryFee;
    return Column(
      children: [
        OrderSummaryComponent(title: 'Order', value: '${subtotall.toStringAsFixed(2)}\$'),
        SizedBox(height: 2.h),
        OrderSummaryComponent(title: 'Delivery', value: '${deliveryFee.toStringAsFixed(2)}\$'),
        SizedBox(height: 2.h),
        OrderSummaryComponent(title: 'Summary', value: '${summary.toStringAsFixed(2)}\$'),
      ],
    );
  }
}