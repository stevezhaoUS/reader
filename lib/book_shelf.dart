import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:reader/database_manager.dart';
import 'package:reader/processor/local_file.dart';

import 'models/book.dart';
import 'reading-page.dart';
import 'dart:developer' as developer;

class BookshelfPage extends StatefulWidget {
  const BookshelfPage({super.key});

  @override
  State<BookshelfPage> createState() => _BookshelfPageState();
}

class _BookshelfPageState extends State<BookshelfPage> {
  final LocalFileProcessor _localFileProcessor = LocalFileProcessor();

  List<Book> books = [];

  @override
  void initState() {
    super.initState();
    _loadBooks(); // Load the initial list of books
  }

  Future<void> _loadBooks() async {
    final DatabaseManager dbManager = await DatabaseManager.getInstance();
    final allBooks = await dbManager.getAllBooks();
    setState(() {
      books = allBooks;
    });
  }

  Future<void> _openFilePicker() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.any);

    if (result != null) {
      developer.log('File loaded successfully');
      String filePath = result.files.single.path!;
      _localFileProcessor.loadAndProcessFile(filePath);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Bookshelf'),
        leading: IconButton(
          icon: Icon(Icons.add),
          onPressed: _openFilePicker, // Open the file picker
        ),
      ),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(books[index].title ?? ''),
            subtitle: Text(books[index].author ?? ''),
            onTap: () {
              // Navigate to the ReadingPage with the selected book
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ReadingPage(book: books[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
