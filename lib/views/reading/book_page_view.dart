import 'package:flutter/material.dart';
import 'package:reader/DTO/fonts_settings.dart';
import 'package:reader/models/book.dart';
import 'package:reader/services/reading_controller.dart';

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
    // _readingController.pageController.addListener(() {
    //   // if (_pageController.page! >= totalPage - 1) {
    //   //   _pageController.jumpToPage(0);
    //   // }
    //   //call next page or previous page in _readingController
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LayoutBuilder(builder: (context, constraints) {
        _readingController.setViewSize(constraints.maxWidth, constraints.maxHeight);
        return GestureDetector(
          onHorizontalDragEnd: (details) {
            if (details.velocity.pixelsPerSecond.dx > 0) {
              // Swipe from right to left
              _readingController.goPrevPage();
            } else {
              // Swipe from left to right
              _readingController.goNextPage();
            }
          },
          child: PageView.builder(
            physics: const NeverScrollableScrollPhysics(),

            /// [PageView.scrollDirection] defaults to [Axis.horizontal].
            /// Use [Axis.vertical] to scroll vertically.
            controller: _readingController.pageController,
            // ignore: prefer_const_constructors
            itemBuilder: (context, index) {
              // String page = pageBuffer[index <= currentChapterBuffer.length ? index : 0];
              debugPrint('build page $index');
              return FutureBuilder(
                  future: _readingController.getPage(index),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator(); // Show a loading indicator while fetching data.
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          padding: EdgeInsets.all(_readingController.getPaddings()),
                          width: double.infinity,
                          child: RichText(
                            textAlign: TextAlign.left,
                            text: TextSpan(
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: FontsSettings.defaultSettings.fontFamily,
                                fontWeight: FontsSettings.defaultSettings.fontWeight,
                                fontSize: FontsSettings.defaultSettings.fontSize,
                                height: FontsSettings.defaultSettings.lineHeight,
                              ),
                              text: snapshot.data?.content,
                            ),
                            selectionColor: const Color(0xAF6694e8),
                          ),
                        ),
                      );
                    }
                  });
            },
          ),
        );
      }),
    );
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
