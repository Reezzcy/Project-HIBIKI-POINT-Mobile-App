import 'package:flutter/material.dart';
import 'package:project_hibiki_point_mobile_app/res/colors.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size _screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryWhite,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  _backgroundContainer(_screenSize),
                ],
              )
            ],
          ),
        ),
      )
    );
  }

  Widget _backgroundContainer(Size screenSize) {
    return Positioned(
      top: 0,
      child: Container(
        width: screenSize.width,
        height: screenSize.height * 0.24,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black12,
              Colors.black26,
            ],
            stops: [0.1, 1],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
      ),
    );
  }
}