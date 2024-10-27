import 'package:flutter/material.dart';
import 'package:my_proj/child_profile.dart';
import 'package:my_proj/ui/splash_screen.dart';
import 'package:my_proj/report.dart';
import 'package:my_proj/setting.dart';
import 'package:my_proj/reset_password.dart';
import 'package:my_proj/feedback.dart';

class ParentDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Parent Dashboard'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('Parent Name'),
              accountEmail: Text('parent@example.com'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/profile.jpg'),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Child Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChildProfile()), // Replace ChildProfile with the actual class name
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.assignment),
              title: Text('Report'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReportPage()), // Replace ChildProfile with the actual class name
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.lock),
              title: Text('Reset Password'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ResetPasswordPage()), // Replace ChildProfile with the actual class name
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.feedback),
              title: Text('Feedback'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FeedbackPage()), // Replace ChildProfile with the actual class name
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()), // Replace ChildProfile with the actual class name
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('logout'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WelcomeScreen()), // Replace ChildProfile with the actual class name
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Welcome, Parent Name!'),
          SizedBox(height: 20),
          Text('Child\'s Recent Activity:'),
          // Display child's recent activity and progress
        ],
      ),
    );
  }
}



