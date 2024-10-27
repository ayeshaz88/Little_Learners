import 'package:flutter/material.dart';
import 'package:my_proj/ui/auth/login_screen.dart';

class LogoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Logout'),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.exit_to_app,
              size: 80,
              color: Colors.red,
            ),
            SizedBox(height: 20),
            Text(
              'Are you sure you want to logout?',
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(isStudent: true,)));
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
