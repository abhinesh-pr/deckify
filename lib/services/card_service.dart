import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/card_model.dart';


class CardServices {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Collection reference for 'decks' (parent collection)
  final CollectionReference _decksCollection = FirebaseFirestore.instance.collection('decks');

  // Method to add a card to a specific deck
  Future<void> addCard(String deckId, CardModel card) async {
    try {
      // Adding the card to the 'cards' subcollection inside the specified deck document
      DocumentReference deckDoc = _decksCollection.doc(deckId);
      await deckDoc.collection('cards').doc(card.uniqueId).set(card.toMap());

      print("Card added successfully to deck: $deckId");
    } catch (e) {
      print("Error adding card: $e");
      throw Exception("Error adding card");
    }
  }

  // Method to fetch a single card by its unique ID from Firestore
  Future<CardModel?> getCard(String uniqueId) async {
    try {
      // Fetching the card from all decks
      QuerySnapshot snapshot = await _db.collectionGroup('cards').where('uniqueId', isEqualTo: uniqueId).get();

      if (snapshot.docs.isNotEmpty) {
        // Creating a CardModel instance from the fetched data
        return CardModel.fromMap(snapshot.docs.first.data() as Map<String, dynamic>);
      } else {
        print("Card not found!");
        return null;
      }
    } catch (e) {
      print("Error fetching card: $e");
      throw Exception("Error fetching card");
    }
  }

  // Method to fetch all cards in a deck by deckId
  Future<List<CardModel>> getCardsByDeckId(String deckId) async {
    try {
      // Fetching all cards in the deck (cards are stored in the 'cards' subcollection)
      QuerySnapshot snapshot = await _decksCollection
          .doc(deckId)
          .collection('cards')
          .get();

      List<CardModel> cards = snapshot.docs
          .map((doc) => CardModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      return cards;
    } catch (e) {
      print("Error fetching cards: $e");
      throw Exception("Error fetching cards");
    }
  }

  // Method to update a card
  Future<void> updateCard(String deckId, CardModel card) async {
    try {
      // Updating the card in the 'cards' subcollection inside the deck
      await _decksCollection
          .doc(deckId)
          .collection('cards')
          .doc(card.uniqueId)
          .update(card.toMap());
      print("Card updated successfully");
    } catch (e) {
      print("Error updating card: $e");
      throw Exception("Error updating card");
    }
  }

  // Method to delete a card by its unique ID
  Future<void> deleteCard(String deckId, String uniqueId) async {
    try {
      // Deleting the card from the 'cards' subcollection inside the deck
      await _decksCollection
          .doc(deckId)
          .collection('cards')
          .doc(uniqueId)
          .delete();
      print("Card deleted successfully");
    } catch (e) {
      print("Error deleting card: $e");
      throw Exception("Error deleting card");
    }
  }
}
