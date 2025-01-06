import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';  // Add this package for UUID generation
import '../models/deck_model.dart';


class DeckService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Collection reference for 'dec' collection
  CollectionReference get _deckCollection => _db.collection('decks');

  // Method to add a deck with a generated unique deckId and description "created by {username}"
  Future<void> addDeck(String username, DeckModel deck) async {
    try {
      // The deck already has a generated deckId when passed, so no need to generate a new one.
      String deckId = deck.deckId; // This comes from the caller (such as _createNewDeck).

      // Create the description as "created by {username}"
      String description = "created by $username";

      // Create a new deck with the passed deckId and description
      DeckModel deckWithId = DeckModel(
        deckId: deckId, // Use the passed deckId
        deckName: deck.deckName,
        description: description,
        userId: deck.userId,
        createdAt: Timestamp.now(),
      );

      // Add the deck document to Firestore with the passed deckId
      await _deckCollection.doc(deckId).set(deckWithId.toMap());
      print("Deck $deckId has been added successfully.");
    } catch (e) {
      print("Error adding deck: $e");
      throw e;
    }
  }


  // Method to get a deck by its deckId
  Future<DeckModel?> getDeckById(String deckId) async {
    try {
      DocumentSnapshot docSnapshot = await _deckCollection.doc(deckId).get();

      // If the document exists, return the DeckModel
      if (docSnapshot.exists) {
        return DeckModel.fromFirestore(docSnapshot);
      } else {
        print("Deck with ID $deckId not found.");
        return null;
      }
    } catch (e) {
      print("Error getting deck: $e");
      throw e;
    }
  }

  // Method to delete a deck by its deckId
  Future<void> deleteDeck(String deckId) async {
    try {
      await _deckCollection.doc(deckId).delete();
      print("Deck $deckId has been deleted successfully.");
    } catch (e) {
      print("Error deleting deck: $e");
      throw e;
    }
  }

  Future<List<DeckModel>> getUserDecks(String userId) async {
    try {
      // Query Firestore for decks where the userId matches
      QuerySnapshot querySnapshot = await _deckCollection
          .where('userId', isEqualTo: userId)  // Filter by userId
          .get();

      // Convert the query snapshot to a list of DeckModel
      List<DeckModel> userDecks = querySnapshot.docs
          .map((doc) => DeckModel.fromFirestore(doc))
          .toList();
      return userDecks;
    } catch (e) {
      print("Error fetching user decks: $e");
      throw e;
    }
  }

  // Method to get all decks (Optional, can be paginated)
  Future<List<DeckModel>> getAllDecks() async {
    try {
      QuerySnapshot querySnapshot = await _deckCollection.get();
      List<DeckModel> decks = querySnapshot.docs
          .map((doc) => DeckModel.fromFirestore(doc))
          .toList();
      return decks;
    } catch (e) {
      print("Error fetching decks: $e");
      throw e;
    }
  }
}
