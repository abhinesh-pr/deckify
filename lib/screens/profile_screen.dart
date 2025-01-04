import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Fetch screen size and screen orientation
    final size = MediaQuery.of(context).size;
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildProfileHeader(size),
                SizedBox(height: 20),
                _buildProfileDetails(size),
                SizedBox(height: 20),
                _buildNavigationButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Build profile header with avatar and name
  Widget _buildProfileHeader(Size size) {
    return Column(
      children: [
        // ClipOval(
        //   child: Image.asset(
        //     'assets/profile_picture.png',  // Replace with your image asset
        //     width: size.width * 0.3,         // 30% of screen width for the avatar
        //     height: size.width * 0.3,        // Keeping it square
        //     fit: BoxFit.cover,
        //   ),
        // ),
        SizedBox(height: 12),
        Text(
          'John Doe',  // Replace with dynamic name
          style: TextStyle(
            fontSize: size.width * 0.08,   // Font size relative to screen width
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Software Engineer',  // Replace with dynamic title
          style: TextStyle(
            fontSize: size.width * 0.05,   // Smaller font for title
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  // Build the profile details section
  Widget _buildProfileDetails(Size size) {
    return Column(
      children: [
        _buildDetailRow('Email:', 'john.doe@example.com', size),
        _buildDetailRow('Phone:', '+1 234 567 890', size),
        _buildDetailRow('Location:', 'New York, USA', size),
        _buildDetailRow('Date of Birth:', 'January 1, 1990', size),
      ],
    );
  }

  // A reusable widget for displaying details
  Widget _buildDetailRow(String label, String value, Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: size.width * 0.05,  // Responsive font size
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: size.width * 0.045,  // Smaller font for the value
                color: Colors.black87,
              ),
              overflow: TextOverflow.ellipsis,  // To avoid overflow on large text
            ),
          ),
        ],
      ),
    );
  }

  // Navigation button to go to Settings
  Widget _buildNavigationButton() {
    return ElevatedButton(
      onPressed: () {
        // Navigate to '/settings' screen using GetX
        Get.toNamed('/settings');
      },
      child: Text('Go to Settings'),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, backgroundColor: Colors.blue, padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ), // Text color
      ),
    );
  }
}
