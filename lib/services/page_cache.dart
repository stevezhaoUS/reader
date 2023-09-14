import '../DTO/book_page.dart';

class PageCache {
  int maxChapter = 5;
  int currentChapterIdx = 0;
  int currentPage = 0;
  bool _isEmpty = true;
  Map<int, List<BookPage>> pages = {};
  final Future<List<BookPage>> Function(int chapterIdx)? requestChapter;

  PageCache({this.requestChapter, this.maxChapter = 5});

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
    currentPage = pageIdx;
    currentChapterIdx = chapterIdx;
    if (pages.containsKey(chapterIdx)) {
      return Future.value(pages[chapterIdx]![pageIdx]);
    } else {
      final List<BookPage> newPages = await requestChapter!(chapterIdx);
      addChapter(chapterIdx, newPages);
      return Future.value(pages[chapterIdx]?[pageIdx]);
    }
  }
}
