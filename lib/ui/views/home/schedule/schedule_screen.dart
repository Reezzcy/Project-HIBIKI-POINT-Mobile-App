import 'package:flutter/material.dart';
import 'package:project_hibiki_point_mobile_app/res/colors.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryWhite,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text('Schedule Screen')
            ],
          ),
        ),
      )
    );
  }
}