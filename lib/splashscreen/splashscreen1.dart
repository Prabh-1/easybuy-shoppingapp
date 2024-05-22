
import 'package:easybuy/splashscreen/splashscreen2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Splash1Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 5), () {
     Get.off(Splash2Screen()); // Navigate to the second splash screen
    });

    return Scaffold(
      body: Center(
          child: Image.asset('assets/images/logo eb.png')
      ),
    );
  }
}