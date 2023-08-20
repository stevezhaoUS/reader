import 'package:isar/isar.dart';

part 'book.g.dart';

@Collection()
class Book {
  Id id = Isar.autoIncrement;
  String? title;
  String? author;
  int currentChapterId = 0;
  String lastChapterTitle = '';
  List<Chapter> chapters = [];
}

@embedded
class Chapter {
  late String? title;
  late String? content;

  Chapter({this.title = '', this.content = ''});
}
