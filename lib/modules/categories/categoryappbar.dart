import 'package:easybuy/modules/Home/View/HomeAppBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../cart/controller/cart_controller.dart';

import '../wishlist/wishlist.dart';


class Categoryappbar extends StatelessWidget {
  Categoryappbar({super.key});
  final controller = Get.find<CartController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      // color: Colors.indigo[500],
      padding: EdgeInsets.only(left: 15, right: 8,top: 20),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              'Categories',
              style: TextStyle(
                color: Colors.indigo[500],
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Spacer(),
          IconButton(
              onPressed: () {
                Get.to(WishlistPage());
              },
              icon: Icon(
                Icons.favorite_border,
                size: 32,
                color: Colors.indigo,
              )),
          carticon(controller: controller, color: Colors.indigo,)
        ],
      ),
    );
  }
}
