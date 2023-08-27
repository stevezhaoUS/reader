import 'dart:async';
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
  int bottomAppBarHeight = 310;
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

  void handleProgressChange(double value) async {
    int pos = (value * book.size).toInt();
    int cid = isar.getChapterIdxFromPosition(book, pos);
    Chapter? chapter = await isar.getChapterById(cid);
    if (chapter != null && chapter.content != '') {
      setState(() {
        chapterContent = chapter.content!;
        chapterIdx = cid;
        chapterTitle = chapter.title!;
        book.lastReadPosition = pos;
      });
    }
  }

  Future<void> _fetchBookContent() async {
    int id = book.tableOfContents[book.lastChapterIdx].cid;
    Chapter? chapter = await isar.getChapterById(id);
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
    int idx = min(max(0, chapterIdx + step), book.tableOfContents.length - 1);
    Chapter? chapter = await isar.getChapterById(book.tableOfContents[idx].cid);
    int offset = book.tableOfContents[idx].offset;
    if (chapter != null) {
      setState(() {
        chapterContent = chapter.content ?? 'Content Missing...';
        chapterIdx = idx;
        chapterTitle = chapter.title!;
        book.lastReadPosition = offset;
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
          child: LayoutBuilder(builder: (context, constrains) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        maxHeight:
                            constrains.maxHeight - (_bottomAppBarVisible ? bottomAppBarHeight : 0)),
                    child: SingleChildScrollView(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Paragraph(
                            padding: 0,
                            paragraphs: paragraphs,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                if (_bottomAppBarVisible)
                  BottomAppBar(
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () {
                              changeChapter(-1);
                            },
                          ),
                          Expanded(
                            flex: 1,
                            child: Slider(
                              value: book.lastReadPosition / book.size,
                              onChanged: (value) {
                                // Handle progress change
                                handleProgressChange(value);
                              },
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.arrow_forward),
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
                          icon: const Icon(Icons.list),
                          onPressed: () {
                            // Handle bookmark button
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.nightlight),
                          onPressed: () {
                            // Handle favorite button
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.font_download),
                          onPressed: () {
                            // Handle favorite button
                          },
                        ),
                      ])
                    ],
                  ))
              ],
            );
          }),
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    Navigator.pop(context, [chapterTitle, chapterIdx]);
    return Future.value(true); // Return true to allow back navigation, false to prevent
  }
}
