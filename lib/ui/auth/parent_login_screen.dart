import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_proj/parent_dashboard.dart';
import 'package:my_proj/ui/auth/parent_signup_screen.dart';
import 'package:my_proj/utils/utils.dart';

class ParentLoginScreen extends StatefulWidget {
  @override
  _ParentLoginScreenState createState() => _ParentLoginScreenState();
}

class _ParentLoginScreenState extends State<ParentLoginScreen> {
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

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // User is signed in successfully
    } catch (e) {
      // Handle sign-in errors, e.g., invalid email or password
      print("Sign-in error: $e");
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
          backgroundColor:
              Color(0xFFEF9595), // Change to the desired background color
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
                      image: AssetImage(
                          'assets/parent.png'), // Change the image path
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
                    'Parent Login',
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'Rubik Medium',
                      color: Colors.teal,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Text(
                    'Parent Console for little learners',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Rubik Regular',
                      color: Color(0xff66ff66),
                    ),
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
                                fillColor: Color(0xFFEF9595),
                                filled: true,
                                prefixIcon: Icon(Icons.alternate_email,
                                    color: Color(0xff323F4B)),
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
                                fillColor: Color(0xFFEF9595),
                                filled: true,
                                prefixIcon: Icon(Icons.lock_open,
                                    color: Color(0xff323F4B)),
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
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (submitted &&
                                    (value == null || value.isEmpty)) {
                                  return 'Enter Password';
                                }
                                // Check if the password matches the format (at least 8 characters with alphabets and digits)
                                bool passwordValid = RegExp(
                                        r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$')
                                    .hasMatch(value ?? '');
                                if (!passwordValid && submitted) {
                                  return 'Enter a valid password (at least 8 characters with alphabets and digits)';
                                }
                                return null;
                              },
                            ),
                          ],
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
                                  builder: (context) => ParentSignupScreen(),
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
                          SizedBox(width: 20), // Added spacing
                        ],
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: 50,
                        width: 300,
                        decoration: BoxDecoration(
                          color: Color(0xff9900cc),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                submitted = true;
                              });
                              if (_formKey.currentState!.validate()) {
                                // Add your authentication logic here
                                // For example, check the email and password and navigate to ParentDashboard
                                if (emailController.text == 'your_email' &&
                                    passwordController.text ==
                                        'your_password') {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ParentDashboard(),
                                    ),
                                  );
                                } else {
                                  Utils().toastMessage(
                                      "Invalid email or password. Please try again.");
                                }
                              }
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      TextButton(
                        onPressed: () {
                          // Add logic to reset the password here
                          Utils().toastMessage(
                              "Password reset functionality is not implemented yet.");
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ResetPassword() {}
}

void main() {
  runApp(ParentLoginScreen());
}
