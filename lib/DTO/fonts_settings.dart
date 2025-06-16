import 'dart:ui';
import '../models/user_settings.dart';

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
      fontSize: 14.00,
      lineHeight: 1.5,
      fontColor: const Color(0xFF000000),
      fontWeight: FontWeight.normal,
    );
  }

  // Create FontsSettings from UserSettings for backward compatibility
  static FontsSettings fromUserSettings(UserSettings userSettings) {
    return FontsSettings(
      fontFamily: userSettings.fontFamily,
      fontSize: userSettings.fontSize,
      lineHeight: userSettings.lineHeight,
      fontColor: Color(userSettings.fontColor),
      fontWeight: FontWeight.values.firstWhere(
        (fw) => fw.index == (userSettings.fontWeight ~/ 100) - 1,
        orElse: () => FontWeight.normal,
      ),
    );
  }
}
