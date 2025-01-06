// card_model.dart

import 'package:flutter/material.dart';

class CardModel {
  final String category;
  final String question;
  final String answer;
  final Color textColor;
  final Color bgColor;
  final String difficultyLevel;
  final List<String> tags;
  final String uniqueId;
  final String deckId;
  final String userId;

  // Constructor
  const CardModel({
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





  // Method to create a CardModel from a Map (for example, from JSON)
  factory CardModel.fromMap(Map<String, dynamic> map) {
    return CardModel(
      category: map['category'],
      question: map['question'],
      answer: map['answer'],
      textColor: Color(map['textColor']),
      bgColor: Color(map['bgColor']),
      difficultyLevel: map['difficultyLevel'],
      tags: List<String>.from(map['tags']),
      uniqueId: map['uniqueId'],
      deckId: map['deckId'],
      userId: map['userId'],
    );
  }

  // Method to convert CardModel to a Map (for example, to store in Firestore)
  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'question': question,
      'answer': answer,
      'textColor': textColor.value,
      'bgColor': bgColor.value,
      'difficultyLevel': difficultyLevel,
      'tags': tags,
      'uniqueId': uniqueId,
      'deckId': deckId,
      'userId': userId,
    };
  }
}
