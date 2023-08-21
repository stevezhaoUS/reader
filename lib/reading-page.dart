import 'package:flutter/material.dart';
import 'package:reader/database_manager.dart';
import 'package:reader/ui/paragraph.dart';

import 'models/book.dart';

class ReadingPage extends StatefulWidget {
  final Book book;

  ReadingPage({required this.book});

  @override
  State<ReadingPage> createState() => _ReadingPageState();
}

class _ReadingPageState extends State<ReadingPage> {
  String chapterContent = '';
  String chapterTitle = '';
  int chapterIdx = 0;

  bool _bottomAppBarVisible = true;

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
      chapterContent =
          book.chapters[book.currentChapterId].content!; // Update bookContent with fetched content
      chapterTitle =
          book.chapters[book.currentChapterId].title!; // Update bookContent with fetched content
      chapterIdx = book.currentChapterId;
    });
  }

  void _toggleBottomAppBarVisibility() {
    setState(() {
      _bottomAppBarVisible = !_bottomAppBarVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final title = chapterTitle;
    final paragraphs = chapterContent.split(RegExp(r'\s{2,}'));

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: GestureDetector(
          onTap: () {
            _toggleBottomAppBarVisibility();
          },
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Paragraph(
                      paragraphs: paragraphs,
                    )),
              ),
              if (_bottomAppBarVisible)
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: BottomAppBar(
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back),
                            onPressed: () {
                              if (chapterIdx > 0) {
                                chapterIdx--;
                                setState(() {
                                  chapterTitle = widget.book.chapters[chapterIdx--].title!;
                                  chapterContent = widget.book.chapters[chapterIdx--].content!;
                                });
                              }
                            },
                          ),
                          Expanded(
                            child: Slider(
                              value: 0.5, // Replace with actual progress value
                              onChanged: (value) {
                                // Handle progress change
                              },
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.arrow_forward),
                            onPressed: () {
                              if (chapterIdx < widget.book.chapters.length - 1) {
                                chapterIdx++;
                                setState(() {
                                  chapterTitle = widget.book.chapters[chapterIdx].title!;
                                  chapterContent = widget.book.chapters[chapterIdx].content!;
                                });
                              }
                              // Handle next chapter navigation
                            },
                          ),
                        ],
                      ),
                      Divider(),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        IconButton(
                          icon: Icon(Icons.list),
                          onPressed: () {
                            // Handle bookmark button
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.nightlight),
                          onPressed: () {
                            // Handle favorite button
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.font_download),
                          onPressed: () {
                            // Handle favorite button
                          },
                        ),
                      ])
                    ],
                  )),
                )
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    Navigator.pop(context, [chapterTitle, chapterIdx]);
    return Future.value(true); // Return true to allow back navigation, false to prevent
  }
}
