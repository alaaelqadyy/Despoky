import 'package:Despoky/utilities/routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import 'controllers/service_controller.dart';
import 'models/Product.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  List<Product> _searchResults = [];

  void _performSearch(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
      });
    } else {
      try {
        final results = await ServiceController(context).search(query);
        setState(() {
          _searchResults = results.cast<Product>();
        });
      } catch (error) {
        print('Search Error: $error');
        // Handle search error
      }
    }
  }



  void _navigateToProductDetails(Product product) {
    Navigator.of(context, rootNavigator: true)
        .pushNamed(AppRoutes.productDetailesPageRoute, arguments: product);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Color(0xFF171725),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 1.w,vertical: 1.h),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              onChanged: _performSearch,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16.sp,
              ),
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
                hintText: 'Search',
                hintStyle:GoogleFonts.tenorSans(
                  textStyle:TextStyle(
                    color: Colors.white70,
                    fontSize: 17.sp,
                  ),
                ),
                prefixIcon:
                Icon(Icons.search, color: Colors.white, size: 6.w),
                suffixIcon: IconButton(
                  icon: Icon(Icons.close, color: Colors.white, size: 6.w),
                  onPressed: () {
                    _searchController.clear();
                    _performSearch('');
                  },
                ),
              ),
            ),

            SizedBox(height: 1.h,),

            Expanded(
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  Product product = _searchResults[index];
                  return Padding(
                    padding: EdgeInsets.only( left: 1.w),
                    child: ListTile(
                      leading: Container(
                        color: Colors.white,
                        child: Image.asset(
                          product.image[0],
                          width: 15.w,
                          height: 15.w,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      title: Text(
                        product.name,
                        style: TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp,
                        ),
                      ),
                      subtitle: Text(
                        '${product.price} \$',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12.sp,
                        ),
                      ),
                      onTap: () {
                        _navigateToProductDetails(product);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}