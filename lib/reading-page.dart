import 'package:flutter/material.dart';

import 'models/book.dart';

class ReadingPage extends StatefulWidget {
  final Book book;

  ReadingPage({required this.book});

  @override
  State<ReadingPage> createState() => _ReadingPageState();
}

class _ReadingPageState extends State<ReadingPage> {
  String bookContent = '';
  String chapterTitle = '';

  @override
  void initState() {
    super.initState();
    _fetchBookContent();
  }

  Future<void> _fetchBookContent() async {
    final book = widget.book; // Get the book's ID
    // Fetch book content using bookId from your data source
    // For example, you could use dbManager to fetch content by bookId
    // Update 'bookContent' with fetched content
    setState(() {
      bookContent =
          book.chapters[book.currentChapterId].content!; // Update bookContent with fetched content
      chapterTitle =
          book.chapters[book.currentChapterId].title!; // Update bookContent with fetched content
    });
  }

  @override
  Widget build(BuildContext context) {
    // Read the content of the book from the file path
    // You'll need to implement this part
    final title = widget.book.lastChapterTitle;
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Text(bookContent),
      ),
    );
  }
}
