import 'package:flutter/material.dart';
import 'package:reader/DTO/book_page.dart';
import 'package:reader/services/page_builder.dart';
import 'package:reader/services/page_cache.dart';

import '../DTO/fonts_settings.dart';
import '../models/book.dart';
import 'db_service.dart';

const int initialPage = 10000;

class ReadingController {
  final Book book;
  late PageCache pageCache;
  late PageBuilder pageBuilder;
  late DBService dbService = DBService();
  late Chapter? currentChapter;
  final PageController _pageController = PageController(initialPage: initialPage);
  int _lastPage = initialPage;
  bool allowSwipeLeft = false;
  double pageWidth = 0;
  double pageHeight = 0;

  get pageController {
    return _pageController;
  }

  void dispose() {
    _pageController.dispose();
  }

  ReadingController(this.book) {
    pageCache = PageCache(book, requestChapter: getChapterByIndex);
    pageBuilder = PageBuilder(FontsSettings.defaultSettings);
  }

  Future<List<BookPage>> getChapterByIndex(int chapterIdx) async {
    int id = book.tableOfContents[chapterIdx].cid;
    Chapter? chapter = await dbService.getChapterById(id);
    if (chapter != null) {
      return pageBuilder.buildPagesFromChapter(chapter);
    } else {
      return pageBuilder
          .buildPagesFromChapter(Chapter(title: 'Not found', content: 'Content not found'));
    }
  }

  setViewSize(double width, double height) {
    if (pageWidth == width && pageHeight == height) {
      return;
    }
    pageWidth = width;
    pageHeight = height;
    pageBuilder.calcTextSizing(width, height);
    pageCache.clear();
  }

  Future<BookPage> getPage(int _) async {
    if (pageCache.isEmpty) {
      currentChapter = await dbService.getLastReadChapter(book);
      currentChapter ??= await dbService.getChapterById(book.tableOfContents[0].cid);
      if (currentChapter == null) {
        throw Exception('could not load chapters');
        // will implement try to download the chapter if the book is from internet
      }

      List<BookPage> pages = pageBuilder.buildPagesFromChapter(currentChapter!);
      pageCache.addChapter(currentChapter!.cid, pages);
      if (pageCache.hasPage(currentChapter!.cid, book.lastReadPage)) {
        _lastPage += book.lastChapterIdx;
        _pageController.jumpToPage(_lastPage);
        return pageCache.getPage(currentChapter!.cid, book.lastReadPage);
      }
    }

    allowSwipeLeft = pageCache.hasPrev;

    return pageCache.curPage;
  }

  double getPaddings() {
    return pageBuilder.paddings;
  }
  /*
  void setupWatcher() async {
    Isar isar = await dbService.db;
    isar.books.watchObject(widget.book.id).listen((book) {
      debugPrint('event: ${book?.lastChapterIdx}');
    });
  }
  */

  goPrevPage() {
    if (pageCache.hasPrev) {
      pageCache.prevPage();
      _pageController.previousPage(
          duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
    }
  }

  goNextPage() {
    if (pageCache.hasNext) {
      pageCache.nextPage();
      _pageController.nextPage(
          duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
    }
  }

  jumpToPage() {}
  openBook(Book book) {}
}
