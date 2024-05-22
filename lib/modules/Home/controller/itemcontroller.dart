import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:easybuy/model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ItemsController extends GetxController {
  var products = <Product>[].obs;
  List<Product> filteredProducts = [];
  TextEditingController searchController = TextEditingController();

  String? selectedCategory;
  @override
  void onInit() {
    super.onInit();
    _fetchProducts();
  }
  void filterProducts(String query) {
    filteredProducts.clear(); // Clear the previous filtered products
    filteredProducts.addAll(products.where((product) {
      return product.title.toLowerCase().contains(query.toLowerCase());
    }));
  }

  Future<void> _fetchProducts() async {
    String url = 'https://dummyjson.com/products';
    if (selectedCategory != null) {
      url = 'https://dummyjson.com/products/category/$selectedCategory';
    }

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['products'];
      products.assignAll(data.map((productJson) => Product.fromJson(productJson)).toList());
    } else {
      throw Exception('Failed to load products');
    }
  }

  void setCategory(String category) {
    selectedCategory = category;
    _fetchProducts();
  }

  void clearCategory() {
    selectedCategory = null;
    _fetchProducts();
  }
  final RxList<int> favoriteProductIds = <int>[].obs;
  void toggleFavorite(int productId) {
    if (favoriteProductIds.contains(productId)) {
      favoriteProductIds.remove(productId);
    } else {
      favoriteProductIds.add(productId);
    }
    print(favoriteProductIds);
  }

  // Method to check if a product is a favorite
  bool isProductFavorite(int productId) {
    return favoriteProductIds.contains(productId);
  }
}
