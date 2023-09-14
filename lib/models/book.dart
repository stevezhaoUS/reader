import 'package:isar/isar.dart';

part 'book.g.dart';

@Collection()
class Book {
  Id id = Isar.autoIncrement;
  String title = '';
  String author = '';
  String source = ''; // 书籍来源
  String icon = ''; // 书籍图标路径
  short size = 0;
  short totalChapters = 0;
  short lastChapterIdx = 0;
  short lastReadPosition = 0;
  short lastReadPage = 0;
  DateTime lastUpdate = DateTime.now();
  @Deprecated("useless field")
  String lastReadChapter = "";

  List<ChapterMeta> tableOfContents = [];

  final chapters = IsarLinks<Chapter>();
}

@embedded
class ChapterMeta {
  late int cid; //chapter id
  late String title;
  short offset = 0;
  short size = 0;
}

@collection
class Chapter {
  Id id = Isar.autoIncrement;
  short cid = 0; //chapter id
  late String? title;
  late String? content;

  @Backlink(to: 'chapters')
  final book = IsarLink<Book>();

  Chapter({this.title = '', this.content = ''});
}
