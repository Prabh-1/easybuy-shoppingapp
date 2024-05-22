import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../Home/View/Categories/categoriespage.dart';
import 'categoryappbar.dart';

class CategoriesWidget2 extends StatelessWidget {
  const CategoriesWidget2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[100],
      body: Column(
        children: [
          Categoryappbar(),
          FutureBuilder<List<String>>(
            future: fetchCategories(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                final categories = snapshot.data!;
                return Expanded(
                  child: Container(
                    // color: Colors.indigo[100],
                    child: ListView.builder(
                      padding: EdgeInsets.only(bottom: 20),
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        return GestureDetector(
                          onTap: () {
                            Get.to(() => CategoriesPage(category: category));
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [ Colors.white,
                                  Colors.indigo,],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(  color: Colors.white60,
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(-5, -5),),
                                BoxShadow(
                                  color: Colors.blueGrey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(5, 5),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(child: Image.asset('assets/images/${category.toLowerCase()}.png'),radius: 30,
                                backgroundColor: Colors.white),
                                
                                SizedBox(width: 16),
                                Expanded(
                                  child: Text(
                                    category.toUpperCase(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              }  else {
                return Center(child: Text('No data available'));
              }
            },
          ),
        ],
      ),
    );
  }

  Future<List<String>> fetchCategories() async {
    final response = await http.get(Uri.parse('https://dummyjson.com/products/categories'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map<String>((category) => category.toString()).toList();
    } else {
      throw Exception('Failed to fetch categories');
    }
  }
}

