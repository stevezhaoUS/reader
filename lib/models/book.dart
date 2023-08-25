import 'package:isar/isar.dart';

part 'book.g.dart';

@Collection()
class Book {
  Id id = Isar.autoIncrement;
  String title = '';
  String author = '';
  String source = ''; // 书籍来源
  String icon = ''; // 书籍图标路径
  int totalChapters = 0;
  int lastChapterIdx = 1;
  int lastReadPosition = 0;
  DateTime lastUpdate = DateTime.now();
  String lastReadChapter = "";

  List<ChapterMeta> tableOfContents = [];

  final chapters = IsarLinks<Chapter>();
}

@embedded
class ChapterMeta {
  late int idx;
  late String title;
}

@collection
class Chapter {
  Id id = Isar.autoIncrement;
  int cid = 0;
  late String? title;
  late String? content;
  @Backlink(to: 'chapters')
  final book = IsarLink<Book>();

  Chapter({this.title = '', this.content = ''});
}
