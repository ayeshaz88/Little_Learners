import 'package:flutter/material.dart';

class ChildProfile extends StatefulWidget {
  @override
  _ChildProfileState createState() => _ChildProfileState();
}

class _ChildProfileState extends State<ChildProfile> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _contactController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Child Profile'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Child\'s Name'),
            ),
            TextFormField(
              controller: _ageController,
              decoration: InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextFormField(
              controller: _contactController,
              decoration: InputDecoration(labelText: 'Contact Number'),
              keyboardType: TextInputType.phone,
            ),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // Save profile information to a database or perform other actions
                // using the data from the controllers
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
