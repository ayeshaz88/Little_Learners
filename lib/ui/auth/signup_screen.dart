import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_proj/ui/auth/login_screen.dart';
import 'package:my_proj/utils/utils.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _reenterPasswordController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;
  Utils _utils = Utils();

  bool _obscurePassword = true;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFFEF9595),
        appBar: AppBar(
          title: Text('Signup'),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image(
                        height: 70,
                        width: 70,
                        image: AssetImage('images/logo.png'),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Little',
                            style: TextStyle(
                              fontSize: 24,
                              fontFamily: 'Rubik Medium',
                              color: Colors.blue,
                            ),
                          ),
                          Text(
                            'Learners',
                            style: TextStyle(
                              fontSize: 24,
                              fontFamily: 'Rubik Medium',
                              color: Colors.pinkAccent,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Center(
                    child: Text(
                      'Signup',
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Rubik Medium',
                        color: Colors.teal,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Center(
                    child: Text(
                      'Create your account on little learners,\n Stay connected and save your progress',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Rubik Regular',
                        color: Color(0xff4c5980),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: 'Name',
                        fillColor: const Color(0xFFF58484),
                        filled: true,
                        prefixIcon: const Icon(
                          Icons.perm_identity_sharp,
                          color: Color(0xFF0977F1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Color(0xffE4E7E8)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Name is required';
                        } else if (!RegExp(r'^[A-Z][a-z]*$').hasMatch(value)) {
                          return 'Enter a valid name (First letter capital, only alphabets)';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        fillColor: const Color(0xFFF58484),
                        filled: true,
                        prefixIcon: const Icon(
                          Icons.alternate_email,
                          color: Color(0xFFFFFF00),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Color(0xffE4E7E8)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Email is required';
                        } else if (!RegExp(
                                r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                            .hasMatch(value)) {
                          return 'Enter a valid email address';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        fillColor: const Color(0xFFF58484),
                        filled: true,
                        prefixIcon: const Icon(
                          Icons.lock_open,
                          color: Color(0xFF7DFF08),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Color(0xffE4E7E8)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      obscureText: _obscurePassword,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password is required';
                        } else if (value.length < 8) {
                          return 'Password must be at least 8 characters long';
                        } else if (!RegExp(r'^(?=.*[a-zA-Z])(?=.*\d).*$')
                            .hasMatch(value)) {
                          return 'Password must be alphanumeric';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: TextFormField(
                      controller: _reenterPasswordController,
                      decoration: InputDecoration(
                        hintText: 'Re-Enter Password',
                        fillColor: const Color(0xFFF58484),
                        filled: true,
                        prefixIcon: const Icon(
                          Icons.lock_open,
                          color: Color(0xFF7DFF08),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Color(0xffE4E7E8)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Re-enter your password';
                        } else if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          setState(() {
                            loading = true;
                          });

                          // Check if the email is already registered
                          final userCredential =
                              await _auth.createUserWithEmailAndPassword(
                            email: _emailController.text.toString(),
                            password: _passwordController.text.toString(),
                          );

                          if (userCredential.user != null) {
                            // Registration successful
                            _utils.toastMessage('Registration successful!');

                            // Navigate to another screen
                            // You can add your navigation logic here
                          }

                          setState(() {
                            loading = false;
                          });
                        } catch (e) {
                          // Handle the error here if registration fails
                          setState(() {
                            loading = false;
                            errorMessage = 'This email is already registered.';
                            _utils.toastMessage(errorMessage);
                          });
                        }
                      }
                    },
                    child: Text(
                      'Signup',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Rubik Medium',
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Rubik Regular',
                          color: Colors.blueGrey,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  LoginScreen(isStudent: true),
                            ),
                          );
                        },
                        child: Text(
                          'Login',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Rubik Medium',
                            color: Colors.lightBlue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
