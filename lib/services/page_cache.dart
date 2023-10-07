import 'package:isar/isar.dart';
import '../DTO/book_page.dart';
import '../models/book.dart';

class PageCache {
  int maxChapter = 5;
  int currentChapterIdx = 0;
  int currentPageIdx = 0;
  bool _isEmpty = true;
  late final Book _book;
  late BookPage _page;
  Map<int, List<BookPage>> pages = {};
  final Future<List<BookPage>> Function(int chapterIdx)? requestChapter;

  PageCache(this._book, {this.requestChapter, this.maxChapter = 5});

  get isEmpty {
    return _isEmpty;
  }

  void addPage(BookPage page) {
    _isEmpty = false;
    if (pages.containsKey(page.chapterIdx)) {
      pages[page.chapterIdx]?.add(page);
    } else {
      if (pages.length >= maxChapter) {
        // remove the most far distance chapter
        final cid = pages.keys
            .reduce((a, b) => (a - page.chapterIdx).abs() > (b - page.chapterIdx).abs() ? b : a);
        pages.remove(cid);
      }
      pages[page.chapterIdx] = [page];
    }
  }

  void addChapter(int cid, List<BookPage> pages) {
    _isEmpty = false;
    if (this.pages.containsKey(cid)) {
      this.pages[cid]!.addAll(pages);
    } else {
      this.pages[cid] = pages;
    }
  }

  void clear() {
    pages.clear();
    _isEmpty = true;
  }

  Future<BookPage> getPage(int chapterIdx, int pageIdx) async {
    currentPageIdx = pageIdx;
    currentChapterIdx = chapterIdx;
    if (pages.containsKey(chapterIdx)) {
      _page = pages[chapterIdx]![pageIdx];
      return Future.value(_page);
    } else {
      final List<BookPage> newPages = await requestChapter!(chapterIdx);
      addChapter(chapterIdx, newPages);
      _page = pages[chapterIdx]![pageIdx];
      return Future.value(_page);
    }
  }

  bool hasPage(short cid, short lastReadPage) {
    return (pages.containsKey(cid) &&
        pages[cid] is List &&
        pages[cid]!.length > lastReadPage &&
        lastReadPage >= 0);
  }

  bool get hasPrev {
    return currentChapterIdx > 0 || currentPageIdx > 0;
  }

  bool get hasNext {
    return currentChapterIdx < _book.tableOfContents.length;
  }

  Future<BookPage> get curPage {
    return getPage(currentChapterIdx, currentPageIdx);
  }

  void nextPage() {
    if ((currentPageIdx + 1 < (pages[currentChapterIdx]?.length ?? 0)) == true) {
      currentPageIdx++;
    } else if (hasNext) {
      currentChapterIdx++;
      currentPageIdx = 0;
    }
  }

  void prevPage() {
    if (hasPrev) {
      if (currentPageIdx != 0) {
        currentPageIdx--;
      } else {
        currentChapterIdx--;
        if (pages[currentChapterIdx] != null && pages[currentChapterIdx]!.isNotEmpty) {
          currentPageIdx = pages[currentChapterIdx]!.length - 1;
        }
      }
    }
  }
}
