import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:reader/services/settings_service.dart';
import 'package:reader/models/user_settings.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final SettingsService _settingsService = SettingsService.instance;
  late UserSettings _currentSettings;

  @override
  void initState() {
    super.initState();
    _currentSettings = _settingsService.currentSettings;
  }

  void _updateSettings(UserSettings newSettings) {
    setState(() {
      _currentSettings = newSettings;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Settings')),
        body: SettingsList(sections: [
          SettingsSection(tiles: [
            SettingsTile(
              title: const Text('Language'),
              leading: const Icon(Icons.language),
              value: Text(_currentSettings.language),
              onPressed: (BuildContext context) {
                _showLanguageDialog();
              },
            ),
            SettingsTile.switchTile(
              initialValue: _currentSettings.useFingerprint,
              title: const Text('Use fingerprint'),
              leading: const Icon(Icons.fingerprint),
              onToggle: (bool value) async {
                await _settingsService.updateFingerprint(value);
                _updateSettings(_settingsService.currentSettings);
              },
            ),
            SettingsTile.switchTile(
              title: const Text('Dark mode'),
              leading: const Icon(Icons.lightbulb_outline),
              onToggle: (bool value) async {
                await _settingsService.updateDarkMode(value);
                _updateSettings(_settingsService.currentSettings);
              },
              initialValue: _currentSettings.useDarkMode,
            ),
            SettingsTile(
              title: const Text('Reset Settings'),
              leading: const Icon(Icons.restore),
              onPressed: (BuildContext context) {
                _showResetDialog();
              },
            ),
          ])
        ]));
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Language'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('English'),
                leading: Radio<String>(
                  value: 'en',
                  groupValue: _currentSettings.language,
                  onChanged: (String? value) async {
                    if (value != null) {
                      await _settingsService.updateLanguage(value);
                      _updateSettings(_settingsService.currentSettings);
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ),
              ListTile(
                title: const Text('中文'),
                leading: Radio<String>(
                  value: 'zh',
                  groupValue: _currentSettings.language,
                  onChanged: (String? value) async {
                    if (value != null) {
                      await _settingsService.updateLanguage(value);
                      _updateSettings(_settingsService.currentSettings);
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _showResetDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Reset Settings'),
          content: const Text('Are you sure you want to reset all settings to default values?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await _settingsService.resetToDefaults();
                _updateSettings(_settingsService.currentSettings);
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Settings reset to defaults')),
                );
              },
              child: const Text('Reset'),
            ),
          ],
        );
      },
    );
  }
}
