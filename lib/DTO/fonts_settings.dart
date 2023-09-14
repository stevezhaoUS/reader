import 'dart:ui';

class FontsSettings {
  String fontFamily;
  double fontSize;
  double lineHeight;
  Color fontColor;
  FontWeight fontWeight = FontWeight.normal;

  FontsSettings({
    required this.fontFamily,
    required this.fontSize,
    required this.lineHeight,
    required this.fontColor,
    required this.fontWeight,
  });

  static defaultSettings() {
    return FontsSettings(
      fontFamily: 'Roboto',
      fontSize: 15.00,
      lineHeight: 1,
      fontColor: const Color(0xFF000000),
      fontWeight: FontWeight.normal,
    );
  }
}
