import 'dart:async';
import 'package:flutter/material.dart';
import 'package:project_hibiki_point_mobile_app/res/assets.dart';
import 'package:project_hibiki_point_mobile_app/res/colors.dart';
import 'package:project_hibiki_point_mobile_app/ui/views/home/home_main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeMain()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primaryDarkBlue, AppColors.primaryCream],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          child: Center(
            child: Image.asset(
              Assets.hibikiPointLogoSplash,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}