import 'package:Despoky/shared/appbar.dart';
import 'package:appbar_animated/appbar_animated.dart';

import 'product_detailes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../models/Product.dart';
import '../shared/homeListItem.dart';
import '../shared/header.dart';
import 'category_detailes.dart';
import 'controllers/service_controller.dart';
import 'utilities/assets.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScaffoldLayoutBuilder(
      backgroundColorAppBar:
      const ColorBuilder(Colors.transparent, Color(0xFF171725)),
      textColorAppBar: const ColorBuilder(Colors.white),
      appBarBuilder: (context, colorAnimated) => CustomAppBar(
        colorAnimated: colorAnimated,
      ),
      child: Container(
        width: 100.w,
        height: 100.h,
        color: Color(0xFF171725),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Image.asset(
                    appAssets.homeImage,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 60.h,
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        height: 7.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 30.w,
                              height: 0.2.h,
                              color: Colors.white,
                            ),
                            Text(
                              'CHILDREN',
                              style: GoogleFonts.tenorSans(
                                  textStyle: TextStyle(
                                      color: Colors.white, fontSize: 18.sp)),
                            ),
                            Container(
                              width: 30.w,
                              height: 0.2.h,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5.h),
                      buildCategorySection(context, 'Child', 'Hats'),
                      SizedBox(height: 5.h),
                      buildCategorySection(context, 'Child', 'Glasses'),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 3.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 7.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 34.w,
                          height: 0.2.h,
                          color: Colors.white,
                        ),
                        Text(
                          'ADULTS',
                          style: GoogleFonts.tenorSans(
                              textStyle: TextStyle(
                                  color: Colors.white, fontSize: 18.sp)),
                        ),
                        Container(
                          width: 34.w,
                          height: 0.2.h,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5.h),
                  buildCategorySection(context, 'Adults', 'Hats'),
                  SizedBox(height: 10.h),
                  buildCategorySection(context, 'Adults', 'Glasses'),
                  SizedBox(height: 10.h),
                  buildCategorySection(context, 'Adults', 'Earrings'),
                  SizedBox(height: 10.h),
                  buildCategorySection(context, 'Adults', 'T-shits'),
                  SizedBox(height: 10.h),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCategorySection(
    BuildContext context,
    String categoryType,
    String sectionTitle,
  ) {
    final ServiceController _productService = ServiceController();

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Text(
                sectionTitle,
                style: GoogleFonts.tenorSans(
                  textStyle: TextStyle(
                    color: Colors.white70,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  final List<Product> products =
                      await _productService.getProductsByCategoryAndType(
                    categoryType,
                    sectionTitle,
                  );
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (_) => CategoryDetailsPage(
                        categoryTitle: sectionTitle,
                        products: products,
                      ),
                    ),
                  );
                },
                child: Text(
                  'See All',
                  style: GoogleFonts.tenorSans(
                    textStyle:
                        TextStyle(color: Colors.white70, fontSize: 12.sp),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 2.h),
        FutureBuilder<List<Product>>(
          future: _productService.getProductsByCategoryAndType(
            categoryType,
            sectionTitle,
          ),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final List<Product> products = snapshot.data!;
              return SizedBox(
                height: 37.h,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: products
                      .map(
                        (e) => Padding(
                          padding: EdgeInsets.only(left: 6.w, right: 6.w),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ProductDetails(product:e),
                                ),
                              );
                            },
                            child: HomeListItem(product: e),
                          ),
                        ),
                      )
                      .toList(),
                ),
              );
            } else if (snapshot.hasError) {
              return Text('Error fetching products');
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ],
    );
  }
}
