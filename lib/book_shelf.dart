import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:reader/database_manager.dart';
import 'package:reader/processor/local_file.dart';

import 'models/book.dart';
import 'reading_page.dart';
import 'dart:developer' as developer;

class BookshelfPage extends StatefulWidget {
  const BookshelfPage({super.key});

  @override
  State<BookshelfPage> createState() => _BookshelfPageState();
}

class _BookshelfPageState extends State<BookshelfPage> {
  final LocalFileProcessor _localFileProcessor = LocalFileProcessor();
  final DBManager dbManager = DBManager.instance;
  List<Book> books = [];

  @override
  void initState() {
    super.initState();
    _loadBooks(); // Load the initial list of books
  }

  Future<void> _loadBooks() async {
    final allBooks = await dbManager.getAllBooks();
    setState(() {
      books = allBooks;
    });
  }

  Future<void> _openFilePicker() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.any);

    if (result != null) {
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
          return Dismissible(
            key: Key(books[index].id.toString()), // Use a unique key for each book
            onDismissed: (direction) {
              // Remove the book from the list and the database
              dbManager.deleteBook(books[index].id); // Delete the book from the database
              setState(() {
                books.removeAt(index);
              });
            },
            background: Container(
              color: Colors.red,
              child: const Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 16.0),
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            child: ListTile(
              title: Text('${books[index].title} - ${books[index].author}'),
              subtitle: Text(books[index].lastChapterTitle),
              onTap: () async {
                // Navigate to the ReadingPage with the selected book
                final readingStatus = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReadingPage(book: books[index]),
                  ),
                );
                if (readingStatus != null) {
                  final [title, chapIdx] = readingStatus;
                  setState(() {
                    books[index].currentChapterId = chapIdx;
                    books[index].lastChapterTitle = title;
                    books = books;
                    dbManager.updateBook(books[index]);
                  });
                }
              },
            ),
          );
        },
      ),
    );
  }
}
