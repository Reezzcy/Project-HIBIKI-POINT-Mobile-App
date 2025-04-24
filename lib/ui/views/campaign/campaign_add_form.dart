import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_hibiki_point_mobile_app/res/colors.dart';

class CampaignAddForm extends StatelessWidget {
  const CampaignAddForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryWhite,
        body: Text('Form Campaign'),
      )
    );
  }
}