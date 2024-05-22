import 'package:easybuy/login/login.dart';
import 'package:easybuy/modules/account/profile_controller.dart';
import 'package:easybuy/modules/account/profilescreen.dart';
import 'package:easybuy/modules/cart/views/CartPage.dart';
import 'package:easybuy/modules/wishlist/wishlist.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getUsername(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While the future is resolving, show a loading indicator
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          // If there's an error retrieving the username, show an error message
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          // If the username is successfully retrieved, build the UI with the username
          final String? username = snapshot.data;
          return AccountScreenContent(username: username);
        }
      },
    );
  }

  Future<String> getUsername() async { // Changed to return non-nullable Future<String>
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('username') ?? ''; // Ensure a non-null value is returned
  }
}

class AccountScreenContent extends StatelessWidget {
  final String? username;
  final ProfileController _profileController = Get.put(ProfileController());

   AccountScreenContent({Key? key, this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[100],
      body: Padding(
        padding: const EdgeInsets.only(top: 40, left: 15, right: 15, bottom: 10),
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Hey,',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo,
                          ),
                        ),
                        Obx(() {
                          final username = _profileController.userName.value;
                          return Text(
                            username.isNotEmpty ? username : 'User',
                            style: TextStyle(
                              fontSize: 45,
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo,
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.indigo,
                    child: _profileController.imageFile.value != null
                        ? ClipOval(
                      child: Image.file(
                        _profileController.imageFile.value!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    )
                        : username != null && username!.isNotEmpty
                        ? Text(
                      username!.substring(0, 1).toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                      ),
                    )
                        : Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 50,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Divider(
                    thickness: 0.5,
                    color: Colors.indigo,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Obx(() {
                    final email = _profileController.email.value;
                    final contactNumber = _profileController.contactNumber.value;
                    return Text(
                      'Login via ${email.isNotEmpty ? email : contactNumber}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                      ),
                    );
                  }),
                ),
                Expanded(
                  child: Divider(
                    color: Colors.indigo,
                    thickness: 0.5,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: buildMenuItem(
                Icons.shopping_cart,
                'Your Cart',
                    () {
                  Get.to(()=> CartPage());
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: buildMenuItem(
                Icons.favorite,
                'Your Wishlist',
                    () {
                 Get.to(()=> WishlistPage());
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: buildMenuItem(
                Icons.person,
                'Your Profile',
                    () {
                  Get.to(()=> ProfileApp());
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: buildMenuItem(
                Icons.settings,
                'Settings',
                    () {
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: buildMenuItem(
                Icons.logout,
                'Logout',
                    () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Logout'),
                        content: Text('Are you sure you want to logout?'),
                        actions: [
                          TextButton(
                            onPressed: () async {
                              // Perform logout operation here
                              Navigator.pop(context); // Close the dialog
                              // Navigate to login screen
                              try {
                                final SharedPreferences prefs = await SharedPreferences.getInstance();
                                await prefs.clear();
                                await FirebaseAuth.instance.signOut();
                                Get.offAll(() => WelcomeScreen());
                              } catch (e) {
                                print('Error logging out: $e');
                                // Optionally, you can show a snackbar or dialog here to notify the user of the error.
                              }
                            },
                            child: Text('OK'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context); // Close the dialog
                            },
                            child: Text('Cancel'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem(IconData icon, String label, VoidCallback onTap) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20),
          leading: Text(
            label,
            style: TextStyle(
              fontSize: 20,
              color: Colors.indigo,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: Icon(
            icon,
            color: Colors.indigo,
            size: 30,
          ),
          onTap: onTap,
        ),
        Divider(
          color: Colors.indigo,
        ),
      ],
    );
  }
}
