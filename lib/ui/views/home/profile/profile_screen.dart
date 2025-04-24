import 'package:flutter/material.dart';
import 'package:project_hibiki_point_mobile_app/res/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.primaryBoneWhite,
      body: Column(
        children: [
          Container(
            width: screenWidth,
            height: screenHeight * 0.33,
            color: AppColors.primaryDarkBlue,
            padding: EdgeInsets.only(top: mediaQuery.padding.top + 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: screenWidth * 0.12,
                  backgroundImage: AssetImage('assets/images/hibiki_logo_splash.png'),
                ),
                SizedBox(height: screenHeight * 0.015),
                Text(
                  'Nicolas Debrito',
                  style: TextStyle(
                    fontSize: screenWidth * 0.045,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'nicolas@gmail.com',
                  style: TextStyle(
                    fontSize: screenWidth * 0.035,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              children: [
                buildMenuItem(title: 'Settings', icon: Icons.settings),
                buildMenuItem(title: 'Notification', icon: Icons.notifications),
                buildMenuItem(title: 'Information', icon: Icons.info),
                buildMenuItem(title: 'Privacy and Safety', icon: Icons.lock),
                buildMenuItem(title: 'Help', icon: Icons.help_outline),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMenuItem({required String title, required IconData icon}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryWhite,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryCream,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: ListTile(
          leading: Icon(icon, color: AppColors.primaryDarkBlue),
          title: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          trailing: Icon(Icons.chevron_right),
          onTap: () {}, // Tambahkan aksi sesuai kebutuhan
        ),
      ),
    );
  }
}
