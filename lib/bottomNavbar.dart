import 'package:Despoky/profile.dart';
import 'package:Despoky/search.dart';
import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

import 'cart_fav.dart';
import 'home.dart';

class CustomNavbar extends StatefulWidget {
  const CustomNavbar({Key? key,}) : super(key: key);


  @override
  State<CustomNavbar> createState() => _CustomNavbarState();
}

class _CustomNavbarState extends State<CustomNavbar> with SingleTickerProviderStateMixin {
  int _tabIndex = 2;
  int get tabIndex => _tabIndex;
  set tabIndex(int v) {
    _tabIndex = v;
    setState(() {});
  }

  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: _tabIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: CircleNavBar(
        circleColor: Color(0xFF171725),
        circleShadowColor: Colors.white,


        activeIcons: const [
          Icon(Icons.shopping_bag_rounded, color: Colors.white),
          Icon(Icons.search, color: Colors.white),
          Icon(Icons.home, color: Colors.white),
          Icon(Icons.checkroom_rounded, color: Colors.white),
          Icon(Icons.person, color: Colors.white),

        ],
        inactiveIcons: const [
          Icon(Icons.shopping_bag_rounded, color: Colors.grey),
          Icon(Icons.search, color: Colors.grey),
          Icon(Icons.home, color: Colors.grey),
          Icon(Icons.checkroom_rounded, color: Colors.grey),
          Icon(Icons.person, color: Colors.grey),
        ],
        color: Color(0xFF171725),
        height: 60,
        circleWidth: 60,
        activeIndex: tabIndex,
        onTap: (index) {
          tabIndex = index;
          pageController.jumpToPage(tabIndex);
        },
        padding: EdgeInsets.only(left: 2.w, right: 2.w, bottom: 1.h),
        cornerRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
          bottomRight: Radius.circular(24),
          bottomLeft: Radius.circular(24),
        ),
        //shadowColor: Colors.white,
        elevation: 5,
      ),
      body: SafeArea(
        bottom: false,
        child: PageView(
          controller: pageController,
          onPageChanged: (v) {
            tabIndex = v;
          },
          children: [
            CartScreen(),
            SearchPage(),
            HomeScreen(),
            Container(),
            ProfileScreen(),
          ],
        ),
      ),
    );
  }
}