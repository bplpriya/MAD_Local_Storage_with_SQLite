import 'package:sqflite/sqflite.dart';
import '../db/database_helper.dart';
import '../models/folder_model.dart';

class FolderRepository {
  final DatabaseHelper dbHelper = DatabaseHelper();

  // Insert default folders (only if not already present)
  Future<void> insertDefaultFolders() async {
    final db = await dbHelper.database;

    final count = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM folders')) ?? 0;

    if (count > 0) return; // Already inserted

    const suits = ['Hearts', 'Spades', 'Diamonds', 'Clubs'];
    for (final name in suits) {
      await db.insert('folders', {'name': name});
    }
    print("Default folders inserted");
  }

  // Get all folders
  Future<List<FolderModel>> getAllFolders() async {
    final db = await dbHelper.database;
    final result = await db.query('folders', orderBy: 'id');
    return result.map((e) => FolderModel.fromMap(e)).toList();
  }
}
