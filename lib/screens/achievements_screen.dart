import 'package:flutter/material.dart';

class AchievementsScreen extends StatelessWidget {
  // Sample data for achievements
  final List<Map<String, String>> achievements = [
    {"title": "First Step", "description": "Completed your first task."},
    {"title": "Explorer", "description": "Explored 5 new locations."},
    {"title": "Master", "description": "Mastered all challenges."},
    {"title": "Champion", "description": "Won 10 battles."},
    {"title": "Superstar", "description": "Achieved a high score in the game."},
    // Add more achievements here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Achievements"),
      ),
      body: ListView.builder(
        itemCount: achievements.length,
        itemBuilder: (context, index) {
          // Get achievement data
          final achievement = achievements[index];

          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            elevation: 4,
            child: ListTile(
              leading: Icon(Icons.emoji_events, size: 40, color: Colors.blue),
              title: Text(
                achievement['title']!,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: Text(achievement['description']!),
            ),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AchievementsScreen(),
  ));
}
