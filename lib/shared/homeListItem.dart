import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../utilities/routes.dart';
import '../../models/Product.dart';

class HomeListItem extends StatelessWidget {
  final Product product;

  const HomeListItem({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context, rootNavigator: true)
          .pushNamed(AppRoutes.productDetailesPageRoute, arguments: product),
      child: SizedBox(
        height: 30.h,
        child: DecoratedBox(
          decoration: BoxDecoration(),
          child: Column(
            children: [
              Container(
                color: Colors.white,
                child: Image.asset(
                  product.image[0],
                  width: 35.w,
                  height: 40.w,
                  fit: BoxFit.fitWidth,
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Expanded(
                child: Text(
                  product.name,
                  style: GoogleFonts.tenorSans(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 13.sp,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Expanded(
                child: Text(
                  " ${product.price} \$",
                  style: GoogleFonts.tenorSans(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 13.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
