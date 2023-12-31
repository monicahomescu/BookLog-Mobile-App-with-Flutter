import 'package:booklog/repo.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'book.dart';
import 'utils.dart';

class CreateBookScreen extends StatefulWidget {
  const CreateBookScreen({super.key});

  @override
  State<CreateBookScreen> createState() => _CreateBookScreenState();
}

class _CreateBookScreenState extends State<CreateBookScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController authorController = TextEditingController();
  TextEditingController genreController = TextEditingController();
  TextEditingController ratingController = TextEditingController();
  TextEditingController reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Book')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title')),
            TextField(
                controller: authorController,
                decoration: const InputDecoration(labelText: 'Author')),
            TextField(
                controller: genreController,
                decoration: const InputDecoration(labelText: 'Genre')),
            TextField(
                controller: ratingController,
                decoration: const InputDecoration(labelText: 'Rating')),
            TextField(
                controller: reviewController,
                decoration: const InputDecoration(labelText: 'Review')),
            const SizedBox(height: 16.0),
            ElevatedButton(
                onPressed: () {
                  String validationErrors = validateInput(
                      titleController.text,
                      authorController.text,
                      genreController.text,
                      ratingController.text);

                  if (validationErrors == "") {
                    Book newBook = Book(
                        id: 0,
                        title: titleController.text,
                        author: authorController.text,
                        genre: genreController.text,
                        rating: int.parse(ratingController.text),
                        review: reviewController.text);

                    try {
                      Provider.of<BooksModel>(context, listen: false)
                          .createBook(newBook);
                    } catch (e) {
                      var logger = Logger();
                      logger.e('Error: $e');

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error: $e')),
                      );
                    }

                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(validationErrors),
                      ),
                    );
                  }
                },
                child: const Text('Create Book')),
          ],
        ),
      ),
    );
  }
}
