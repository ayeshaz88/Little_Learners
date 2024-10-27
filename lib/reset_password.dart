import 'package:flutter/material.dart';

class ResetPasswordPage extends StatefulWidget {
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController = TextEditingController();

  String _verificationOption = 'Email'; // Default verification option

  void _resetPassword() {
    if (_formKey.currentState!.validate()) {
      // Perform password reset logic here
      // You can use the _currentPasswordController.text, _newPasswordController.text, etc.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Reset Password',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text('Select Verification Option:'),
              DropdownButton<String>(
                value: _verificationOption,
                onChanged: (String? newValue) {
                  setState(() {
                    _verificationOption = newValue!;
                  });
                },
                items: <String>['Email', 'Contact'].map<DropdownMenuItem<String>>(
                      (String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  },
                ).toList(),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _currentPasswordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Current Password'),
                validator: (value) {
                  // Validate current password
                  return null; // Return an error message if validation fails
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _newPasswordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'New Password'),
                validator: (value) {
                  // Validate new password
                  return null; // Return an error message if validation fails
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _confirmNewPasswordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Confirm New Password'),
                validator: (value) {
                  // Validate confirm new password
                  return null; // Return an error message if validation fails
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _resetPassword,
                child: Text('Reset Password'),
              ),
            ],
          ),
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
      title: 'Reset Password Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ResetPasswordPage(),
    );
  }
}
