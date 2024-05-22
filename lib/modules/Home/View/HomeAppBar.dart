
import 'package:easybuy/modules/wishlist/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badge;

import 'package:get/get.dart';

import '../../../login/login.dart';
import '../../cart/controller/cart_controller.dart';
import '../../cart/views/CartPage.dart';

class HomeAppBar extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final controller = Get.find<CartController>();

  HomeAppBar({required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.indigo[500],
      padding: EdgeInsets.only(left: 5, right: 8, top: 30),
      child: Row(
        children: [
          Container(padding:EdgeInsets.all(5),decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),border: Border.all(color: Colors.white),),
              child: Image.asset('assets/images/eblogo.png',height: 35,)),
          SizedBox(width: 10,),
          Text(
            'EasyBuy',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
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
                color: Colors.white,
              )),
          carticon(controller: controller, color: Colors.white,),
        ],
      ),
    );
  }
}

class carticon extends StatelessWidget {
  const carticon({
    super.key,
    required this.controller, required this.color,
  });

  final CartController controller;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          onPressed: () {
            Get.to(CartPage());
          },
          icon: Icon(
            Icons.shopping_cart,
            size: 32,
            color: color,
          ),
        ),
        Positioned(
          right: 5,
          top: -2,
          child: badge.Badge(
            badgeStyle: badge.BadgeStyle(
              badgeColor: Colors.red,
            ),
            badgeContent: Obx(
              () => Text(
                '${controller.cartItems.length}',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.indigo[500],
            ),
            child: const UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.transparent),
              accountName: Text(
                "Name",
                style: TextStyle(fontSize: 18),
              ),
              margin: EdgeInsets.only(top: 0),
              accountEmail: Text("email@gmail.com"),
              currentAccountPictureSize: Size.square(50),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  "A",
                  style: TextStyle(fontSize: 25.0, color: Colors.indigo),
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text(' My Profile '),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text(' My Orders '),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.workspace_premium),
            title: const Text(' Go Premium '),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text(' Edit Profile '),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('LogOut'),
            onTap: () {
              Get.offAll(WelcomeScreen());
            },
          ),
          ElevatedButton(
            onPressed: () {
              Get.to(WelcomeScreen());
            },
            child: Text('LogOut'),
          ),
        ],
      ),
    );
  }
}
