import 'package:easybuy/connectivity%20status.dart';
import 'package:flutter/material.dart';

import 'CategoryAppBar.dart';
import '../ItemsWidget.dart';

class CategoriesPage extends StatelessWidget {
  final String category;

  const CategoriesPage({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConnectivityStatusWidget(
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            CategoryAppBar(
              category: category,
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(top: 20),
                color: Colors.indigo[200],
                child: ItemsWidget(
                  category: category,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
