import 'dart:convert';

class UserSettings {
  bool useDarkMode;
  bool useFingerprint;
  String language;
  
  // Font settings
  String fontFamily;
  double fontSize;
  double lineHeight;
  int fontColor; // Store as int for JSON serialization
  int fontWeight; // Store as int for JSON serialization

  UserSettings({
    this.useDarkMode = false,
    this.useFingerprint = false,
    this.language = 'en',
    this.fontFamily = 'SimSun',
    this.fontSize = 14.0,
    this.lineHeight = 1.5,
    this.fontColor = 0xFF000000,
    this.fontWeight = 400, // FontWeight.normal
  });

  // Factory constructor for creating from JSON
  factory UserSettings.fromJson(Map<String, dynamic> json) {
    return UserSettings(
      useDarkMode: json['useDarkMode'] ?? false,
      useFingerprint: json['useFingerprint'] ?? false,
      language: json['language'] ?? 'en',
      fontFamily: json['fontFamily'] ?? 'SimSun',
      fontSize: (json['fontSize'] ?? 14.0).toDouble(),
      lineHeight: (json['lineHeight'] ?? 1.5).toDouble(),
      fontColor: json['fontColor'] ?? 0xFF000000,
      fontWeight: json['fontWeight'] ?? 400,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'useDarkMode': useDarkMode,
      'useFingerprint': useFingerprint,
      'language': language,
      'fontFamily': fontFamily,
      'fontSize': fontSize,
      'lineHeight': lineHeight,
      'fontColor': fontColor,
      'fontWeight': fontWeight,
    };
  }

  // Convert to JSON string
  String toJsonString() {
    return jsonEncode(toJson());
  }

  // Create from JSON string
  static UserSettings fromJsonString(String jsonString) {
    final Map<String, dynamic> json = jsonDecode(jsonString);
    return UserSettings.fromJson(json);
  }

  // Create default settings
  static UserSettings defaultSettings() {
    return UserSettings();
  }

  // Copy with method for updating specific settings
  UserSettings copyWith({
    bool? useDarkMode,
    bool? useFingerprint,
    String? language,
    String? fontFamily,
    double? fontSize,
    double? lineHeight,
    int? fontColor,
    int? fontWeight,
  }) {
    return UserSettings(
      useDarkMode: useDarkMode ?? this.useDarkMode,
      useFingerprint: useFingerprint ?? this.useFingerprint,
      language: language ?? this.language,
      fontFamily: fontFamily ?? this.fontFamily,
      fontSize: fontSize ?? this.fontSize,
      lineHeight: lineHeight ?? this.lineHeight,
      fontColor: fontColor ?? this.fontColor,
      fontWeight: fontWeight ?? this.fontWeight,
    );
  }
}