import 'package:flutter/widgets.dart';
import 'package:reader/DTO/book_page.dart';
import 'package:reader/DTO/fonts_settings.dart';
import 'package:reader/models/book.dart';

class PageBuilder {
  FontsSettings fontsSettings;
  double verticalPaddings;
  double horizontalPaddings;

  int wordsPerLine = 0;

  int linesPerPage = 0;

  int wordsPerPage = 0;

  PageBuilder(this.fontsSettings, {this.verticalPaddings = 8.0, this.horizontalPaddings = 8.0});

  void calcTextSizing(width, height) {
    // Calculate the text area
    double textAreaWidth = width - horizontalPaddings * 2; // Adjust the factor as needed
    double textAreaHeight = height - verticalPaddings * 2;

    final textPainter = TextPainter(
        textDirection: TextDirection.ltr,
        text: TextSpan(
          text: "阅读小说\n閱讀小說",
          style: TextStyle(
            fontFamily: fontsSettings.fontFamily,
            fontSize: fontsSettings.fontSize,
            height: fontsSettings.lineHeight,
            fontWeight: fontsSettings.fontWeight,
          ),
        ));

    textPainter.layout();

    double wordWidth = textPainter.width / 4;
    double lineHeight = textPainter.height / 2;
    wordsPerLine = textAreaWidth ~/ wordWidth;
    linesPerPage = textAreaHeight ~/ lineHeight - 1;
    wordsPerPage = linesPerPage * wordsPerLine;
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
      if (buffer.isNotEmpty && content[offset] == ' ' && content[offset + 1] == ' ') {
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
