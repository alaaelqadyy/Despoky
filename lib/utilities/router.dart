import 'package:Despoky/utilities/routes.dart';
import 'package:flutter/cupertino.dart';

import '../bottomNavbar.dart';
import '../category_detailes.dart';
import '../checkout/add_shipping_address_screen.dart';
import '../checkout/checkout_screen.dart';
import '../delete_profile.dart';
import '../edit_profile.dart';
import '../landingPage.dart';
import '../login_screen.dart';
import '../models/Product.dart';
import '../product_detailes.dart';
import '../profile.dart';
import '../register_screen.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.deleteProfilePageRoute:
      return CupertinoPageRoute(
        builder: (_) => DeleteProfile(),
        settings: settings,
      );

    case AppRoutes.addAddressPageRoute:
      return CupertinoPageRoute(
        builder: (_) => AddShippingAddressPage(),
        settings: settings,
      );

    case AppRoutes.checkoutPageRoute:
      return CupertinoPageRoute(
        builder: (_) {
          final subtotal = settings.arguments as double;
          return CheckoutPage(subtotal: subtotal);
        },
        settings: settings,
      );

    case AppRoutes.categoryDetailesPageRoute:
      final arguments = settings.arguments as Map<String, dynamic>;
      final categoryTitle = arguments['categoryTitle'] as String;
      final products = arguments['products'] as List<Product>;

      return CupertinoPageRoute(
        builder: (_) => CategoryDetailsPage(
          categoryTitle: categoryTitle,
          products: products,
        ),
        settings: settings,
      );

    case AppRoutes.productDetailesPageRoute:
      final product = settings.arguments as Product;

      return CupertinoPageRoute(
        builder: (_) => ProductDetails(product: product),
        settings: settings,
      );

    case AppRoutes.editProfilePageRoute:
      return CupertinoPageRoute(
        builder: (_) => EditProfilePage(),
        settings: settings,
      );

    case AppRoutes.profileDetailesPageRoute:
      return CupertinoPageRoute(
        builder: (_) => ProfileScreen(),
        settings: settings,
      );

    case AppRoutes.loginPageRoute:
      return CupertinoPageRoute(
        builder: (_) => const LoginScreen(),
        settings: settings,
      );

    case AppRoutes.registerPageRoute:
      return CupertinoPageRoute(
        builder: (_) => const RegisterScreen(),
        settings: settings,
      );

    case AppRoutes.bottomNavBarPageRoute:
      return CupertinoPageRoute(
        builder: (_) => CustomNavbar(),
        settings: settings,
      );

    case AppRoutes.landingPageRoute:
    default:
      return CupertinoPageRoute(
        builder: (_) => const landingPage(),
        settings: settings,
      );
  }
}
