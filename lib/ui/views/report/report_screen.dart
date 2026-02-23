import 'package:flutter/material.dart';
import 'package:hibiki_point/res/colors.dart';

class ReportScreen extends StatelessWidget{
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.primaryWhite,
          body: Text('Report Screen'),
        )
    );
  }
}