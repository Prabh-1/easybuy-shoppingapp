import 'package:easybuy/connectivity%20status.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/cart_controller.dart';
import 'CartAppBar.dart';
import 'cartbottomnav.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CartController controller = Get.find<CartController>();


    return ConnectivityStatusWidget(
      child: Scaffold(
        body: Column(
          children: [
            const CartAppBar(),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [

                  Container(
                    height: 1000,
                    padding: const EdgeInsets.only(top: 15),
                    decoration: BoxDecoration(
                      color: Colors.indigo[100],
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Obx(
                            () => controller.cartItems.isEmpty
                                ? Text(
                                  'Oops!, \nYour Cart is empty',
                                  style: TextStyle(fontSize: 20),
                                  textAlign: TextAlign.center,
                                )
                                : Column(
                                    children: controller.cartItems.map((item) {

                                      return Card(
                                        elevation: 4,
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 10),
                                        child: Container(
                                          padding: const EdgeInsets.all(16),
                                          child: Row(
                                            children: [
                                              CircleAvatar(
                                                backgroundImage:
                                                    NetworkImage(item.image),
                                              ),
                                              SizedBox(width: 16),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      item.title,
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight: FontWeight.bold),
                                                    ),
                                                    SizedBox(height: 5),
                                                    Text('Price: \$${item.price}'),
                                                    Text('Brand: ${item.brand}'),
                                                    Text('Category: ${item.category}'),
                                                  ],
                                                ),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  IconButton(
                                                    icon: Icon(Icons.delete_outline,
                                                        color: Colors.red, size: 30),
                                                    onPressed: () {
                                                      controller
                                                          .removeItemFromCart(item);
                                                    },
                                                  ),
                                                  SizedBox(height: 10),
                                                  Row(
                                                    children: [
                                                      IconButton(
                                                        icon: Container(
                                                          child: Icon(Icons.remove,
                                                              color: Colors.white,
                                                              size: 20),
                                                          decoration: BoxDecoration(
                                                            shape: BoxShape.circle,
                                                            color: Colors.indigo[300],
                                                          ),
                                                          padding: EdgeInsets.all(3),
                                                        ),
                                                        onPressed: () {
                                                          controller
                                                              .decrementQuantity(item);
                                                        },
                                                      ),
                    Obx(() =>
                                                      Text(
                                                        '${controller.itemQuantities[item.title]?.value ?? 0}',
                                                        style: TextStyle(
                                                          color: Colors.indigo,
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 25,
                                                        ),
                                                      ),
                    ),
                                                      IconButton(
                                                        icon: Container(
                                                          child: Icon(Icons.add,
                                                              color: Colors.white,
                                                              size: 20),
                                                          decoration: BoxDecoration(
                                                            shape: BoxShape.circle,
                                                            color: Colors.indigo[300],
                                                          ),
                                                          padding: EdgeInsets.all(3),
                                                        ),
                                                        onPressed: () {
                                                          controller
                                                              .incrementQuantity(item);
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavbar(
          totalprice : controller.totalPrice,
        ),
      ),
    );
  }
}
