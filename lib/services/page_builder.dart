import 'package:flutter/widgets.dart';
import 'package:reader/DTO/book_page.dart';
import 'package:reader/DTO/fonts_settings.dart';
import 'package:reader/models/book.dart';

String example = "马炕;，看到  乳房和着的圣子肉嘟嘟的脸上。去年夏季房屋漏雨，在这张油画上留下了一团团焦黄的水渍；圣母和圣子";

class PageBuilder {
  FontsSettings fontsSettings;
  double paddings;

  int wordsPerLine = 0;

  int linesPerPage = 0;

  int wordsPerPage = 0;

  PageBuilder(this.fontsSettings, {this.paddings = 8.0});

  void calcTextSizing(width, height) {
    double textAreaWidth = width - paddings * 2;
    double textAreaHeight = height - paddings * 2;

    final textPainter = TextPainter(
        textDirection: TextDirection.ltr,
        text: TextSpan(
          text: example,
          style: TextStyle(
            fontFamily: fontsSettings.fontFamily,
            fontSize: fontsSettings.fontSize,
            height: fontsSettings.lineHeight,
            fontWeight: fontsSettings.fontWeight,
          ),
        ));

    textPainter.layout();

    double wordWidth = textPainter.width / example.length;
    double lineHeight = fontsSettings.fontSize * fontsSettings.lineHeight;
    wordsPerLine = textAreaWidth ~/ wordWidth - 1;
    linesPerPage = textAreaHeight ~/ lineHeight - 1;
    wordsPerPage = linesPerPage * wordsPerLine;

    debugPrint('width: $width, height: $height \n'
        'wordWidth: $wordWidth, lineHeight: $lineHeight \n'
        'wordsPerLine: $wordsPerLine, linesPerPage: $linesPerPage, wordsPerPage: $wordsPerPage');
  }

  List<BookPage> buildPagesFromChapter(Chapter chapter) {
    String? content = chapter.content;
    if (content == null) {
      return [BookPage(chapterIdx: chapter.cid, content: 'no content')];
    }

    int offset = 0;
    List<BookPage> pageBuffer = [];
    int lines = 0;
    int charsInLine = 0;
    StringBuffer buffer = StringBuffer();
    while (offset < content.length) {
      if (lines >= linesPerPage) {
        String pageContent = buffer.toString();
        pageBuffer.add(BookPage(chapterIdx: chapter.cid, content: pageContent));
        lines = 0;
        charsInLine = 0;
        buffer.clear();
        continue;
      }
      if (buffer.isNotEmpty && // 两个全角空格换行
          content[offset].runes.first == 0x3000 &&
          content[offset + 1].runes.first == 0x3000) {
        buffer.write('\n  ');
        while (content[++offset] == ' ') {}
        lines += 1;
        charsInLine = 2;
      }
      if (charsInLine >= wordsPerLine) {
        lines++;
        charsInLine = 0;
        buffer.write('\n');
        continue;
      }
      buffer.write(content[offset]);
      charsInLine++;
      offset++;
    }
    pageBuffer.add(BookPage(chapterIdx: chapter.cid, content: buffer.toString()));
    return pageBuffer;
  }
}
