import 'package:easybuy/splashscreen/splashscreen1.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'connectivity status.dart';
import 'modules/cart/controller/cart_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: 'AIzaSyC6Fv7slWxe6HLA7S4D5Y_UL9zckm-bOPU',
          appId: '1:294760191265:android:589af5206d9f9f91d89a60',
          messagingSenderId: '294760191265',
          projectId: 'easybuy-001'));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: ConnectivityStatusWidget(
        child: Splash1Screen(),
      ),
      initialBinding: BindingsBuilder(() {
        Get.put(CartController());
      }),
    );
  }
}
