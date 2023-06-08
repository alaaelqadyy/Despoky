import 'package:Despoky/shared/favorite_list_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import 'package:Despoky/models/add_to_cart.dart';
import '../../controllers/service_controller.dart';
import '../shared/cart_list_items.dart';
import '../utilities/routes.dart';
import '../../models/add_to_favorite.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late ServiceController _serviceController ;

  List<AddToCartModel> cartItems = [];
  List<FavoriteProduct> favoriteItems = [];

  @override
  void initState() {
    super.initState();
    _serviceController = ServiceController(context);
    fetchCartItems();
    fetchFavoriteItems();
  }

  Future<void> fetchCartItems() async {
    try {
      List<AddToCartModel> items = await _serviceController.getCart();
      setState(() {
        cartItems = items;
      });
    } catch (error) {
      // Handle error
      print('Error fetching cart items: $error');
    }
  }

  Future<void> fetchFavoriteItems() async {
    try {
      List<FavoriteProduct> items =  await _serviceController.getFavorites();
      setState(() {
        favoriteItems = items;
      });
    } catch (error) {
      // Handle error
      print('Error fetching favorite items: $error');
    }
  }

  double calculateSubtotal() {
    double subtotal = 0.0;
    for (var item in cartItems) {
      subtotal += item.price;
    }
    return subtotal;
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Color(0xFF171725),
      child: DefaultTabController(
        length: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 2.h,
            ),
            SizedBox(
              width: 70.w,
              child: TabBar(
                labelColor: Colors.white,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorPadding: EdgeInsets.symmetric(horizontal: 6.w),
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(
                    width: 0.3.w,
                    color: Colors.white,
                  ),
                ),
                unselectedLabelColor: Colors.white60,
                tabs: [
                  Tab(
                    child: Text(
                      'SHOPPING BAG',
                      style: GoogleFonts.tenorSans(
                        textStyle: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'FAVOURITES',
                      style: GoogleFonts.tenorSans(
                        textStyle: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 3.w, right: 3.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 2.h,
                              ),
                              SizedBox(
                                child: ListView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  children: cartItems
                                      .map(
                                        (item) => Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: cartListItems(cartItem: item),
                                    ),
                                  )
                                      .toList(),
                                ),
                              ),
                              Container(
                                width: 100.w,
                                height: 0.2.h,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'SUB TOTAL : \$${calculateSubtotal().toStringAsFixed(2)}',
                                        style: GoogleFonts.tenorSans(
                                          color: Colors.white,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context, rootNavigator: true)
                                          .pushNamed(
                                          AppRoutes.checkoutPageRoute);
                                    },
                                    child: Text(
                                      'CHECKOUT',
                                      style: GoogleFonts.tenorSans(
                                        textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.h),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        if (favoriteItems.isEmpty)
                          Text('No favorites found.')
                        else
                          SizedBox(
                          child: ListView(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            children: favoriteItems
                                .map(
                                  (item) => Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: FavoriteListItem(favoriteItem: item),
                              ),
                            )
                                .toList(),
                          ),
                        ),
                      ],
                    ),
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
