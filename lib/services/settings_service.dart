import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import '../models/user_settings.dart';

class SettingsService {
  static const String _settingsFileName = 'user_settings.json';
  static SettingsService? _instance;
  UserSettings _currentSettings = UserSettings.defaultSettings();

  // Singleton pattern
  SettingsService._();
  
  static SettingsService get instance {
    _instance ??= SettingsService._();
    return _instance!;
  }

  // Get current settings
  UserSettings get currentSettings => _currentSettings;

  // Get the settings file path
  Future<String> _getSettingsFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/$_settingsFileName';
  }

  // Load settings from JSON file
  Future<UserSettings> loadSettings() async {
    try {
      final filePath = await _getSettingsFilePath();
      final file = File(filePath);
      
      if (await file.exists()) {
        final jsonString = await file.readAsString();
        _currentSettings = UserSettings.fromJsonString(jsonString);
      } else {
        // If file doesn't exist, use default settings and save them
        _currentSettings = UserSettings.defaultSettings();
        await saveSettings(_currentSettings);
      }
    } catch (e) {
      // If there's any error loading settings, use defaults
      _currentSettings = UserSettings.defaultSettings();
    }
    
    return _currentSettings;
  }

  // Save settings to JSON file
  Future<void> saveSettings(UserSettings settings) async {
    try {
      final filePath = await _getSettingsFilePath();
      final file = File(filePath);
      
      // Create directory if it doesn't exist
      await file.parent.create(recursive: true);
      
      // Write settings to file
      await file.writeAsString(settings.toJsonString());
      
      // Update current settings
      _currentSettings = settings;
    } catch (e) {
      // Handle error - could log or throw depending on requirements
      rethrow;
    }
  }

  // Update specific setting and save
  Future<void> updateDarkMode(bool value) async {
    final updatedSettings = _currentSettings.copyWith(useDarkMode: value);
    await saveSettings(updatedSettings);
  }

  Future<void> updateFingerprint(bool value) async {
    final updatedSettings = _currentSettings.copyWith(useFingerprint: value);
    await saveSettings(updatedSettings);
  }

  Future<void> updateLanguage(String language) async {
    final updatedSettings = _currentSettings.copyWith(language: language);
    await saveSettings(updatedSettings);
  }

  Future<void> updateFontSettings({
    String? fontFamily,
    double? fontSize,
    double? lineHeight,
    int? fontColor,
    int? fontWeight,
  }) async {
    final updatedSettings = _currentSettings.copyWith(
      fontFamily: fontFamily,
      fontSize: fontSize,
      lineHeight: lineHeight,
      fontColor: fontColor,
      fontWeight: fontWeight,
    );
    await saveSettings(updatedSettings);
  }

  // Check if settings file exists
  Future<bool> settingsFileExists() async {
    final filePath = await _getSettingsFilePath();
    final file = File(filePath);
    return await file.exists();
  }

  // Reset settings to defaults
  Future<void> resetToDefaults() async {
    await saveSettings(UserSettings.defaultSettings());
  }
}