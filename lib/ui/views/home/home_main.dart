import 'package:flutter/material.dart';
import 'package:project_hibiki_point_mobile_app/res/colors.dart';

class HomeMain extends StatelessWidget {
  const HomeMain({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryWhite,
        body: Text('Home main for bottom nav'),
      )
    );
  }
}