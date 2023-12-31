import 'dart:async';
import 'package:booklog/book.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseManager {
  DatabaseManager._();

  static final DatabaseManager instance = DatabaseManager._();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final path = join(await getDatabasesPath(), 'books_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE books(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            author TEXT,
            genre TEXT,
            rating INTEGER,
            review TEXT
          )
        ''');
      },
    );
  }

  Future<int> createBook(Book book) async {
    final db = await database;

    return await db.insert(
      'books',
      book.toMap(),
    );
  }

  Future<List<Book>> readBooks() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('books');

    return List.generate(maps.length, (i) {
      return Book(
        id: maps[i]['id'] as int,
        title: maps[i]['title'] as String,
        author: maps[i]['author'] as String,
        genre: maps[i]['genre'] as String,
        rating: maps[i]['rating'] as int,
        review: maps[i]['review'] as String,
      );
    });
  }

  Future<void> updateBook(Book book) async {
    final db = await database;

    await db.update(
      'books',
      book.toMap(),
      where: 'id = ?',
      whereArgs: [book.id],
    );
  }

  Future<void> deleteBook(int bookId) async {
    final db = await database;

    await db.delete(
      'books',
      where: 'id = ?',
      whereArgs: [bookId],
    );
  }
}
