import 'dart:math';
import 'package:flutter/material.dart';
import 'package:reader/services/db_service.dart';
import 'package:reader/ui/paragraph.dart';

import 'models/book.dart';

class ReadingPage extends StatefulWidget {
  final Book book;

  const ReadingPage({super.key, required this.book});

  @override
  State<ReadingPage> createState() => _ReadingPageState();
}

class _ReadingPageState extends State<ReadingPage> with WidgetsBindingObserver {
  String chapterContent = '';
  String chapterTitle = '';
  int chapterIdx = 0;
  bool _bottomAppBarVisible = true;

  late Book book;
  late List<ChapterMeta> bookDirectory;
  DBService isar = DBService();

  @override
  void initState() {
    super.initState();
    book = widget.book;
    _fetchBookContent();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // App is about to become inactive or go into the background (onPause)
    } else if (state == AppLifecycleState.resumed) {
      // App is about to resume from the background (onResume)
    }
  }

  Future<void> _fetchBookContent() async {
    // Fetch book content using bookId from your data source
    // For example, you could use dbManager to fetch content by bookId
    // Update 'bookContent' with fetched content
    int idx = book.tableOfContents[book.lastChapterIdx].idx;
    Chapter? chapter = await isar.getChatperByIdx(book, idx);
    setState(() {
      if (chapter != null && chapter.content != '') {
        chapterContent = chapter.content!;
      }
      chapterTitle = book.tableOfContents[book.lastChapterIdx].title;
    });
  }

  void _toggleBottomAppBarVisibility() {
    setState(() {
      _bottomAppBarVisible = !_bottomAppBarVisible;
    });
  }

  void changeChapter(int step) async {
    int cid = min(max(1, chapterIdx + step), book.totalChapters);
    Chapter? chapter = await isar.getChatperByIdx(book, cid);
    if (chapter != null && chapter.content != '') {
      setState(() {
        chapterContent = chapter.content!;
        chapterIdx = cid;
        chapterTitle = chapter.title!;
      });
    }
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
                              changeChapter(-1);
                            },
                          ),
                          Expanded(
                            flex: 1,
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
                              changeChapter(1);
                              // Handle next chapter navigation
                            },
                          ),
                        ],
                      ),
                      const Divider(),
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
