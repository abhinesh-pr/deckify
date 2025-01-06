import 'package:cloud_firestore/cloud_firestore.dart';

class DeckModel {
  final String deckId;
  final String deckName;
  final String description;
  final String userId;
  final Timestamp createdAt;

  // Constructor
  DeckModel({
    required this.deckId,
    required this.deckName,
    required this.description,
    required this.userId,
    required this.createdAt,
  });

  // From Firestore document to DeckModel
  factory DeckModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return DeckModel(
      deckId: data['deckId'] ?? '',
      deckName: data['deckName'] ?? '',
      description: data['description'] ?? '',
      userId: data['userId'] ?? '',
      createdAt: data['createdAt'] ?? Timestamp.now(),
    );
  }

  // Convert DeckModel to Firestore document data
  Map<String, dynamic> toMap() {
    return {
      'deckId': deckId,
      'deckName': deckName,
      'description': description,
      'userId': userId,
      'createdAt': createdAt,
    };
  }
}
