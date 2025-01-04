import 'package:flutter/material.dart';

class OnlineDeck extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the screen size to make the layout responsive
    final screenSize = MediaQuery.of(context).size;
    final isPortrait = screenSize.height > screenSize.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Flashcard Decks'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title of the screen
              Text(
                'Your Flashcard Decks',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(height: 16),

              // Flashcard deck list
              // This could be dynamic based on your flashcard decks data
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(), // Make it scrollable but prevent overflow
                itemCount: 20, // Assume there are 20 decks (can be dynamic)
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blueAccent.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8.0,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 12.0,
                        ),
                        title: Text(
                          'Deck ${index + 1}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: isPortrait ? 18 : 20, // Adjust text size based on orientation
                          ),
                        ),
                        subtitle: Text(
                          'Description of deck ${index + 1}',
                          style: TextStyle(fontSize: isPortrait ? 14 : 16),
                        ),
                        onTap: () {
                          // Navigate to deck details or flashcards
                        },
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
