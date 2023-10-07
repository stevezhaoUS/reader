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

  static get defaultSettings {
    return FontsSettings(
      fontFamily: 'SimSun',
      fontSize: 12.00,
      lineHeight: 1.5,
      fontColor: const Color(0xFF000000),
      fontWeight: FontWeight.normal,
    );
  }
}
