import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProgressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress Tracker'),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Screen width and height
            double screenWidth = constraints.maxWidth;
            double screenHeight = constraints.maxHeight;

            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05, // Adjust padding for responsiveness
                vertical: screenHeight * 0.02,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    'Your Study Progress',
                    style: TextStyle(
                      fontSize: screenWidth * 0.07,  // Responsive title size
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),  // Add space between title and progress bar

                  // Progress bar
                  Container(
                    width: screenWidth * 0.9,  // Adjust width for responsiveness
                    height: screenHeight * 0.04,  // Height of the progress bar
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade300,
                    ),
                    child: Stack(
                      children: [
                        Container(
                          width: screenWidth * 0.7, // Example progress (70%)
                          height: screenHeight * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue.shade700,
                          ),
                        ),
                        Center(
                          child: Text(
                            '70% Completed',  // Example text for progress
                            style: TextStyle(
                              fontSize: screenWidth * 0.04, // Responsive text size
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),  // Add space between progress bar and chart

                  // Progress Graph (Placeholder for actual graph)
                  Container(
                    width: screenWidth * 0.9,
                    height: screenHeight * 0.3,  // Height of the graph area
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.blue.shade100,
                    ),
                    child: Center(
                      child: Text(
                        'Graph Placeholder',  // Placeholder for actual graph widget
                        style: TextStyle(
                          fontSize: screenWidth * 0.05,  // Responsive text size
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade900,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),  // Add space between graph and stats

                  // Stats Section (e.g., total cards studied, streaks, etc.)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildStatsCard(screenWidth, screenHeight, 'Cards Studied', '120'),
                      _buildStatsCard(screenWidth, screenHeight, 'Streak', '7 Days'),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // Helper function to build stats card for displaying data like "Cards Studied", "Streak", etc.
  Widget _buildStatsCard(double screenWidth, double screenHeight, String title, String value) {
    return Container(
      width: screenWidth * 0.43, // Make the cards responsive
      height: screenHeight * 0.18, // Adjust height for stats card
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.blue.shade100,
      ),
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),  // Padding inside the stats card
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: screenWidth * 0.05,  // Responsive title size
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
              ),
            ),
            SizedBox(height: screenHeight * 0.01),  // Space between title and value
            Text(
              value,
              style: TextStyle(
                fontSize: screenWidth * 0.06,  // Responsive value size
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
