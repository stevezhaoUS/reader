import 'package:flutter_test/flutter_test.dart';
import 'package:reader/DTO/book_page.dart';
import 'package:reader/DTO/fonts_settings.dart';
import 'package:reader/models/book.dart';
import 'package:reader/services/page_builder.dart';

void main() {
  test('calcTextSizing', () async {
    final pageBuilder = PageBuilder(FontsSettings.defaultSettings);
    pageBuilder.calcTextSizing(100.0, 100.0);
    expect(pageBuilder.wordsPerLine, equals(5));
    expect(pageBuilder.linesPerPage, equals(4));
    expect(pageBuilder.wordsPerPage, equals(20));

    pageBuilder.calcTextSizing(400, 800);
    // (400 - 16) / 15 = 25.6
    expect(pageBuilder.wordsPerLine, equals(25));
    // (800 - 16) / 15 = 52
    expect(pageBuilder.linesPerPage, equals(51));
    // 25 * 51 = 1275
    expect(pageBuilder.wordsPerPage, equals(1275));
  });

  test('generatePagesFromChapter', () async {
    final pageBuilder = PageBuilder(FontsSettings.defaultSettings);
    pageBuilder.calcTextSizing(100, 100);
    Chapter chapter = Chapter(title: 'Chapter 1', content: '''一二三  四五六  七八九  十一二三''');
    List<BookPage> pages = pageBuilder.buildPagesFromChapter(chapter);
    expect(pages.length, equals(2));
    expect(pages[0].content, equals('一二三\n  四五六\n  七八九\n  十一二\n')); //分段測試

    chapter = Chapter(title: 'Chapter 1', content: '''一二三四五一二三四五一二三四五一二三四五一二三四五''');
    pages = pageBuilder.buildPagesFromChapter(chapter);
    expect(pages.length, equals(2));
    expect(pages[1].content, equals('一二三四五')); //分頁測試
  });
}
