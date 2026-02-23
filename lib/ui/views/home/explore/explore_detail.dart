import 'package:flutter/material.dart';
import 'package:hibiki_point/ui/views/home/explore/explore_screen.dart';

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