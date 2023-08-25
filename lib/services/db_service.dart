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

  Future<Chapter?> getChatperByIdx(Book book, int idx) async {
    return await book.chapters.filter().idxEqualTo(idx).findFirst();
  }

  nextChapter(Book book) {}
}