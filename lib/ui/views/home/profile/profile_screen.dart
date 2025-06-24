import 'package:flutter/material.dart';
import 'package:project_hibiki_point_mobile_app/res/colors.dart';
import 'package:provider/provider.dart';
import 'package:project_hibiki_point_mobile_app/providers/auth_provider.dart';
import 'package:project_hibiki_point_mobile_app/ui/views/auth/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;
    final authProvider = Provider.of<AuthProvider>(context);

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
                  backgroundImage: const AssetImage('assets/images/hibiki_logo_splash.png'),
                ),
                SizedBox(height: screenHeight * 0.015),
                Text(
                  'Nicolas Debrito', // Idealnya menggunakan data user dari AuthProvider
                  style: TextStyle(
                    fontSize: screenWidth * 0.045,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  authProvider.email ?? 'nicolas@gmail.com',
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              children: [
                buildMenuItem(title: 'Settings', icon: Icons.settings),
                buildMenuItem(title: 'Notification', icon: Icons.notifications),
                buildMenuItem(title: 'Information', icon: Icons.info),
                buildMenuItem(title: 'Privacy and Safety', icon: Icons.lock),
                buildMenuItem(title: 'Help', icon: Icons.help_outline),
                
                // Divider sebelum tombol logout
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 16),
                
                // Tombol Logout
                buildMenuItem(
                  title: 'Logout', 
                  icon: Icons.logout,
                  iconColor: Colors.red,
                  textColor: Colors.red,
                  onTap: () => _handleLogout(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMenuItem({
    required String title, 
    required IconData icon, 
    Color iconColor = AppColors.primaryDarkBlue,
    Color textColor = Colors.black,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryWhite,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: AppColors.primaryCream,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: ListTile(
          leading: Icon(icon, color: iconColor),
          title: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
          trailing: const Icon(Icons.chevron_right),
          onTap: onTap,
        ),
      ),
    );
  }
  
  // Handle logout action
  Future<void> _handleLogout(BuildContext context) async {
    // Show confirmation dialog
    final bool confirmLogout = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi Logout'),
        content: const Text('Apakah Anda yakin ingin keluar dari akun ini?'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    ) ?? false;

    // If user confirmed logout
    if (confirmLogout) {
      try {
        // Show loading indicator
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const Center(child: CircularProgressIndicator()),
        );

        // Call logout method from AuthProvider
        await Provider.of<AuthProvider>(context, listen: false).logout();
        
        // Close loading dialog
        if (context.mounted) Navigator.of(context).pop();
        
        // Navigate to login screen and clear navigation stack
        if (context.mounted) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (route) => false, // Remove all previous routes
          );
        }
      } catch (e) {
        // Close loading dialog if open
        if (context.mounted) Navigator.of(context).pop();
        
        // Show error message
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Logout gagal: $e')),
          );
        }
      }
    }
  }
}