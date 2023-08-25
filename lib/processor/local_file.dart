import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:fast_gbk/fast_gbk.dart';
import 'package:path/path.dart';
import 'package:reader/services/db_service.dart';
import 'package:reader/patterns.dart';

import '../models/book.dart';

class LocalFileProcessor {
  String title = '';
  String author = '';
  DBService isar = DBService();

  Future<void> loadAndProcessFile(String filePath) async {
    title = basenameWithoutExtension(filePath);
    int chapterIdx = 1;

    final file = File(filePath);
    final stream = file.openRead().transform(gbk.decoder);

    final buffer = StringBuffer();
    String currentChapterTitle = '';
    late Book book = Book()..title = title;
    await for (var chunk in stream.transform(const LineSplitter())) {
      final chunkContent = chunk.toString();

      if (author == '') {
        final match = authorPattern.firstMatch(chunkContent);
        if (match != null) {
          author = match.group(0)!;
        }
        book.author = author;
      }

      final match = chapterPattern.firstMatch(chunkContent);

      if (match != null) {
        // if current chapter is not empty then write it to the book
        if (currentChapterTitle.isNotEmpty && buffer.isNotEmpty) {
          Chapter chapter = Chapter()
            ..title = currentChapterTitle
            ..content = buffer.toString()
            ..cid = chapterIdx;

          book.chapters.add(chapter);
          ChapterMeta directory = ChapterMeta()
            ..idx = chapterIdx
            ..title = currentChapterTitle;
          book.tableOfContents.add(directory);
          chapterIdx++;
        }

        currentChapterTitle = match.group(0)!.trim();
        // Truncate the buffer to only keep the current chapter content
        buffer.clear();
      } else {
        buffer.write(chunk);
      }
    }
    book.totalChapters = chapterIdx - 1;
    isar.createBook(book);
  }
}
