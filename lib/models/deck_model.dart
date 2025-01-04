import 'package:cloud_firestore/cloud_firestore.dart';

import 'card_model.dart';

class Deck {
  final String deckId;
  final String deckName;
  final String uid;
  final String username;

  Deck({
    required this.deckId,
    required this.deckName,
    required this.uid,
    required this.username,
  });

  // Convert Firestore document to Deck object
  factory Deck.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Deck(
      deckId: data['deckId'] ?? '',
      deckName: data['deckName'] ?? '',
      uid: data['uid'] ?? '',
      username: data['username'] ?? '',
    );
  }

  // Convert Deck object to Firestore document format
  Map<String, dynamic> toMap() {
    return {
      'deckId': deckId,
      'deckName': deckName,
      'uid': uid,
      'username': username,
    };
  }

  // When creating a new card, pass the deckId to CardModel's createCardForDeck method
  Future<void> createCard(
      {required String category,
        required String question,
        required String answer,
        required String textColor,
        required String bgColor,
        required String difficultyLevel,
        required List<String> tags}) async {
    // Pass deckId from this Deck to the CardModel
    await CardModel.createCardForDeck(
      category: category,
      question: question,
      answer: answer,
      textColor: textColor,
      bgColor: bgColor,
      difficultyLevel: difficultyLevel,
      tags: tags,
      deckId: this.deckId,  // Pass the current deckId here
    );
  }
}
