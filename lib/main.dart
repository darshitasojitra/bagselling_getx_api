import 'package:bagselling_getx_api/screen/LoginScreen.dart';
import 'package:bagselling_getx_api/screen/SubcategoryScreen.dart';
import 'package:bagselling_getx_api/screen/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'screen/Categoryscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home:SplashScreen(),
    );
  }
}
