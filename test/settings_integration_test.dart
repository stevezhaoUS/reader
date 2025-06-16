import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reader/main.dart';
import 'package:reader/services/settings_service.dart';

void main() {
  group('Settings Integration Tests', () {
    testWidgets('Settings page loads and displays current settings', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Navigate to settings page
      await tester.tap(find.byIcon(Icons.settings));
      await tester.pumpAndSettle();

      // Verify settings page is displayed
      expect(find.text('Settings'), findsOneWidget);
      expect(find.text('Language'), findsOneWidget);
      expect(find.text('Use fingerprint'), findsOneWidget);
      expect(find.text('Dark mode'), findsOneWidget);
    });

    testWidgets('Dark mode toggle works', (WidgetTester tester) async {
      // Reset settings to defaults before test
      await SettingsService.instance.resetToDefaults();
      
      // Build our app and trigger a frame.
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Navigate to settings page
      await tester.tap(find.byIcon(Icons.settings));
      await tester.pumpAndSettle();

      // Find and tap the dark mode switch
      final darkModeSwitch = find.byType(Switch).last;
      await tester.tap(darkModeSwitch);
      await tester.pumpAndSettle();

      // Verify the setting was saved
      final settings = SettingsService.instance.currentSettings;
      expect(settings.useDarkMode, true);
    });

    testWidgets('Language setting can be changed', (WidgetTester tester) async {
      // Reset settings to defaults before test
      await SettingsService.instance.resetToDefaults();
      
      // Build our app and trigger a frame.
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Navigate to settings page
      await tester.tap(find.byIcon(Icons.settings));
      await tester.pumpAndSettle();

      // Tap on Language setting
      await tester.tap(find.text('Language'));
      await tester.pumpAndSettle();

      // Tap on Chinese option
      await tester.tap(find.text('中文'));
      await tester.pumpAndSettle();

      // Verify the setting was saved
      final settings = SettingsService.instance.currentSettings;
      expect(settings.language, 'zh');
    });

    testWidgets('Reset settings works', (WidgetTester tester) async {
      // Set some non-default settings first
      await SettingsService.instance.updateDarkMode(true);
      await SettingsService.instance.updateLanguage('zh');
      
      // Build our app and trigger a frame.
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Navigate to settings page
      await tester.tap(find.byIcon(Icons.settings));
      await tester.pumpAndSettle();

      // Tap on Reset Settings
      await tester.tap(find.text('Reset Settings'));
      await tester.pumpAndSettle();

      // Confirm reset
      await tester.tap(find.text('Reset'));
      await tester.pumpAndSettle();

      // Verify settings were reset to defaults
      final settings = SettingsService.instance.currentSettings;
      expect(settings.useDarkMode, false);
      expect(settings.language, 'en');
    });
  });
}