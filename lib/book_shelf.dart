import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:reader/services/db_service.dart';
import 'package:reader/processor/local_file.dart';

import 'models/book.dart';
import 'reading_page.dart';

class BookshelfPage extends StatefulWidget {
  const BookshelfPage({super.key});

  @override
  State<BookshelfPage> createState() => _BookshelfPageState();
}

class _BookshelfPageState extends State<BookshelfPage> {
  final LocalFileProcessor _localFileProcessor = LocalFileProcessor();
  // final DBManager dbManager = DBManager.instance;
  List<Book> books = [];
  int bookFeteched = 0;
  DBService isar = DBService();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadBooks();
  }

  Future<void> _loadBooks() async {
    final allBooks = await isar.fetchBooks(bookFeteched);
    setState(() {
      books = allBooks.toList();
      bookFeteched = books.length;
      isLoading = false;
    });
  }

  Future<void> _openFilePicker() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.any);
    setState(() {
      isLoading = true;
    });
    if (result != null) {
      String filePath = result.files.single.path!;
      await _localFileProcessor.loadAndProcessFile(filePath);
      await _loadBooks();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bookshelf'),
        leading: IconButton(
          icon: const Icon(Icons.add),
          onPressed: _openFilePicker, // Open the file picker
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              key: UniqueKey(),
              itemCount: books.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(books[index].id.toString()), // Use a unique key for each book
                  onDismissed: (direction) {
                    // Remove the book from the list and the database
                    // dbManager.deleteBook(books[index].id); // Delete the book from the database
                    setState(() {
                      // books.removeAt(index);
                    });
                  },
                  background: Container(
                    color: Colors.red, // Background color when swiping
                    alignment: Alignment.centerLeft,
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  secondaryBackground: Container(
                    color: Colors.blue, // Background color for the secondary action
                    alignment: Alignment.centerRight,
                    child: const Icon(Icons.edit, color: Colors.white),
                  ),
                  child: ListTile(
                    title: Text('${books[index].title} - ${books[index].author}'),
                    subtitle: Text(books[index]
                        .lastReadChapter), //books[index].lastReadChapter.value!.title!),
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
                          // books[index].currentChapterId = chapIdx;
                          // books[index].lastChapterTitle = title;
                          // books = books;
                          // dbManager.updateBook(books[index]);
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
