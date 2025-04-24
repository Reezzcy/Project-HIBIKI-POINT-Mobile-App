import 'package:flutter/material.dart';
import 'package:project_hibiki_point_mobile_app/res/colors.dart';
import 'package:project_hibiki_point_mobile_app/ui/views/home/dashboard/dashboard_screen.dart';
import 'package:project_hibiki_point_mobile_app/ui/views/home/explore/explore_screen.dart';
import 'package:project_hibiki_point_mobile_app/ui/views/home/profile/profile_screen.dart';
import 'package:project_hibiki_point_mobile_app/ui/views/home/schedule/schedule_screen.dart';

class HomeMain extends StatefulWidget {
  const HomeMain({super.key});

  @override
  State<HomeMain> createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  int _selectedIndex = 0;
  late List<Widget> _screenOptions;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _screenOptions = [
      const DashboardScreen(),
      const ScheduleScreen(),
      const ExploreScreen(),
      const ProfileScreen()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryWhite,
        body: _screenOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: AppColors.primaryDarkBlue,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: _selectedMenuIcon(0, Icons.home), label: 'Dashboard'),
            BottomNavigationBarItem(
                icon: _selectedMenuIcon(1, Icons.calendar_today), label: 'Schedule'),
            BottomNavigationBarItem(
                icon: _selectedMenuIcon(2, Icons.list), label: 'Explore'),
            BottomNavigationBarItem(
                icon: _selectedMenuIcon(3, Icons.person), label: 'Profile'),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          selectedItemColor: AppColors.primaryBoneWhite,
          unselectedItemColor: AppColors.primaryBoneWhite,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  Widget _selectedMenuIcon(int indexIcon, IconData menuIcon) {
    bool isSelected = indexIcon == _selectedIndex;
    return isSelected
        ? Icon(menuIcon, size: 35, color: AppColors.primaryBoneWhite)
        : Icon(menuIcon, color: AppColors.primaryBoneWhite);
  }
}