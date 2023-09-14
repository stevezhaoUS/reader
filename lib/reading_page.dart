import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:reader/services/db_service.dart';
import 'package:reader/ui/paragraph.dart';
import 'package:reader/views/book_page_view.dart';
import 'models/book.dart';

enum ReadingMode { page, scroll }

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
  bool _appBarVisible = true;
  int readingPosition = 0;
  late Book book;
  DBService isar = DBService();
  ReadingMode readingMode = ReadingMode.page;

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
      _appBarVisible = !_appBarVisible;
    });
  }

  void updateOffset(int offset) {}

  void changeChapter(int step) async {
    int idx = min(max(0, chapterIdx + step), book.tableOfContents.length - 1);
    Chapter? chapter = await isar.getChapterById(book.tableOfContents[idx].cid);
    int offset = book.tableOfContents[idx].offset;
    if (chapter != null) {
      setState(() {
        chapterContent = chapter.content ?? 'Content Missing...';
        chapterIdx = idx;
        chapterTitle = chapter.title!;
      });
      book.lastReadPosition = offset;
      book.lastChapterIdx = idx;
      isar.update(book);
    }
  }

  @override
  Widget build(BuildContext context) {
    final title = chapterTitle;
    final paragraphs = chapterContent.split(RegExp(r'\s{2,}'));

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: _appBarVisible
            ? AppBar(
                title: Text(title),
              )
            : null,
        body: GestureDetector(
          onTap: () {
            _toggleBottomAppBarVisibility();
          },
          child: LayoutBuilder(builder: (context, constrains) {
            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                readingMode == ReadingMode.page
                    ? BookPageView(book)
                    : ScrollReadingView(paragraphs: paragraphs, onOffsetChanged: updateOffset),
                if (_appBarVisible) buildBottomAppBar()
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget buildBottomAppBar() {
    return BottomAppBar(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Visibility(
          visible: true, //readingMode == ReadingMode.scroll,
          child: Row(
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
        ),
        Visibility(
          visible: readingMode == ReadingMode.scroll,
          child: const Divider(),
        ),
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
    ));
  }

  Future<bool> _onBackPressed() async {
    Navigator.pop(context, [chapterTitle, chapterIdx]);
    return Future.value(true); // Return true to allow back navigation, false to prevent
  }
}

class ScrollReadingView extends StatefulWidget {
  final List<String> paragraphs;
  const ScrollReadingView(
      {super.key,
      required this.paragraphs,
      scrollOffset,
      required void Function(int offset) onOffsetChanged});

  @override
  State<ScrollReadingView> createState() => _ScrollReadingViewState();
}

class _ScrollReadingViewState extends State<ScrollReadingView> {
  double scrollOffset = 0.0;

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController(initialScrollOffset: scrollOffset);
    return SingleChildScrollView(
      controller: scrollController,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Paragraph(
            padding: 0,
            paragraphs: widget.paragraphs,
          ),
        ),
      ),
    );
  }
}
