import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:project_hibiki_point_mobile_app/splash_screen.dart';

void main() {
  initializeDateFormatting('id_ID', null).then((_) {
    runApp(const HibikiPointApp());
  });
}

class HibikiPointApp extends StatelessWidget {
  const HibikiPointApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HIBIKI POINT',
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
