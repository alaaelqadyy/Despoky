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

  @override
  void initState() {
    super.initState();
    _productService =
        ServiceController(context); // Initialize the service controller
  }

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

  Future<void> removeFromCart() async {
    try {
      await _productService.removeFromCart(
          _productService.authController.getCurrentUser()!.uid,
          widget.cartItem.id);
      setState(() {
        cartItems.remove(widget.cartItem);
      });

    } catch (error) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text(error.toString()),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }
  }

  int getTotalPrice() {
    return widget.cartItem.price * quantity;
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
            Container(
              color: Colors.white,
              child: Image.asset(
                widget.cartItem.image,
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
                  SizedBox(height: 1.h,),
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
                        onPressed: removeFromCart,
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
                      Text(
                        quantity.toString(),
                        style: GoogleFonts.tenorSans(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 11.sp,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: incrementQuantity,
                        icon: Icon(
                          Icons.add_circle_outlined,
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