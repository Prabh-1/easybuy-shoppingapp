import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'categoriespage.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: fetchCategories(), // Function to fetch categories
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          // Categories fetched successfully
          final categories = snapshot.data!;
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (var category in categories)
                  GestureDetector(
                    onTap: () {
                      Get.to(() => CategoriesPage(category: category)); // Navigate to CategoriesPage with the selected category
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/${category.toLowerCase()}.png', // Assuming images are named after category names
                            width: 40,
                            height: 40,
                          ),
                          SizedBox(width: 4),
                          Text(
                            category,
                            style: TextStyle(
                              color: Colors.indigo[500],
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
              ],
            ),
          );
        } else {
          return Text('No data available');
        }
      },
    );
  }

  Future<List<String>> fetchCategories() async {
    final response = await http.get(Uri.parse('https://dummyjson.com/products/categories'));
    print(response.body);
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map<String>((category) => category.toString()).toList();
    } else {
      throw Exception('Failed to fetch categories');
    }
  }
}
