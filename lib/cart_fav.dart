import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../models/add_to_cart.dart';
import '../../controllers/service_controller.dart';
import '../shared/cart_list_items.dart';
import '../utilities/routes.dart';

class CartScreen extends StatelessWidget {
  final ServiceController _serviceController = ServiceController();

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
              width: 70.w,
              child: TabBar(
                labelColor: Colors.white,
                indicatorSize: TabBarIndicatorSize.label,
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
                      'MY CART',
                      style: GoogleFonts.tenorSans(
                        textStyle: TextStyle(
                          fontSize: 12.sp,
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
                          fontSize: 12.sp,
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
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  children: cartItem
                                      .map(
                                        (e) => Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: cartListItems(cartItem: e),
                                    ),
                                  )
                                      .toList(),
                                ),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Container(
                                width: 100.w,
                                height: 0.2.h,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'SUB TOTAL : ',
                                    style: GoogleFonts.tenorSans(
                                      color: Colors.white,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                  Text(
                                    '1056\$',
                                    style: GoogleFonts.tenorSans(
                                      color: Colors.white,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Container(
                          width: 100.w,
                          height: 8.h,
                          child: TextButton(
                            style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all<Color>(
                                  Colors.white),
                            ),
                            onPressed: () {
                              Navigator.of(context, rootNavigator: true)
                                  .pushNamed(AppRoutes.checkoutPageRoute);
                            },
                            child: Text(
                              'CHECKOUT',
                              style: GoogleFonts.tenorSans(
                                textStyle: TextStyle(
                                  color: Color(0xFF171725),
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        FutureBuilder<List<Map<String, dynamic>>>(
                          future: _serviceController.getFavorites(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final favorites = snapshot.data!;
                              if (favorites.isEmpty) {
                                return Text('No favorites found.');
                              }
                              return ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: favorites.length,
                                itemBuilder: (context, index) {
                                  final favorite = favorites[index];
                                  return ListTile(
                                    title: Text(favorite['name']),
                                    // Customize the UI as needed
                                  );
                                },
                              );
                            } else if (snapshot.hasError) {
                              return Text('Error loading favorites.');
                            }
                            return CircularProgressIndicator();
                          },
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