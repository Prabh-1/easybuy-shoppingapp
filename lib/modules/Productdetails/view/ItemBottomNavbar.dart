
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../cart/model/cartitems.dart';
import '../Controller/quantitycontroller.dart';
import '../../cart/controller/cart_controller.dart';
import '../../cart/views/CartPage.dart';

class ItemBottomNavBar extends StatelessWidget {
  const ItemBottomNavBar({
    Key? key,
    required this.price,
    required this.title,
    required this.discountPercentage,
    required this.brand,
    required this.category,
    required this.image,
  }) : super(key: key);

  final int price;
  final String title;
  final double discountPercentage;
  final String brand;
  final String category;
  final String image;

  @override
  Widget build(BuildContext context) {
    final QuantityController quantityController = Get.find();

    return Container(
      height: 70,
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.indigo[500],
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '\$ $price',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              CartItem item = CartItem(
                price: price,
                title: title,
                discountPercentage: discountPercentage,
                brand: brand,
                category: category,
                image: image,
                quantity: quantityController.quantity.value,
              );
              print(item.quantity.toString());
              final cartController = Get.find<CartController>();
              cartController.addItemToCart(item);
              Get.to(CartPage());
              quantityController.quantity.value = 1;
            },
            icon: Icon(
              Icons.add_shopping_cart_rounded,
              color: Colors.indigo[500],
              size: 30,
            ),
            label: Text(
              'Add to Cart',
              style: TextStyle(
                color: Colors.indigo[500],
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white),
              padding: MaterialStateProperty.all(EdgeInsets.all(10)),
            ),
          ),
        ],
      ),
    );
  }
}





