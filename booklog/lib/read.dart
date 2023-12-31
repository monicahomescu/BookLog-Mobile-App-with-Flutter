import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'book.dart';
import 'create.dart';
import 'repo.dart';
import 'update.dart';
import 'package:logger/logger.dart';

class ReadBooksScreen extends StatefulWidget {
  const ReadBooksScreen({super.key});

  @override
  State<ReadBooksScreen> createState() => _ReadBooksScreenState();
}

class _ReadBooksScreenState extends State<ReadBooksScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BookLog')),
      body: Consumer<BooksModel>(
        builder: (context, booksModel, child) {
          try {
            return ListView.builder(
              itemCount: booksModel.books.length,
              itemBuilder: (context, index) {
                final book = booksModel.books[index];
                return ListTile(
                  title: Text('Title: ${book.title}'),
                  subtitle: Text('Author: ${book.author}'),
                  onTap: () => _navigateToUpdateBook(context, book),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _showDeleteConfirmationDialog(
                        context, book.title, book.id),
                  ),
                );
              },
            );
          } catch (e) {
            var logger = Logger();
            logger.e('Error: $e');

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: $e')),
            );
            
            return const SizedBox();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToCreateBook(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _navigateToCreateBook(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const CreateBookScreen()));
  }

  void _navigateToUpdateBook(BuildContext context, Book book) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => UpdateBookScreen(book: book)));
  }

  void _showDeleteConfirmationDialog(
      BuildContext context, String bookTitle, int bookId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Confirmation'),
          content: Text('Are you sure you want to delete "$bookTitle"?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                try {
                  Provider.of<BooksModel>(context, listen: false)
                      .deleteBook(bookId);
                } catch (e) {
                  var logger = Logger();
                  logger.e('Error: $e');

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: $e')),
                  );
                }

                Navigator.pop(context);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
