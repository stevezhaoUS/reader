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

  Future<void> addChaptersToBook(Book book, List<Chapter> chapters) async {
    final isar = await db;
    await isar.writeTxn(() async {
      book.chapters.addAll(chapters);
      book.chapters.save();
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

  Future<Chapter?> getChapterById(int id) async {
    final isar = await db;
    return await isar.chapters.get(id);
  }

  Future deleteBook(Book book) async {
    final isar = await db;
    return await isar.writeTxn(() async {
      book.chapters.filter().deleteAll();
      isar.books.delete(book.id);
    });
  }

  Future<Iterable<Chapter?>> getChaptersByIds(List<int> ids) async {
    final isar = await db;
    return await isar.chapters.getAll(ids);
  }

  getChapterIdxFromPosition(Book book, int position) {
    final table = book.tableOfContents;
    if (position >= book.size) {
      return table.last.cid;
    }
    int idx = 0;

    while (idx < table.length) {
      var ChapterMeta(:offset, :size) = table[idx];
      if (position > offset && position < offset + size) {
        return table[idx].cid;
      }
      idx++;
    }
    return table.last.cid;
  }

  Future<int> createChapter(Chapter chapter) async {
    final isar = await db;
    return await isar.writeTxn(() async {
      return isar.chapters.put(chapter);
    });
  }
}
