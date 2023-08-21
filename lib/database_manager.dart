import 'package:async/async.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'models/book.dart'; // Import your model classes

class DBManager {
  // Singleton pattern
  static final DBManager _dbManager = DBManager._internal();
  DBManager._internal();
  static DBManager get instance => _dbManager;

  // Members
  static late Isar _isar;
  final _initDBMemoizer = AsyncMemoizer<Isar>();

  Future<Isar> get isar async {
    // ignore: unnecessary_null_comparison

    // if _database is null we instantiate it
    _isar = await _initDBMemoizer.runOnce(() async {
      return await _initDB();
    });
    return _isar;
  }

  Future<Isar> _initDB() async {
    // .. Copy initial database (data.db) from assets file to database path
    final appDocumentDir = await getApplicationDocumentsDirectory();
    return await Isar.open([BookSchema], directory: appDocumentDir.path);
  }

  Future<void> updateBook(Book book) async {
    await _isar.writeTxn(() async {
      _isar.books.put(book);
    });
  }

  Future<List<Book>> getAllBooks() async {
    final db = await isar;
    return db.books.where().offset(0).limit(10).findAll();
  }

  Future<List<Book>> getBook(String bookTitle) async {
    final db = await isar;
    return await db.books.filter().titleMatches(bookTitle).findAll();
  }

  Future<Book?> getBookById(int id) async {
    final db = await isar;
    return await db.books.filter().idEqualTo(id).findFirst();
  }
}
