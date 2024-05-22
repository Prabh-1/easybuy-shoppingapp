import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartAppBar extends StatelessWidget {
  const CartAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.indigo[800],
      padding: EdgeInsets.only(left: 15, right: 8,top: 20),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back,
              size: 25,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              'Cart',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Spacer(),
          Icon(
            Icons.more_vert,
            color: Colors.white,
            size: 25,
          ),
        ],
      ),
    );
  }
}
