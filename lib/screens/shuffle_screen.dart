import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShuffleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shuffle Flashcards'),
        backgroundColor: Colors.blueAccent,
        elevation: 4,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            double screenWidth = constraints.maxWidth;
            double screenHeight = constraints.maxHeight;

            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05, // Horizontal padding for responsiveness
                vertical: screenHeight * 0.02, // Vertical padding for responsiveness
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Single Card with reduced height
                  Container(
                    width: screenWidth * 0.8, // Width of the card
                    height: screenHeight * 0.25, // Reduced height of the card
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.blue.shade50,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.shade200,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Icon(
                        Icons.shuffle_outlined,size: screenWidth * 0.1, color: Colors.blue.shade900,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),

                  // Title Text
                  SizedBox(height: screenHeight * 0.1),

                  // Shuffle Button
                  ElevatedButton(
                    onPressed: () {
                      // Logic to shuffle flashcards
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.25, // Responsive padding
                        vertical: screenHeight * 0.02,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      shadowColor: Colors.blueAccent.withOpacity(0.5),
                      elevation: 6,
                    ),
                    child: Text(
                      'Start Shuffle',
                      style: TextStyle(
                        fontSize: screenWidth * 0.05, // Responsive text size
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),

                  // Shuffle Type Button
                  ElevatedButton(
                    onPressed: () {
                      // Logic to choose shuffle type
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade200,
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.2, // Responsive padding
                        vertical: screenHeight * 0.02,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      'Choose Shuffle Type',
                      style: TextStyle(
                        fontSize: screenWidth * 0.05, // Responsive text size
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade800,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
