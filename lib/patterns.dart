final nameRegex = RegExp(r'\s+作\s*者.*|\s+\S+\s+著');
// final authorRegex = RegExp(r'^\s*作\s*者[:：\s]+|\s+著');
final authorPattern = RegExp(
  r'(?<=作者[:：\s])\S+|(?<=\s著)\S+',
);
final fileNameRegex = RegExp(r'[\\/:*?"<>|.]');
final splitGroupRegex = RegExp(r'[,;，；]');
final titleNumPattern = RegExp(r'(第)(.+?)(章)');
final chapterPattern = RegExp(r"^\s*(?:第[一二三四五六七八九十百千万]+[章卷节]).*", multiLine: true);
