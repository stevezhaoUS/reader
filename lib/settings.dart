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
        appBar: AppBar(title: Text('Settings')),
        body: SettingsList(sections: [
          SettingsSection(tiles: [
            SettingsTile(
              title: Text('Language'),
              leading: Icon(Icons.language),
              onPressed: (BuildContext context) {},
            ),
            SettingsTile.switchTile(
              initialValue: true,
              title: Text('Use fingerprint'),
              leading: Icon(Icons.fingerprint),
              onToggle: (bool value) {},
            ),
            SettingsTile.switchTile(
              title: Text('Dark mode'),
              leading: Icon(Icons.lightbulb_outline),
              onToggle: (bool value) {},
              initialValue: true,
            ),
            SettingsTile(
              title: Text('Logout'),
              leading: Icon(Icons.exit_to_app),
              onPressed: (BuildContext context) {},
            ),
          ])
        ]));
  }
}
