import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:easybuy/connectivity%20status.dart';
import 'package:easybuy/modules/account/account%20screen.dart';

import 'package:easybuy/modules/categories/categoriesview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/itemcontroller.dart';
import 'Categories/CategoriesWidget.dart';
import 'HomeAppBar.dart';
import 'ItemsWidget.dart';
import 'seeall.dart';

class HomePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final RxInt selectedIndex = 1.obs;
  final ItemsController controller = Get.put(ItemsController());

  @override
  Widget build(BuildContext context) {
    return ConnectivityStatusWidget(
      child: Scaffold(
        key: _scaffoldKey,
        body: Obx(() {
          if (selectedIndex.value == 1) {
            return Column(
              children: [
                HomeAppBar(scaffoldKey: _scaffoldKey),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 20),
                        decoration: BoxDecoration(
                          color: Colors.indigo[100],
                        ),
                        child: Column(
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.search,
                                    color: Colors.indigo[500],
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 5),
                                      height: 50,
                                      child: TextFormField(
                                        controller: controller.searchController,
                                        onChanged: controller.filterProducts,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Search here...',
                                            hintStyle: TextStyle(
                                                color: Colors.indigo[600])),
                                      ),
                                    ),
                                  ),
                                  Icon(Icons.camera_alt_rounded,
                                      color: Colors.indigo[500]),
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: const EdgeInsets.symmetric(
                                vertical: 20,
                                horizontal: 10,
                              ),
                              child: Text(
                                'Categories',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.indigo[500],
                                ),
                              ),
                            ),
                            const CategoriesWidget(),
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: const EdgeInsets.symmetric(
                                vertical: 20,
                                horizontal: 10,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Best Selling',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.indigo[500],
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Get.to(() => const SeeAll());
                                    },
                                    child: Text(
                                      'See All',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.indigo[500],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ItemsWidget(limit: 4),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          } else if (selectedIndex.value == 0) {
            return CategoriesWidget2();
          } else {
            return AccountScreen();
          }
        }),
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.indigo[100]!,
          onTap: (index) {
            selectedIndex.value = index; // Changed to 'value'
          },
          height: 60,
          color: Colors.indigo[500]!,
          items: const [
            Icon(Icons.list,
                size: 35,
                color: Colors.white), // Moved Home to the second position
            Icon(Icons.home,
                size: 35,
                color: Colors.white), // Home icon is now in the center
            Icon(Icons.person_outline, size: 35, color: Colors.white),
          ],
          index: 1, // Set the initial index to 1 (Home)
        ),
        drawer: CustomDrawer(),
      ),
    );
  }
}
