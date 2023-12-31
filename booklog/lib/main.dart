import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'read.dart';
import 'repo.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => BooksModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'BookLog',
      home: ReadBooksScreen(),
    );
  }
}
