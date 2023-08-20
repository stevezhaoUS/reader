import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'models/book.dart'; // Import your model classes

class DatabaseManager {
  static DatabaseManager? _instance;
  late final Isar _isar;

  static Future<DatabaseManager> getInstance() async {
    if (_instance == null) {
      _instance = DatabaseManager();
      await _instance!._initIsar();
    }

    return _instance!;
  }

  Future<void> _initIsar() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open([BookSchema], directory: appDocumentDir.path);
  }

  Future<void> insertBook(Book book) async {
    await _isar.writeTxn(() async {
      _isar.books.put(book);
    });
  }

  Future<List<Book>> getAllBooks() async {
    return await _isar.books.where().offset(0).limit(10).findAll();
  }

  Future<List<Book>> getBook(String bookTitle) async {
    return await _isar.books.filter().titleMatches(bookTitle).findAll();
  }

  Future<Book?> getBookById(int id) async {
    return await _isar.books.filter().idEqualTo(id).findFirst();
  }
}
