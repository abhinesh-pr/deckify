import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/card_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CardService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create a card in Firestore
  Future<void> createCard({
    required String category,
    required String question,
    required String answer,
    required String textColor,
    required String bgColor,
    required String difficultyLevel,
    required List<String> tags,
    required String deckId,
  }) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    String uniqueId = DateTime.now().millisecondsSinceEpoch.toString(); // Unique ID for the card

    CardModel card = CardModel(
      category: category,
      question: question,
      answer: answer,
      textColor: textColor,
      bgColor: bgColor,
      difficultyLevel: difficultyLevel,
      tags: tags,
      uniqueId: uniqueId,
      deckId: deckId,
      userId: userId,
    );

    try {
      await _firestore.collection('cards').doc(uniqueId).set(card.toMap());
      print("Card created successfully");
    } catch (e) {
      print("Error creating card: $e");
      rethrow; // To handle errors in the calling method
    }
  }

// You can add more methods like fetching cards, updating cards, etc.
}
