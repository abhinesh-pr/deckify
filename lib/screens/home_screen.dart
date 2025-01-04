import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            // Calculate dynamic sizing based on screen width and height
            double width = constraints.maxWidth;
            double height = constraints.maxHeight;

            // Responsiveness thresholds
            bool isSmallScreen = width < 600;

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Title Section
                    Text(
                      "Welcome to Flashcards App!",
                      style: TextStyle(
                        fontSize: isSmallScreen ? 20 : 28,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: height * 0.02),

                    // Quick Actions Section
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      alignment: WrapAlignment.center,
                      children: [
                        _buildQuickAction(
                          icon: Icons.shuffle,
                          label: "Shuffle",
                          onTap: () => Navigator.pushNamed(context, '/shuffle'),
                          isSmallScreen: isSmallScreen,
                        ),
                        _buildQuickAction(
                          icon: Icons.create,
                          label: "Create Flashcards",
                          onTap: () =>
                              Navigator.pushNamed(context, '/create_flashcard'),
                          isSmallScreen: isSmallScreen,
                        ),
                        _buildQuickAction(
                          icon: Icons.trending_up,
                          label: "Progress",
                          onTap: () => Navigator.pushNamed(context, '/progress'),
                          isSmallScreen: isSmallScreen,
                        ),
                        _buildQuickAction(
                          icon: Icons.emoji_events,
                          label: "Achievements",
                          onTap: () =>
                              Navigator.pushNamed(context, '/achievements'),
                          isSmallScreen: isSmallScreen,
                        ),
                        _buildQuickAction(
                          icon: Icons.person,
                          label: "Profile",
                          onTap: () => Navigator.pushNamed(context, '/profile'),
                          isSmallScreen: isSmallScreen,
                        ),
                      ],
                    ),

                    SizedBox(height: height * 0.04),

                    // Flashcard Decks Section
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Deck Menu",
                        style: TextStyle(
                          fontSize: isSmallScreen ? 18 : 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.02),

                    // Add new sections
                    _buildDeckCategory(context, "System Deck"),
                    _buildDeckCategory(context, "Your Deck"),
                    _buildDeckCategory(context, "Online Deck"),
                    _buildDeckCategory(context, "Random Deck"),
                    _buildDeckCategory(context, "Contributedsi Deck"),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildQuickAction({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required bool isSmallScreen,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: isSmallScreen ? 100 : 120,
        height: isSmallScreen ? 100 : 120,
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: isSmallScreen ? 32 : 40,
              color: Colors.white,
            ),
            SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: isSmallScreen ? 14 : 16,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeckCategory(BuildContext context, String categoryName) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        title: Text(
          categoryName,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 20,
        ),
        onTap: () {
          // Navigate to specific deck category screen
          Navigator.pushNamed(context, '/deck_category', arguments: categoryName);
        },
      ),
    );
  }
}
