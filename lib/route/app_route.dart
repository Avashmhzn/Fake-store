
import 'package:fake_store_v2/view/cart_page.dart';
import 'package:fake_store_v2/view/products_list_page.dart';
import 'package:flutter/material.dart';

class AppRoute {
  navigateToCart(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => const CartPage(),
      ),
    );
  }

  navigateToPageList(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => const ProductListPage(),
      ),
    );
  }
}