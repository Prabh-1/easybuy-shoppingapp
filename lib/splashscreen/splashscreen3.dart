
import 'package:easybuy/splashscreen/splashscreen4.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class Splash3Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    return Scaffold(
        body: Stack(
          children: [
            Container(
              height: 1000,
              color: Colors.white,

            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: ClipPath(
                clipper: DiagonalPathClipperOne(height: 300), // Set the height of the clipper
                child: Container(
                  height: 450,
                  color: Colors.indigo,
                ),
              ),
            ),
            Positioned(
                right: 20,
                top: 95,
                child: Text('TRACK YOUR\nORDER',textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,)
                )
            ),
            Positioned(
                bottom: 50,
                right: 50,
                child: Image.asset('assets/images/tracking.jpg',alignment: Alignment.center,
                  height: 380,
                  width: 380,)),
            Positioned(
              right: 20,
              bottom: 10,
              child:ElevatedButton(onPressed: () { Get.to(Splash4Screen()); },
                child: Text('Next',style: TextStyle(
                  fontSize: 20,
                ),),),

            ),
          ],
        )

    );
  }
}

class DiagonalPathClipperOne extends CustomClipper<Path> {
  final double height;

  DiagonalPathClipperOne({this.height = 100});
  @override
  Path getClip(Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width*1.0016667,size.height*0.5028571);
    path_0.lineTo(size.width*1.0016667,size.height*-0.0028571);
    path_0.lineTo(size.width*-0.0025000,size.height*-0.0042857);
    path_0.lineTo(size.width*-0.0016667,size.height*0.3271429);

    path_0.close();
    return path_0;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}