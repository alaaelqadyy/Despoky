import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../controllers/service_controller.dart';
import '../utilities/routes.dart';
import '../models/Product.dart';

class CategoryListItems extends StatefulWidget {
  final Product product;

  const CategoryListItems({Key? key, required this.product}) : super(key: key);

  @override
  _CategoryListItemsState createState() => _CategoryListItemsState();
}

class _CategoryListItemsState extends State<CategoryListItems> {
  bool isFavorite = false;
  bool isAddedToCart = false;
  final ServiceController _productService = ServiceController();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context, rootNavigator: true).pushNamed(
        AppRoutes.productDetailesPageRoute,
        arguments: widget.product,
      ),
      child: SizedBox(
        child: Card(
          elevation: 2,
          color: Color(0xFF171725),
          child: Row(
            children: [
              Container(
                color: Colors.white70,
                child: Image(
                  image: AssetImage('${widget.product.image[0]}'),
                  width: 25.w,
                  height: 35.w,
                  fit: BoxFit.fitWidth,
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ' ${widget.product.name}',
                      style: GoogleFonts.tenorSans(
                        textStyle:
                        TextStyle(color: Colors.white, fontSize: 17.sp),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      ' ${widget.product.description}',
                      style: GoogleFonts.tenorSans(
                        textStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 12.sp,
                        ),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      " ${widget.product.price} \$",
                      style: GoogleFonts.tenorSans(
                        textStyle:
                        TextStyle(color: Colors.white, fontSize: 12.sp),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            if (isAddedToCart) {
                              // Remove from cart
                              _productService.removeFromCart(
                                'userId',
                                widget.product.id,
                              );
                              setState(() {
                                isAddedToCart = false;
                              });
                            } else {
                              // Add to cart
                              _productService.addToCart(
                                'userId',
                                widget.product.id,
                              );
                              setState(() {
                                isAddedToCart = true;
                              });
                            }
                          },
                          child: Text(
                            isAddedToCart ? "REMOVE FROM CART" : "ADD TO CART",
                            style: GoogleFonts.tenorSans(
                              textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 8.sp,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              isFavorite = !isFavorite;
                            });
                          },
                          icon: Icon(
                            isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: isFavorite ? Colors.red : Colors.white,
                            size: 3.5.h,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
