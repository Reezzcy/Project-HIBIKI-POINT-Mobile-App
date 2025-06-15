import 'package:flutter/material.dart';
import 'package:project_hibiki_point_mobile_app/ui/views/home/explore/explore_screen.dart';

class ExploreDetail extends StatefulWidget {
  final campaign;
  const ExploreDetail({Key? key, required this.campaign}) : super(key: key);

  @override
  State<ExploreDetail> createState() => _ExploreDetailState();
}

class _ExploreDetailState extends State<ExploreDetail> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Text('Explore Detail'),
      )
    );
  }
}