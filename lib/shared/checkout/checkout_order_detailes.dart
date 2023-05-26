import 'package:flutter/material.dart';

import '../order_summery_component.dart';
import 'package:sizer/sizer.dart';

class CheckoutOrderDetails extends StatelessWidget {
  const CheckoutOrderDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OrderSummaryComponent(title: 'Order', value: '125\$'),
        SizedBox(height: 2.h),
        OrderSummaryComponent(title: 'Delivery', value: '15\$'),
        SizedBox(height: 2.h),
        OrderSummaryComponent(title: 'Summary', value: '140\$'),
      ],
    );
  }
}