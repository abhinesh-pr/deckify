import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../models/deck_model.dart';
import '../../services/deck_services.dart';
 // Make sure this import points to your DeckService

class YourDeck extends StatefulWidget {
  @override
  _YourDeckState createState() => _YourDeckState();
}

class _YourDeckState extends State<YourDeck> {
  late Future<List<DeckModel>> _decks;

  @override
  void initState() {
    super.initState();
    _decks = _fetchUserDecks();
  }

  // Fetch decks created by the current user from Firestore
  Future<List<DeckModel>> _fetchUserDecks() async {
    String uid = FirebaseAuth.instance.currentUser?.uid ?? '';
    if (uid.isNotEmpty) {
      final deckService = DeckService();
      return await deckService.getUserDecks(uid);
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Decks'),
      ),
      body: FutureBuilder<List<DeckModel>>(
        future: _decks,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No decks found.'));
          } else {
            final decks = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: decks.length,
                itemBuilder: (context, index) {
                  final deck = decks[index];
                  return DeckCard(
                    deckName: deck.deckName,
                    description: deck.description,
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}

class DeckCard extends StatelessWidget {
  final String deckName;
  final String description;

  const DeckCard({
    Key? key,
    required this.deckName,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(
          deckName,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(description),
        trailing: Icon(Icons.arrow_forward, color: Theme.of(context).primaryColor),
        onTap: () {
          // Handle navigation or deck selection here
        },
      ),
    );
  }
}
