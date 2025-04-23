import 'package:flutter/material.dart';
import 'package:project_hibiki_point_mobile_app/splash_screen.dart';

void main() {
  runApp(const HibikiPointApp());
}

class HibikiPointApp extends StatelessWidget {
  const HibikiPointApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HIBIKI POINT',
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
