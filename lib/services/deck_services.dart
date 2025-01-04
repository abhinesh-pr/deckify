import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/deck_model.dart';


class DeckService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Collection reference
  CollectionReference get _deckCollection => _firestore.collection('decks');

  // Create a new deck
  Future<void> createDeck(Deck deck) async {
    try {
      await _deckCollection.add(deck.toMap());
      print("Deck created successfully");
    } catch (e) {
      print("Error creating deck: $e");
      throw e;
    }
  }

  // Get a deck by deckId
  Future<Deck?> getDeckById(String deckId) async {
    try {
      DocumentSnapshot doc = await _deckCollection.doc(deckId).get();
      if (doc.exists) {
        return Deck.fromFirestore(doc);
      } else {
        print("Deck not found");
        return null;
      }
    } catch (e) {
      print("Error fetching deck: $e");
      throw e;
    }
  }

  // Get all decks created by the user
  Future<List<Deck>> getUserDecks(String uid) async {
    try {
      QuerySnapshot snapshot = await _deckCollection.where('uid', isEqualTo: uid).get();
      return snapshot.docs.map((doc) => Deck.fromFirestore(doc)).toList();
    } catch (e) {
      print("Error fetching user decks: $e");
      throw e;
    }
  }

  // Update a deck's name
  Future<void> updateDeckName(String deckId, String newDeckName) async {
    try {
      await _deckCollection.doc(deckId).update({'deckName': newDeckName});
      print("Deck name updated successfully");
    } catch (e) {
      print("Error updating deck: $e");
      throw e;
    }
  }

  // Delete a deck
  Future<void> deleteDeck(String deckId) async {
    try {
      await _deckCollection.doc(deckId).delete();
      print("Deck deleted successfully");
    } catch (e) {
      print("Error deleting deck: $e");
      throw e;
    }
  }
}
