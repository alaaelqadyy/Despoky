import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../utilities/routes.dart';
import '../models/Product.dart';
import '../shared/dropdown_menu.dart';
import '../controllers/service_controller.dart'; // Updated import

class ProductDetails extends StatefulWidget {
  final Product product;

  const ProductDetails({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool isFavorite = false;
  final ServiceController _productService = ServiceController();

  Color parseColor(String colorValue) {
    try {
      int value = int.parse(colorValue, radix: 16);
      return Color(value);
    } catch (e) {
      return Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    int index = widget.product.image.length;
    return SafeArea(
      child: Scaffold(

        body: Container(
          width: 100.w,
          height: 100.h,
          color: Color(0xFF171725),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.topLeft,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                    child: Container(
                      color: Colors.white,
                      width: double.infinity,
                      height: 60.h,


                      child: ListView.builder(
                        //scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(right: 1.w),
                            child: Image.asset(
                              widget.product.image[0],
                             //fit: BoxFit.cover,
                             // width: double.infinity,
                             height: 60.h,
                              errorBuilder: (context, error, stackTrace) {
                                // Handle image loading errors here
                                return Container();
                              },
                            ),
                          );
                        },

                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(AppRoutes.bottomNavBarPageRoute);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      size: 7.w,
                    ),
                  ),
                ],
              ),


              Padding(
                padding: EdgeInsets.symmetric(horizontal:2.w, vertical: 2.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      widget.product.name,
                      style: GoogleFonts.tenorSans(
                        textStyle: TextStyle(color: Colors.white, fontSize: 20.sp),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 20.w,
                          height: 5.h,
                          child: dropDownMenu(), // Assuming dropDownMenu() is a valid method
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              isFavorite = !isFavorite;
                            });
                            if (isFavorite) {
                              _productService.addToFavorites('userId', widget.product.id);
                            } else {
                              _productService.removeFromFavorites('userId', widget.product.id);
                            }
                          },
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : Colors.white,
                            size: 3.h,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Text(
                      widget.product.description,
                      style: GoogleFonts.tenorSans(
                        textStyle: TextStyle(
                          color: Colors.white70,
                          fontSize: 15.sp,
                        ),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Text(
                      "\$ ${widget.product.price}",
                      style: GoogleFonts.tenorSans(
                        textStyle: TextStyle(color: Colors.white, fontSize: 15.sp),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Row(
                      children: [
                        Text(
                          'Color',
                          style: GoogleFonts.tenorSans(
                            textStyle: TextStyle(color: Colors.white, fontSize: 15.sp),
                          ),
                        ),
                        SizedBox(width: 3.w),
                        ...widget.product.color.map(
                              (color) => InkWell(
                            onTap: () {},
                            child: CircleAvatar(
                              backgroundColor: parseColor(color),
                              radius: 2.5.w,
                            ),
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),








              SizedBox(height: 2.h),



              Container(
                width: 100.w,
                height: 8.h,
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF33333f)),
                  ),
                  onPressed: () {
                    _productService.checkout('category', 'type');
                  },
                  child: Text(
                    '+ ADD TO CART',
                    style: GoogleFonts.tenorSans(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 15.sp,
                      ),
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
