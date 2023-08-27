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
    late Book book = Book()..title = title;

    final file = File(filePath);
    final stream =
        file.openRead().transform(gbk.decoder).transform(const LineSplitter()).asBroadcastStream();

    stream.takeWhile((line) => chapterPattern.firstMatch(line) == null).listen((line) {
      final match = authorPattern.firstMatch(line);
      if (match != null) {
        author = match.group(0)!;
      }
      book.author = author;
      isar.createBook(book);
    });

    processAndSaveChapter(stream).listen((ChapterMeta chapterMeta) {
      book.tableOfContents.add(chapterMeta);
    }).onDone(() async {
      final ids = book.tableOfContents.map((meta) => meta.cid);
      final chapters = await isar.getChaptersByIds(ids.toList());
      book.size = book.tableOfContents.last.size + book.tableOfContents.last.offset;
      isar.addChaptersToBook(book, chapters.whereType<Chapter>().toList());
    });
  }

  Stream<ChapterMeta> processAndSaveChapter(Stream<String> stream) async* {
    final buffer = StringBuffer();
    String currentChapterTitle = '';
    int pos = 0;

    createChapter(title, content) async {
      Chapter chapter = Chapter()
        ..title = title
        ..content = content;
      int id = await isar.createChapter(chapter);
      final meta = ChapterMeta()
        ..cid = id
        ..offset = pos
        ..size = content.length
        ..title = title;
      return meta;
    }

    await for (var line in stream) {
      final match = chapterPattern.firstMatch(line);
      if (match != null) {
        //write the previous chapter
        yield await createChapter(currentChapterTitle, buffer.toString());
        pos += buffer.length;
        buffer.clear();
        currentChapterTitle = match.group(0)!.trimLeft();
      } else {
        buffer.write(line);
      }
    }
    yield await createChapter(currentChapterTitle, buffer.toString());
  }
}
