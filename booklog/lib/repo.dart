import 'package:booklog/database_manager.dart';
import 'package:flutter/material.dart';
import 'book.dart';

class BooksModel extends ChangeNotifier {
  final DatabaseManager _databaseManager = DatabaseManager.instance;

  List<Book> _books = [];
  List<Book> get books => _books;

  BooksModel() {
    readBooks();
  }

  Future<void> readBooks() async {
    _books = await _databaseManager.readBooks();
    notifyListeners();
  }

  Future<void> createBook(Book newBook) async {
    final int newId = await _databaseManager.createBook(newBook);
    newBook.id = newId;
    _books.add(newBook);
    notifyListeners();
  }

  Future<void> updateBook(Book updatedBook) async {
    await _databaseManager.updateBook(updatedBook);
    int index = _books.indexWhere((book) => book.id == updatedBook.id);
    if (index != -1) {
      _books[index] = updatedBook;
      notifyListeners();
    }
  }

  Future<void> deleteBook(int bookId) async {
    await _databaseManager.deleteBook(bookId);
    _books.removeWhere((book) => book.id == bookId);
    notifyListeners();
  }
}
