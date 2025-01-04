import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import 'create_flashcard_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            double width = constraints.maxWidth;
            double height = constraints.maxHeight;

            bool isSmallScreen = width < 600;

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Welcome to Flashcards App!",
                      style: TextStyle(
                        fontSize: isSmallScreen ? 20 : 28,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: height * 0.02),

                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      alignment: WrapAlignment.center,
                      children: [
                        _buildQuickAction(
                          icon: Icons.shuffle,
                          label: "Shuffle",
                          onTap: () => Get.toNamed('/shuffle'),
                          isSmallScreen: isSmallScreen,
                        ),
                        _buildQuickAction(
                          icon: Icons.create,
                          label: "New Deck",
                          onTap: () => _showCreateNewDeckDialog(context),
                          isSmallScreen: isSmallScreen,
                        ),
                        _buildQuickAction(
                          icon: Icons.trending_up,
                          label: "Progress",
                          onTap: () => Get.toNamed('/progress'),
                          isSmallScreen: isSmallScreen,
                        ),
                        _buildQuickAction(
                          icon: Icons.emoji_events,
                          label: "Achievements",
                          onTap: () => Get.toNamed('/achievements'),
                          isSmallScreen: isSmallScreen,
                        ),
                        _buildQuickAction(
                          icon: Icons.person,
                          label: "Profile",
                          onTap: () => Get.toNamed('/profile'),
                          isSmallScreen: isSmallScreen,
                        ),
                      ],
                    ),

                    SizedBox(height: height * 0.04),

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

                    _buildDeckCategory(context, "System Deck", "/system_deck"),
                    _buildDeckCategory(context, "Your Deck", "/your_deck"),
                    _buildDeckCategory(context, "Online Deck", "/online_deck"),
                    _buildDeckCategory(context, "Random Deck", "/random_deck"),
                    _buildDeckCategory(context, "Contributed Deck", "/contributed_deck"),

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

  Widget _buildDeckCategory(BuildContext context, String categoryName, String route) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        title: Text(
          categoryName,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 20,
        ),
        onTap: () {
          Get.toNamed(route);
        },
      ),
    );
  }

  Widget _buildDeckList(BuildContext context) {
    // Mapping deck categories to their respective routes
    final categories = {
      "System Deck": "/system_deck",
      "Your Deck": "/your_deck",
      "Online Deck": "/online_deck",
      "Random Deck": "/random_deck",
      "Contributed Deck": "/contributed_deck",
    };

    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final categoryName = categories.keys.elementAt(index);
        final route = categories[categoryName]!;
        return _buildDeckCategory(context, categoryName, route);
      },
    );
  }


  void _showCreateNewDeckDialog(BuildContext context) {
    TextEditingController deckNameController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Deck Name'),
          content: TextField(
            controller: deckNameController,
            decoration: InputDecoration(hintText: 'Deck Name'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                String deckName = deckNameController.text.trim();
                if (deckName.isNotEmpty) {
                  _createNewDeck(deckName, context);
                  Navigator.pop(context);
                }
              },
              child: Text('Create'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _createNewDeck(String deckName, BuildContext context) async {
    String deckId = Uuid().v4();

    await _firestore.collection('decks').add({
      'deckName': deckName,
      'deckId': deckId,
      'userId': FirebaseAuth.instance.currentUser?.uid,
      'createdAt': FieldValue.serverTimestamp(),
    });

    Get.to(
      CreateFlashcardScreen(deckId: deckId),
    );
  }
}
