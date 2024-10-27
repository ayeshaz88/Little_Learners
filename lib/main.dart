import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_proj/read_screen.dart';
import 'package:my_proj/ui/auth/parent_signup_screen.dart';
import 'package:my_proj/ui/splash_screen.dart';

// Entry point of the application
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBkVzXMO4QHQPJDZo2e2OcDEDkch8UsU0w",
      authDomain: "myproj-926c3.firebaseapp.com",
      projectId: "myproj-926c3",
      storageBucket: "myproj-926c3.appspot.com",
      messagingSenderId: "568130179709",
      appId: "1:568130179709:web:9041a136ed809884745714",
      databaseURL: 'https://myproj-926c3-default-rtdb.firebaseio.com',
    ),
  );

  // Run the app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Little Learners',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      initialRoute: '/', // Set the initial route
      routes: {
        '/': (context) => WelcomeScreen(),
        '/read': (context) => ReadScreen(),
        '/signup': (context) => ParentSignupScreen(),
        // Add more routes for other screens
      },
    );
  }
}

// Define a Widget for the WelcomeScreen
class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
      ),
      body: Center(
        child: Text('Welcome to Little Learners!'),
      ),
    );
  }
}

// A Widget to demonstrate styling and positioning
class CustomWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100, // Adjust the width as needed
      height: 500, // Adjust the height as needed
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 10, // Adjust the position as needed
            top: 10, // Adjust the position as needed
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10), // Use 'const' for EdgeInsets
                child: Text(
                  'Some Info Here',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Define MyHomePage Widget
class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text('This is the $title'),
      ),
    );
  }
}
