import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:project_hibiki_point_mobile_app/data/models/user_model.dart';
import 'package:project_hibiki_point_mobile_app/res/colors.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  UserModel user = dummyUser;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryWhite,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _profileSection(),
              _menuSection(),
            ],
          ),
        ),
      )
    );
  }

  Widget _profileSection() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            radius: 20,
            backgroundImage: MemoryImage(base64Decode(user.avatar_base64)),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Hello!',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                Text(
                  user.name,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _menuSection() {
    return Container(
      color: AppColors.primaryDarkBlue,
      child: Row(
        children: <Widget>[],
      ),
    );
  }
}