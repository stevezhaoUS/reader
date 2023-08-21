import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:fast_gbk/fast_gbk.dart';
import 'package:path/path.dart';
import 'package:reader/database_manager.dart';
import 'package:reader/patterns.dart';

import '../models/book.dart';

class LocalFileProcessor {
  String title = '';
  String author = '';

  Future<void> loadAndProcessFile(String filePath) async {
    final dbHelper = DBManager.instance;
    title = basenameWithoutExtension(filePath);

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
            ..content = buffer.toString();
          book.chapters.add(chapter);
        }

        currentChapterTitle = match.group(0)!.trim();
        // Truncate the buffer to only keep the current chapter content
        buffer.clear();
      } else {
        buffer.write(chunk);
      }
    }
    await dbHelper.updateBook(book);
  }
}
