import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:reader/DTO/book_page.dart' as dto;

import 'package:reader/models/book.dart';
import 'package:reader/services/db_service.dart';
import 'package:reader/services/page_builder.dart';
import 'package:reader/services/page_cache.dart';
import 'package:reader/services/reading_controller.dart';

import '../DTO/fonts_settings.dart';

class BookPageView extends StatefulWidget {
  final Book book;
  const BookPageView(this.book, {super.key});
  @override
  State<BookPageView> createState() => _BookPageViewState();
}

class _BookPageViewState extends State<BookPageView> {
  late ReadingController _readingController;

  late Chapter? currentChapter;
  late int currentPage = 0;

  @override
  void initState() {
    super.initState();
    _readingController = ReadingController(widget.book);
    _readingController.pageController.addListener(() {
      // if (_pageController.page! >= totalPage - 1) {
      //   _pageController.jumpToPage(0);
      // }
      //call next page or previous page in _readingController
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      _readingController.setViewSize(constraints.maxWidth, constraints.maxHeight);
      return PageView.builder(
        /// [PageView.scrollDirection] defaults to [Axis.horizontal].
        /// Use [Axis.vertical] to scroll vertically.
        controller: _readingController.pageController,
        itemBuilder: (context, index) {
          // String page = pageBuffer[index <= currentChapterBuffer.length ? index : 0];
          return FutureBuilder(
              future: _readingController.getPage(),
              builder: (context, snapshot) {
                List<double> paddings = _readingController.getPaddingLTRB();
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(); // Show a loading indicator while fetching data.
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Padding(
                    padding:
                        EdgeInsets.fromLTRB(paddings[0], paddings[1], paddings[2], paddings[3]),
                    child: RichText(
                      text: TextSpan(
                        text: snapshot.data?.content,
                        style: const TextStyle(color: Colors.black),
                      ),
                      selectionColor: const Color(0xAF6694e8),
                    ),
                  );
                }
              });
        },
      );
    });
  }

  @override
  void dispose() {
    _readingController.dispose();
    super.dispose();
  }

  // Future<List<dto.Page>> getChapterByIndex(int chapterIdx) async {
  //   final cid = widget.book.tableOfContents[chapterIdx].cid;
  //   Chapter? chapter = await dbService.getChapterById(cid);
  //   if (chapter == null) {
  //     return [];
  //   }
  //   return pageBuilder.buildPagesFromChapter(chapter);
  // }
}
