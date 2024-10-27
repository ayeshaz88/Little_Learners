import 'package:flutter/material.dart';
import 'myaccount_screen.dart';
import 'goals_screen.dart';
import 'package:my_proj/ui/auth/login_screen.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Colors.orange,
      ),
      body: Container(
        color: Colors.white, // Set the background color to white
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SettingOption(
              icon: Icons.child_care,
              title: 'My Account',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyAccountScreen()));
              },
            ),
            SizedBox(height: 10),
            _SettingOption(
              icon: Icons.star,
              title: 'Goals',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => GoalsScreen()));
              },
            ),
            SizedBox(height: 10),
            _SettingOption(
              icon: Icons.exit_to_app,
              title: 'Logout',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(isStudent: true,)));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _SettingOption({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black), // Add a border
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 32,
              color: Colors.black, // Change icon color to black
            ),
            SizedBox(width: 20),
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Change text color to black
              ),
            ),
          ],
        ),
      ),
    );
  }
}
