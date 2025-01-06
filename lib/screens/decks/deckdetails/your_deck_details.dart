import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class YourDeckDetails extends StatelessWidget {
  final String deckId;

  YourDeckDetails({required this.deckId});

  // Fetch the list of cards from the deck's cards subcollection
  Stream<List<Map<String, dynamic>>> _fetchCards() {
    return FirebaseFirestore.instance
        .collection('decks')               // Main collection
        .doc(deckId)                        // Specific deck
        .collection('cards')               // Subcollection
        .snapshots()                        // Real-time updates
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        // Map Firestore document to card data
        return {
          'cardId': doc.id,
          'question': doc['question'],
          'answer': doc['answer'],
        };
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Deck Details'),
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _fetchCards(), // Listen to card updates
        builder: (context, snapshot) {
          // Show loading indicator while data is being fetched
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          // Handle errors
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong.'));
          }

          // Handle empty cards list
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No cards available.'));
          }

          final cards = snapshot.data!;

          return ListView.builder(
            itemCount: cards.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Card(
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 12.0,
                    ),
                    title: Text(
                      cards[index]['question'], // Display the question
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      cards[index]['answer'], // Display the answer
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
