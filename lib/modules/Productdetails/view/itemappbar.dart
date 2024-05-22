import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Home/controller/itemcontroller.dart';

class ItemAppBar extends StatelessWidget {
  const ItemAppBar({super.key, required this.ProductId});
  final int ProductId;

  @override
  Widget build(BuildContext context) {
    final ItemsController itemsController = Get.find<ItemsController>();

    return Container(
      height: 100,
      color: Colors.indigo[500],
      padding: EdgeInsets.only(left: 10, right: 8,top: 25),
      child: Row(
        children: [
          IconButton(
            onPressed: Get.back,
            icon: Icon(
              Icons.arrow_back,
              size: 25,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 20,
            ),
            child: Text(
              'Product',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Spacer(),
          IconButton(
            onPressed: () {
              // Toggle favorite status
              itemsController.toggleFavorite(ProductId);
            },
            icon: Obx(
                  () => CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 15,
                    child: Icon(
                                    itemsController.isProductFavorite(ProductId)
                      ? Icons.favorite
                      : Icons.favorite_border,
                                    color: Colors.red[600],
                      size: 20,
                                  ),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
