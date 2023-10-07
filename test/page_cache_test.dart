import 'package:flutter_test/flutter_test.dart';
import 'package:reader/DTO/book_page.dart';
import 'package:reader/models/book.dart';
import 'package:reader/services/page_cache.dart';

void main() {
  Book book = Book();
  test('Adding and retrieving pages', () async {
    final pageCache = PageCache(book, requestChapter: (chapterIdx) async {
      // Replace this with your mock implementation of requestChapter function
      return [];
    });

    BookPage page = BookPage(chapterIdx: 0, content: 'page1');
    pageCache.addPage(page);
    page = BookPage(chapterIdx: 0, content: 'page2');
    pageCache.addPage(page);
    page = BookPage(chapterIdx: 0, content: 'page3');
    pageCache.addPage(page);

    BookPage retrievedPage = await pageCache.getPage(page.chapterIdx, 0);
    expect(retrievedPage.content, equals('page1'));
    retrievedPage = await pageCache.getPage(page.chapterIdx, 1);
    expect(retrievedPage.content, equals('page2'));
    retrievedPage = await pageCache.getPage(page.chapterIdx, 2);
    expect(retrievedPage.content, equals('page3'));
  });

  test('Adding whole chapter at once', () async {
    final pageCache = PageCache(book, requestChapter: (chapterIdx) async {
      // Replace this with your mock implementation of requestChapter function
      return [];
    });

    BookPage page = BookPage(chapterIdx: 0, content: 'page1');
    pageCache.addPage(page);
    page = BookPage(chapterIdx: 0, content: 'page2');
    pageCache.addPage(page);
    page = BookPage(chapterIdx: 0, content: 'page3');
    pageCache.addPage(page);

    List<BookPage> pages = [
      BookPage(chapterIdx: 0, content: 'page4'),
      BookPage(chapterIdx: 0, content: 'page5'),
      BookPage(chapterIdx: 0, content: 'page6'),
    ];
    pageCache.addChapter(0, pages);

    BookPage retrievedPage = await pageCache.getPage(page.chapterIdx, 0);
    expect(retrievedPage.content, equals('page1'));
    retrievedPage = await pageCache.getPage(page.chapterIdx, 1);
    expect(retrievedPage.content, equals('page2'));
    retrievedPage = await pageCache.getPage(page.chapterIdx, 2);
    expect(retrievedPage.content, equals('page3'));
    retrievedPage = await pageCache.getPage(page.chapterIdx, 3);
    expect(retrievedPage.content, equals('page4'));
    retrievedPage = await pageCache.getPage(page.chapterIdx, 4);
    expect(retrievedPage.content, equals('page5'));
    retrievedPage = await pageCache.getPage(page.chapterIdx, 5);
    expect(retrievedPage.content, equals('page6'));
  });

  //test clear function of page cache that should has no pages
  test('after clear function, cache should be empty', () async {
    final pageCache = PageCache(book, requestChapter: (chapterIdx) async {
      // Replace this with your mock implementation of requestChapter function
      return [];
    });

    BookPage page = BookPage(chapterIdx: 0, content: 'page1');
    pageCache.addPage(page);
    page = BookPage(chapterIdx: 0, content: 'page2');
    pageCache.addPage(page);
    page = BookPage(chapterIdx: 0, content: 'page3');
    pageCache.addPage(page);

    pageCache.clear();
    expect(pageCache.pages.length, equals(0));
  });

  test('requestChapter should be called if the chapter is not in cache', () async {
    int requestChapterCalled = 0;
    final pageCache = PageCache(book, requestChapter: (chapterIdx) async {
      requestChapterCalled++;
      return [BookPage(chapterIdx: 1, content: 'page1')];
    });

    BookPage page = BookPage(chapterIdx: 0, content: 'page1');
    pageCache.addPage(page);
    page = BookPage(chapterIdx: 0, content: 'page2');
    pageCache.addPage(page);
    page = BookPage(chapterIdx: 0, content: 'page3');
    pageCache.addPage(page);

    await pageCache.getPage(1, 0);
    expect(requestChapterCalled, equals(1));
  });

  test('chapter will be deleted if exceed maximum chapter length', () async {
    final pageCache = PageCache(book, requestChapter: (chapterIdx) async {
      // Replace this with your mock implementation of requestChapter function
      return [];
    }, maxChapter: 2);

    BookPage page = BookPage(chapterIdx: 0, content: 'page1');
    pageCache.addPage(page);
    page = BookPage(chapterIdx: 1, content: 'page2');
    pageCache.addPage(page);
    page = BookPage(chapterIdx: 2, content: 'page3');
    pageCache.addPage(page);

    expect(pageCache.pages.length, equals(2));
  });
}
