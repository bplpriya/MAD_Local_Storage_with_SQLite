import 'package:flutter/material.dart';
import '../models/folder_model.dart';
import '../models/card_model.dart';
import '../repositories/card_repository.dart';

class FolderDetailScreen extends StatefulWidget {
  final FolderModel folder;
  const FolderDetailScreen({super.key, required this.folder});

  @override
  State<FolderDetailScreen> createState() => _FolderDetailScreenState();
}

class _FolderDetailScreenState extends State<FolderDetailScreen> {
  final CardRepository cardRepo = CardRepository();
  List<CardModel> cards = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCards();
  }

  // Load cards from database
  Future<void> _loadCards() async {
    if (widget.folder.id == null) return;
    setState(() => isLoading = true);

    try {
      final data = await cardRepo.getCardsByFolder(widget.folder.id!);
      setState(() {
        cards = data;
        isLoading = false;
      });
    } catch (e) {
      print("Error loading cards: $e");
      setState(() => isLoading = false);
    }
  }

  // Add a new card to folder
  Future<void> _addSampleCard() async {
    if (widget.folder.id == null) return;

    final count = await cardRepo.countCardsInFolder(widget.folder.id!);
    if (count >= 6) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Limit reached'),
          content: const Text('This folder can only hold 6 cards.'),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'))
          ],
        ),
      );
      return;
    }

    final newCard = CardModel(
      name: 'Card ${count + 1}',
      suit: widget.folder.name,
      image: 'https://via.placeholder.com/150?text=${widget.folder.name}+${count + 1}',
      folderId: widget.folder.id!,
    );

    await cardRepo.addCard(newCard);
    await _loadCards();
  }

  // Delete a card
  Future<void> _deleteCard(int cardId) async {
    await cardRepo.deleteCard(cardId);
    await _loadCards();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.folder.name)),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : cards.isEmpty
              ? const Center(child: Text('No cards yet. Tap + to add.'))
              : GridView.builder(
                  padding: const EdgeInsets.all(8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                  ),
                  itemCount: cards.length,
                  itemBuilder: (context, index) {
                    final c = cards[index];
                    return GestureDetector(
                      onLongPress: () => _deleteCard(c.id!),
                      child: GridTile(
                        footer: Center(
                          child: Text(c.name, style: const TextStyle(fontSize: 12)),
                        ),
                        child: Image.network(c.image, fit: BoxFit.cover),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addSampleCard,
        child: const Icon(Icons.add),
      ),
    );
  }
}
