import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Settings')),
        body: SettingsList(sections: [
          SettingsSection(tiles: [
            SettingsTile(
              title: const Text('Language'),
              leading: const Icon(Icons.language),
              onPressed: (BuildContext context) {},
            ),
            SettingsTile.switchTile(
              initialValue: true,
              title: const Text('Use fingerprint'),
              leading: const Icon(Icons.fingerprint),
              onToggle: (bool value) {},
            ),
            SettingsTile.switchTile(
              title: const Text('Dark mode'),
              leading: const Icon(Icons.lightbulb_outline),
              onToggle: (bool value) {},
              initialValue: true,
            ),
            SettingsTile(
              title: const Text('Logout'),
              leading: const Icon(Icons.exit_to_app),
              onPressed: (BuildContext context) {},
            ),
          ])
        ]));
  }
}
