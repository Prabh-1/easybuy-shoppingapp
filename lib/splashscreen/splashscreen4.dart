
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../login/login.dart';


class Splash4Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body:Stack(
          children: [
            // White Container
            Container(
              height: 1000,
              color: Colors.white,
            ),

            // ClipPath with Diagonal Clipper
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: ClipPath(
                clipper: DiagonalPathClipperTwo(height: 300), // Set the height of the clipper
                child: Container(
                  height: 550,
                  color: Colors.indigo[400],
                ),
              ),
            ),
            Positioned(
              top: 180,
              left: 0,
              right: 0,
              child: Container(
                height: 400,
                child: Image.asset(
                  'assets/images/tracking.png',
                  height: 250,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Positioned(
                left: 20,
                bottom: 120,
                child: Text('DELIVERED',textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,)
                )
            ),
            Positioned(
              right: 20,
              bottom: 10,
              child:ElevatedButton(onPressed: () { Get.offAll(WelcomeScreen()); },
                child: Text('Next',style: TextStyle(
                  fontSize: 20,
                ),),),

            ),
          ]
      ),

    );
  }
}
class DiagonalPathClipperTwo extends CustomClipper<Path> {
  final double height;

  DiagonalPathClipperTwo({this.height = 100});
  @override
  Path getClip(Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width*-0.0016667,size.height*0.4271429);
    path_0.lineTo(size.width*-0.0016667,size.height*1.0028571);
    path_0.lineTo(size.width*1.0016667,size.height*1.0028571);
    path_0.lineTo(size.width*1.0025000,size.height*0.6471429);
    path_0.close();
    return path_0;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}