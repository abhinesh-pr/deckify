import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart'; // Package to generate unique ID

class CardModel {
  String category;
  String question;
  String answer;
  String textColor;
  String bgColor;
  String difficultyLevel;
  List<String> tags;
  String uniqueId;
  String deckId;  // This will now come from the Deck model
  String userId;

  CardModel({
    required this.category,
    required this.question,
    required this.answer,
    required this.textColor,
    required this.bgColor,
    required this.difficultyLevel,
    required this.tags,
    required this.uniqueId,
    required this.deckId,
    required this.userId,
  });

  // Convert a CardModel object to a map for saving to Firebase
  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'question': question,
      'answer': answer,
      'textColor': textColor,
      'bgColor': bgColor,
      'difficultyLevel': difficultyLevel,
      'tags': tags,
      'uniqueId': uniqueId,
      'deckId': deckId,
      'userId': userId,
    };
  }

  // Create a CardModel object from a Firestore document snapshot
  factory CardModel.fromFirestore(DocumentSnapshot doc) {
    var data = doc.data() as Map<String, dynamic>;

    return CardModel(
      category: (data['category'] ?? '').toLowerCase(),
      question: data['question'] ?? '',
      answer: data['answer'] ?? '',
      textColor: data['textColor'] ?? '',
      bgColor: data['bgColor'] ?? '',
      difficultyLevel: data['difficultyLevel'] ?? 'easy',  // Default to 'easy' if not present
      tags: List<String>.from(data['tags'] ?? []),
      uniqueId: data['uniqueId'] ?? '',
      deckId: data['deckId'] ?? '',  // Fetch deckId from the document
      userId: data['userId'] ?? '', // Fetch userId from the document
    );
  }

  // Save the card to Firestore
  Future<void> saveCard() async {
    if (uniqueId.isEmpty) {
      uniqueId = Uuid().v4();
    }

    FirebaseFirestore.instance.collection('cards').doc(uniqueId).set(toMap());
  }

  // Create a new card and associate it with the provided deckId
  static Future<void> createCardForDeck({
    required String category,
    required String question,
    required String answer,
    required String textColor,
    required String bgColor,
    required String difficultyLevel,
    required List<String> tags,
    required String deckId,  // Deck ID from the Deck model
  }) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    // Generate unique card ID
    String uniqueId = Uuid().v4();

    CardModel card = CardModel(
      category: category,
      question: question,
      answer: answer,
      textColor: textColor,
      bgColor: bgColor,
      difficultyLevel: difficultyLevel,
      tags: tags,
      uniqueId: uniqueId,
      deckId: deckId,  // Pass the deckId from Deck model here
      userId: userId,
    );

    // Save the card to Firestore
    await card.saveCard();
  }
}
