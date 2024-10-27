import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isDarkModeEnabled = false;
  bool _isSoundOn = true;
  bool _isNotificationsOn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'App Theme',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SwitchListTile(
              title: Text('Dark Mode'),
              value: _isDarkModeEnabled,
              onChanged: (value) {
                setState(() {
                  _isDarkModeEnabled = value;
                });
                // TODO: Change the app theme based on value
              },
            ),
            Divider(),
            Text(
              'Sound and Notifications',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SwitchListTile(
              title: Text('Sound'),
              value: _isSoundOn,
              onChanged: (value) {
                setState(() {
                  _isSoundOn = value;
                });
                // TODO: Toggle sound on/off
              },
            ),
            SwitchListTile(
              title: Text('Notifications'),
              value: _isNotificationsOn,
              onChanged: (value) {
                setState(() {
                  _isNotificationsOn = value;
                });
                // TODO: Toggle notifications on/off
              },
            ),
            Divider(),
            Text(
              'Account Settings',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ListTile(
              title: Text('Change Email/Contact No.'),
              onTap: () {
                // TODO: Navigate to change email/contact no. screen
              },
            ),
            Divider(),
            Text(
              'Dashboard Preferences',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ListTile(
              title: Text('Visualization Type'),
              onTap: () {
                // TODO: Navigate to dashboard preferences screen
              },
            ),
          ],
        ),
      ),
    );
  }
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Settings Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SettingsPage(),
    );
  }
}
