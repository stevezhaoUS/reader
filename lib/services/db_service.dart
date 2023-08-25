import 'dart:math';

import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../models/book.dart'; // Import your model classes

class DBService {
  late Future<Isar> db;

  DBService() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      final appDocumentDir = await getApplicationDocumentsDirectory();
      return await Isar.open([BookSchema, ChapterSchema], directory: appDocumentDir.path);
    }
    return Future.value(Isar.getInstance());
  }

  Future<void> createBook(Book book) async {
    final isar = await db;
    await isar.writeTxnSync(() async {
      isar.books.putSync(book);
    });
  }

  Future<void> update(Book book) async {
    final isar = await db;
    await isar.writeTxn(() async {
      isar.books.put(book);
    });
  }

  Future<List<Book>> fetchBooks(int offset) async {
    final isar = await db;
    return isar.books.where().offset(offset).limit(10).findAll();
  }

  Future<Book?> getBookByTitle(String bookTitle) async {
    final isar = await db;
    return await isar.books.filter().titleMatches(bookTitle).findFirst();
  }

  Future<Book?> getBookById(int id) async {
    final isar = await db;
    return await isar.books.filter().idEqualTo(id).findFirst();
  }

  Future deleteBook(int id) async {
    final isar = await db;
    return await isar.writeTxn(() async {
      await isar.books.delete(id);
    });
  }

  Future<Chapter?> getChatperByCid(Book book, int cid) async {
    return await book.chapters.filter().cidEqualTo(cid).findFirst();
  }

  getChapterIdxFromPosition(Book book, int position) {
    if (position >= book.size) {
      book.lastChapterIdx = book.totalChapters;
      book.lastReadPosition = book.tableOfContents[book.totalChapters - 1].offset;
    }
    final table = book.tableOfContents;
    bool found = false;
    int idx = 1;

    while (!found) {
      if (position < table[idx].offset) {
        return idx;
      }
      idx++;
    }
  }
}
