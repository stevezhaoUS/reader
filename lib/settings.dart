import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Settings',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ListTile(
              title: Text('Notification Settings'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to the notification settings page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotificationSettingsPage(),
                  ),
                );
              },
            ),
            Divider(),
            ListTile(
              title: Text('Appearance'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to the appearance settings page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AppearanceSettingsPage(),
                  ),
                );
              },
            ),
            Divider(),
            // Add more settings options here
          ],
        ),
      ),
    );
  }
}

class NotificationSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification Settings'),
      ),
      body: Center(
        child: Text('Notification settings page content goes here.'),
      ),
    );
  }
}

class AppearanceSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appearance Settings'),
      ),
      body: Center(
        child: Text('Appearance settings page content goes here.'),
      ),
    );
  }
}
