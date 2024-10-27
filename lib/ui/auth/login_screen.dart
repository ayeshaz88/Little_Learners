import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_proj/home_screen.dart';
import 'package:my_proj/ui/auth/login_with_phone_num.dart';
import 'package:flutter/services.dart';
import 'package:my_proj/ui/auth/parent_login_screen.dart';
import 'package:my_proj/ui/auth/signup_screen.dart';
import 'package:my_proj/utils/utils.dart'; // Import Utils

class LoginScreen extends StatefulWidget {
  final bool isStudent;

  const LoginScreen({Key? key, required this.isStudent}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool submitted = false; // Track if the form has been submitted
  bool _obscureText = true; // Toggle password visibility

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  // Function to handle login
  Future<void> _handleLogin() async {
    try {
      final email = emailController.text;
      final password = passwordController.text;

      // Sign in with Firebase Authentication
      final userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // If login is successful, navigate to the dashboard
      if (userCredential.user != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      }
    } catch (e) {
      // Handle login errors and display messages using Utils
      Utils().toastMessage(e.toString());
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      // Password reset email sent successfully
    } catch (e) {
      // Handle errors, e.g., if the email is not found in the system
      print("Password reset error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WillPopScope(
        onWillPop: () async {
          SystemNavigator.pop();
          return true;
        },
        child: Scaffold(
          backgroundColor: Color(0xFFEF9595),
          body: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image(
                      height: 70,
                      width: 90,
                      image: AssetImage('assets/logo.png'),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Little',
                          style: TextStyle(
                              fontSize: 34,
                              fontFamily: 'Rubik Medium',
                              color: Colors.blue),
                        ),
                        Text(
                          'Learners',
                          style: TextStyle(
                            fontSize: 34,
                            fontFamily: 'Rubik Medium',
                            color: Colors.pinkAccent,
                          ),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(height: 20),
                Center(
                  child: Text(
                    'Student Login',
                    style: TextStyle(
                        fontSize: 30,
                        fontFamily: 'Rubik Medium',
                        color: Colors.teal),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Text(
                    'App for Pre School Kids',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Rubik Regular',
                        color: Color(0xff66ff66)),
                  ),
                ),
                SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              controller: emailController,
                              decoration: InputDecoration(
                                hintText: 'Email',
                                fillColor: Color(0xFFF58484),
                                filled: true,
                                prefixIcon: Icon(Icons.alternate_email,
                                    color: Color(0xFFFFFF00)),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xffE4E7E8)),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              validator: (value) {
                                if (submitted &&
                                    (value == null || value.isEmpty)) {
                                  return 'Enter Email';
                                }
                                // Check if the email matches the email format using regex
                                bool emailValid = RegExp(
                                        r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                                    .hasMatch(value ?? '');
                                if (!emailValid && submitted) {
                                  return 'Enter a valid email';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              keyboardType: TextInputType.text,
                              controller: passwordController,
                              obscureText: _obscureText,
                              decoration: InputDecoration(
                                hintText: 'Password',
                                fillColor: Color(0xFFF58484),
                                filled: true,
                                prefixIcon: Icon(Icons.lock_open,
                                    color: Color(0xFF7DFF08)),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xffE4E7E8)),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _obscureText =
                                          !_obscureText; // Toggle password visibility
                                    });
                                  },
                                  child: Icon(
                                    _obscureText
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    // Show/hide icon based on password visibility
                                    color: Colors
                                        .grey, // You can change the icon color as needed
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (submitted &&
                                    (value == null || value.isEmpty)) {
                                  return 'Enter Password';
                                }
                                // Check if the password matches the format (at least 8 characters with digits and alphabets)
                                bool passwordValid = RegExp(
                                        r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$')
                                    .hasMatch(value ?? '');
                                if (!passwordValid && submitted) {
                                  return 'Enter a valid password \n 8 Characters that must contain both Alphabets(a-z) and Digits(1,2,..).';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 50),
                      Container(
                        height: 50,
                        width: 300,
                        decoration: BoxDecoration(
                          color: Color(0xffF9783B),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                submitted = true; // Mark the form as submitted
                              });
                              if (_formKey.currentState!.validate()) {
                                // Handle login when the button is pressed
                                _handleLogin();
                              }
                            },
                            child: Text(
                              "GO",
                              style: TextStyle(
                                color:
                                    Colors.white, // Set the text color to white
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20), // Added spacing
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              // Navigate to the parent signup screen
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignupScreen(),
                                ),
                              );
                            },
                            child: Text(
                              "Don't have an account? Signup",
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              // Navigate to the parent signup screen
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ParentLoginScreen(),
                                ),
                              );
                            },
                            child: Text(
                              "Parent Counsel",
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          SizedBox(width: 20), // Added spacing
                          TextButton(
                            onPressed: () {
                              // Add logic to reset the password here
                            },
                            child: Text(
                              "Forgot your password? Reset",
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 40),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginWithPhoneNum()));
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: Colors.black)),
                          child: Center(
                            child: Text('Login with phone'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void main() {
    runApp(LoginScreen(isStudent: true));
  }
}
