import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'ItemsWidget.dart';

class SeeAll extends StatelessWidget {
  const SeeAll({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              color: Colors.indigo[100],
              child: Padding(
                padding: const EdgeInsets.only(top: 38),
                child: Column(
                  children: [
                    ItemsWidget(limit: null), // Add space for the fixed arrow button
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 35,
            left: 10,
            child:
            Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                color: Colors.indigo[500],
                borderRadius: BorderRadius.circular(30),
              ),
              child: IconButton(
                onPressed: Get.back, // Assuming you're using GetX for navigation
                icon: Icon(Icons.arrow_back, color: Colors.white, size: 20,),
              ),
            ),
          ),
        ],
      ),
    );
  }
}