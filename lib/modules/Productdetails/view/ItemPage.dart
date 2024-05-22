import 'package:carousel_slider/carousel_slider.dart';
import 'package:easybuy/connectivity%20status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import '../../../model.dart';
import 'ItemBottomNavbar.dart';
import 'itemappbar.dart';
import 'productdetails.dart';

class ItemPage extends StatelessWidget {
  final int productId;

  ItemPage({Key? key, required this.productId}) : super(key: key);

  Future<Product> _fetchProductDetails() async {
    final response = await http.get(Uri.parse('https://dummyjson.com/products/$productId'));
    if (response.statusCode == 200) {
      final dynamic data = jsonDecode(response.body);
      return Product.fromJson(data);
    } else {
      throw Exception('Failed to load product details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ConnectivityStatusWidget(child:
      FutureBuilder<Product>(
      future: _fetchProductDetails(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final Product product = snapshot.data!;
          return GetBuilder<ItemPageController>(
            init: ItemPageController(),
            builder: (controller) {
              return Scaffold(
                body: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    ItemAppBar(ProductId: productId,),
                    ClipPath(
                      clipper: OvalBottomBorderClipper(),
                      child: Container(
                        height: 350,
                        color: Colors.indigo[100],
                        child: Stack(
                          children: [
                            CarouselSlider(
                              items: product.images.map((image) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return Center(
                                      child: Image.network(
                                        image,
                                        height: 250,
                                        width: 300,
                                      ),
                                    );
                                  },
                                );
                              }).toList(),
                              options: CarouselOptions(
                                height: 270,
                                enlargeCenterPage: true,
                                autoPlay: true,
                                aspectRatio: 16 / 9,
                                autoPlayCurve: Curves.fastOutSlowIn,
                                enableInfiniteScroll: true,
                                autoPlayAnimationDuration: Duration(seconds: 1),
                                onPageChanged: (index, reason) {
                                  controller.setCurrentPage(index);
                                },
                              ),
                            ),
                            Positioned(
                              left: 0,
                              right: 0,
                              bottom: 0,
                              child: Obx(() => Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: product.images.asMap().entries.map((entry) {
                                  return GestureDetector(
                                    onTap: () {
                                      controller.setCurrentPage(entry.key);
                                    },
                                    child: Container(
                                      width: 12.0,
                                      height: 12.0,
                                      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: controller.currentPage == entry.key ? Colors.indigo[400] : Colors.grey,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              )),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ProductDetails(
                      title: product.title,
                      rating: product.rating.toDouble(),
                      description: product.description,
                      discountPercentage: product.discountPercentage.toDouble(),
                      stock: product.stock,
                      brand: product.brand,
                      category: product.category,
                    ),
                  ],
                ),
                bottomNavigationBar: ItemBottomNavBar(
                  price : product.price,
                  title: product.title,
                  discountPercentage: product.discountPercentage.toDouble(),
                  brand: product.brand,
                  category: product.category,
                  image : product.thumbnail,

                ),
              );
            },
          );
        }
      },
      ),
    );
  }
}

class ItemPageController extends GetxController {
  RxInt _currentPage = 0.obs;

  int get currentPage => _currentPage.value;

  void setCurrentPage(int index) {
    _currentPage.value = index;
  }
}
