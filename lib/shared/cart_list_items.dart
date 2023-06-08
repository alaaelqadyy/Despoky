import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../models/Product.dart';
import '../models/add_to_cart.dart';
import '../controllers/service_controller.dart';

class cartListItems extends StatefulWidget {
  final AddToCartModel cartItem;

  const cartListItems({Key? key, required this.cartItem}) : super(key: key);

  @override
  _cartListItemsState createState() => _cartListItemsState();
}

class _cartListItemsState extends State<cartListItems> {
  int quantity = 1;
  late final Product product;
  late ServiceController _productService;
  List<AddToCartModel> cartItems = [];

  void incrementQuantity() {
    setState(() {
      if (quantity < widget.cartItem.quantity) {
        quantity++;
      }
    });
  }

  void decrementQuantity() {
    setState(() {
      if (quantity > 1) {
        quantity--;
      }
    });
  }

  Future<void> fetchCartItems() async {
    try {
      List<AddToCartModel> items = await _productService.getCart();
      setState(() {
        cartItems = items;
      });
    } catch (error) {
      // Handle error
      print('Error fetching cart items: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 21.h,
      child: Card(
        elevation: 20,
        color: Color(0xFF171725),
        child: Row(
          children: [
            Placeholder(
              fallbackWidth: 20.w,
            ),
            // Image(image: AssetImage('${cartItem.image}'), width: 20.w,),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        ' ${widget.cartItem.title}',
                        style: GoogleFonts.tenorSans(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 17.sp,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          // Call the removeFromCart method from the controller
                          _productService.removeFromCart('userId', widget.cartItem.productId)
                              .then((_) {
                            fetchCartItems();
                          }).catchError((error) {
                            // Handle error
                            print('Error removing from cart: $error');
                          });
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.white,
                          size: (3.h),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 3.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.cartItem.description}',
                          style: GoogleFonts.tenorSans(
                            textStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 12.sp,
                            ),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          'Size : ${widget.cartItem.size}',
                          style: GoogleFonts.tenorSans(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          "${widget.cartItem.price} \$",
                          style: GoogleFonts.tenorSans(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: decrementQuantity,
                        icon: Icon(
                          Icons.remove_circle_outlined,
                          color: Colors.white,
                          size: 5.w,
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
    );
  }
}
