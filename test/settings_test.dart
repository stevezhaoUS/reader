import 'package:flutter_test/flutter_test.dart';
import 'package:reader/models/user_settings.dart';
import 'package:reader/services/settings_service.dart';
import 'dart:io';

void main() {
  group('UserSettings', () {
    test('should create default settings', () {
      final settings = UserSettings.defaultSettings();
      
      expect(settings.useDarkMode, false);
      expect(settings.useFingerprint, false);
      expect(settings.language, 'en');
      expect(settings.fontFamily, 'SimSun');
      expect(settings.fontSize, 14.0);
      expect(settings.lineHeight, 1.5);
      expect(settings.fontColor, 0xFF000000);
      expect(settings.fontWeight, 400);
    });

    test('should serialize to and from JSON', () {
      final originalSettings = UserSettings(
        useDarkMode: true,
        useFingerprint: true,
        language: 'zh',
        fontFamily: 'Arial',
        fontSize: 16.0,
        lineHeight: 1.8,
        fontColor: 0xFF333333,
        fontWeight: 700,
      );

      final jsonString = originalSettings.toJsonString();
      final deserializedSettings = UserSettings.fromJsonString(jsonString);

      expect(deserializedSettings.useDarkMode, originalSettings.useDarkMode);
      expect(deserializedSettings.useFingerprint, originalSettings.useFingerprint);
      expect(deserializedSettings.language, originalSettings.language);
      expect(deserializedSettings.fontFamily, originalSettings.fontFamily);
      expect(deserializedSettings.fontSize, originalSettings.fontSize);
      expect(deserializedSettings.lineHeight, originalSettings.lineHeight);
      expect(deserializedSettings.fontColor, originalSettings.fontColor);
      expect(deserializedSettings.fontWeight, originalSettings.fontWeight);
    });

    test('should create copy with updated values', () {
      final originalSettings = UserSettings.defaultSettings();
      final updatedSettings = originalSettings.copyWith(
        useDarkMode: true,
        language: 'zh',
      );

      expect(updatedSettings.useDarkMode, true);
      expect(updatedSettings.language, 'zh');
      // Other values should remain the same
      expect(updatedSettings.useFingerprint, originalSettings.useFingerprint);
      expect(updatedSettings.fontFamily, originalSettings.fontFamily);
    });

    test('should handle invalid JSON gracefully', () {
      expect(() => UserSettings.fromJsonString('invalid json'), throwsA(isA<FormatException>()));
    });
  });
}