import 'package:deckify/providers/auth_provider.dart';
import 'package:deckify/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get screen width and height using MediaQuery
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.05), // Responsive padding
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section Header
              _buildSectionHeader('Account Settings', screenWidth),
              SizedBox(height: screenHeight * 0.02),

              // Account Settings Options
              _buildSettingsOption('Change Email', screenWidth),
              _buildSettingsOption('Change Password', screenWidth),
              _buildSettingsOption('Logout', screenWidth),

              SizedBox(height: screenHeight * 0.03),

              // Section Header
              _buildSectionHeader('App Settings', screenWidth),
              SizedBox(height: screenHeight * 0.02),

              // App Settings Options
              _buildSettingsOption('Notifications', screenWidth),
              _buildSettingsOption('Privacy', screenWidth),
              _buildSettingsOption('Language', screenWidth),

              SizedBox(height: screenHeight * 0.03),

              // Section Header
              _buildSectionHeader('About', screenWidth),
              SizedBox(height: screenHeight * 0.02),

              // About Options
              _buildSettingsOption('Terms & Conditions', screenWidth),
              _buildSettingsOption('Privacy Policy', screenWidth),
              _buildSettingsOption('Help & Support', screenWidth),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, double screenWidth) {
    return Text(
      title,
      style: TextStyle(
        fontSize: screenWidth * 0.05, // Adjust font size based on screen width
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildSettingsOption(String title, double screenWidth) {
    return GestureDetector(
      onTap: () async {
        if (title == 'Logout') {
          // Call the logout method from AuthMethod and navigate to login page
          await AuthProvider().logout();
          Get.offAllNamed('/login');  // Navigate to login screen
        } else {
          // Handle other options here
          print('$title tapped');
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: screenWidth * 0.04),
        margin: EdgeInsets.only(bottom: screenWidth * 0.03),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
              child: Icon(
                Icons.settings,
                color: Colors.blue,
                size: screenWidth * 0.06, // Adjust icon size
              ),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: screenWidth * 0.045, // Adjust font size for text
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
