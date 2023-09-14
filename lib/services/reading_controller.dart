import 'package:flutter/material.dart';
import 'package:reader/DTO/book_page.dart';
import 'package:reader/services/page_builder.dart';
import 'package:reader/services/page_cache.dart';

import '../DTO/fonts_settings.dart';
import '../models/book.dart';
import 'db_service.dart';

const int maxPages = 5;
const int initialPage = 3;

class ReadingController {
  final Book book;
  late PageCache pageCache;
  late PageBuilder pageBuilder;
  late DBService dbService = DBService();
  late Chapter? currentChapter;
  final PageController _pageController = PageController(initialPage: initialPage);
  int internalPage = 0;

  get pageController {
    return _pageController;
  }

  void dispose() {
    _pageController.dispose();
  }

  ReadingController(this.book) {
    pageCache = PageCache(requestChapter: getChapterByIndex);
    pageBuilder = PageBuilder(FontsSettings.defaultSettings());
  }

  Future<List<BookPage>> getChapterByIndex(int chapterIdx) async {
    return Future.value([BookPage(chapterIdx: chapterIdx, content: '')]);
  }

  setViewSize(double width, double height) {
    pageBuilder.calcTextSizing(width, height);
  }

  Future<BookPage> getPage() async {
    if (pageCache.isEmpty) {
      currentChapter = await dbService.getLastReadChapter(book);
      currentChapter ??= await dbService.getChapterById(book.tableOfContents[0].cid);
      if (currentChapter == null) {
        throw Exception('could not load chapters');
        // will implement try to download the chapter if the book is from internet
      }
      List<BookPage> pages = pageBuilder.buildPagesFromChapter(currentChapter!);
      pageCache.addChapter(currentChapter!.cid, pages);
      if (book.lastReadPage > 0) {
        internalPage = book.lastReadPage;
        return pageCache.getPage(currentChapter!.id, book.lastReadPage);
      }
    }
    return pageCache.getPage(currentChapter!.id, internalPage);
  }

  List<double> getPaddingLTRB() {
    return [
      pageBuilder.horizontalPaddings / 2,
      pageBuilder.verticalPaddings / 2,
      pageBuilder.horizontalPaddings / 2,
      pageBuilder.verticalPaddings / 2
    ];
  }
  /*
  void setupWatcher() async {
    Isar isar = await dbService.db;
    isar.books.watchObject(widget.book.id).listen((book) {
      debugPrint('event: ${book?.lastChapterIdx}');
    });
  }
  */

  goPrevPage() {}
  goNextPage() {}
  jumpToPage() {}
  openBook(Book book) {}
}
