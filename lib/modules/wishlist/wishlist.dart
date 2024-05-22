import 'package:easybuy/connectivity%20status.dart';
import 'package:easybuy/modules/wishlist/wishlistappbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model.dart';
import '../Home/controller/itemcontroller.dart';
import '../Productdetails/view/ItemPage.dart'; // Import the ItemPage

class WishlistPage extends StatelessWidget {
  const WishlistPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ItemsController itemsController = Get.find<ItemsController>();

    return ConnectivityStatusWidget(
      child: Scaffold(
        body: Column(
          children: [
            WishlistAppBar(),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 10),
                color: Colors.indigo[100],
                child: Obx(
                      () {
                    final List<Product> favoriteProducts = itemsController.products
                        .where((product) => itemsController.isProductFavorite(product.id))
                        .toList();

                    if (favoriteProducts.isEmpty) {
                      return Center(
                        child: Text('Your wishlist is empty.'),
                      );
                    }

                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: favoriteProducts.length,
                      itemBuilder: (context, index) {
                        final product = favoriteProducts[index];
                        return GestureDetector(
                          onTap: () {
                            print('on tap');
                            Get.to(() => ItemPage(productId: product.id));
                          },
                          child: Card(
                            elevation: 4,
                            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(product.thumbnail),
                                  ),
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product.title,
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Text('Price: \$${product.price}'),
                                        // Add more details if needed
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      itemsController.toggleFavorite(product.id);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
