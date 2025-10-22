import 'package:sqflite/sqflite.dart';
import '../db/database_helper.dart';
import '../models/card_model.dart';

class CardRepository {
  final DatabaseHelper dbHelper = DatabaseHelper();

  // Get all cards for a folder
  Future<List<CardModel>> getCardsByFolder(int folderId) async {
    final db = await dbHelper.database;
    final result = await db.query(
      'cards',
      where: 'folderId = ?',
      whereArgs: [folderId],
      orderBy: 'id',
    );
    return result.map((e) => CardModel.fromMap(e)).toList();
  }

  // Add a new card
  Future<int> addCard(CardModel card) async {
    final db = await dbHelper.database;
    return await db.insert('cards', card.toMap());
  }

  // Delete a card
  Future<void> deleteCard(int id) async {
    final db = await dbHelper.database;
    await db.delete('cards', where: 'id = ?', whereArgs: [id]);
  }

  // Count cards in a folder
  Future<int> countCardsInFolder(int folderId) async {
    final db = await dbHelper.database;
    final result = await db.rawQuery(
      'SELECT COUNT(*) FROM cards WHERE folderId = ?',
      [folderId],
    );
    return Sqflite.firstIntValue(result) ?? 0;
  }
}
