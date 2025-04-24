import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_hibiki_point_mobile_app/res/colors.dart';

class TaskScreen extends StatelessWidget{
  const TaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.primaryWhite,
          body: Text('Task Screen'),
        )
    );
  }
}