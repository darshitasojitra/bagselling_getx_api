import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'LoginScreen.dart'; // Update this path if needed

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Delay for 3 seconds then navigate
    Timer(Duration(seconds: 5), () {
      Get.off(() => LoginScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[700],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo image
            Image.asset(
              'assets/images/Logo.png', // Replace with your logo path
              height: 150,
              width: 150,
            ),
            SizedBox(height: 30),
            // App Name
            Text(
              "Bag Selling App",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.5,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Quality Bags Delivered Fast",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
