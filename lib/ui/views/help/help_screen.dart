import 'package:flutter/material.dart';
import 'package:project_hibiki_point_mobile_app/res/colors.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryWhite,
        body: Text('Help Screen'),
      )
    );
  }
}