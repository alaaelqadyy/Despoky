import 'package:Despoky/models/add_to_cart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../controllers/service_controller.dart';
import '../models/add_to_favorite.dart';
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
  late ServiceController _productService;

  @override
  void initState() {
    super.initState();
    _productService = ServiceController(context);
  }


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context, rootNavigator: true).pushNamed(
        AppRoutes.productDetailesPageRoute,
        arguments: widget.product,
      ),
      child: SizedBox(
        child: Card(
          elevation: 20,
          color: Color(0xFF171725),
          child: Row(
            children: [
              Container(
                color: Colors.white,
                child: Image.asset(
                  widget.product.image[0],
                  width: 35.w,
                  height: 40.w,
                  fit: BoxFit.fitWidth,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ' ${widget.product.name}',
                      style: GoogleFonts.tenorSans(
                        textStyle: TextStyle(color: Colors.white, fontSize: 17.sp),
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      "  ${widget.product.price} \$",
                      style: GoogleFonts.tenorSans(
                        textStyle: TextStyle(color: Colors.white, fontSize: 13.sp),
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
                                AddToCartModel(
                                  id: 'productId',
                                  productId: widget.product.id,
                                  description: widget.product.description,
                                  title: widget.product.name,
                                  price: widget.product.price.toInt(),
                                  image: widget.product.image[0],
                                  size: 'default',
                                  quantity: 1,
                                ),
                                'userId',
                              );
                              setState(() {
                                isAddedToCart = true;
                              });
                            }
                          },
                          child: Text(
                            isAddedToCart ? "- REMOVE FROM CART" : "+ ADD TO CART",
                            style: GoogleFonts.tenorSans(
                              textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            setState(() {
                              isFavorite = !isFavorite;
                            });
                            if (isFavorite) {
                              await _productService.addToFavorites(
                                FavoriteProduct(
                                  id: 'favoriteId',
                                  productId: widget.product.id,
                                  description: widget.product.description,
                                  title: widget.product.name,
                                  price: widget.product.price.toInt(),
                                  image: widget.product.image[0],
                                  size: 'default',
                                  quantity: 1,
                                ),
                                'userId',
                              );
                            } else {
                              await _productService.removeFromFavorites(
                                'userId',
                                widget.product.id,
                              );
                            }
                          },
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : Colors.white,
                            size: 3.h,
                          ),
                        ),
                      ],
                    ),
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
