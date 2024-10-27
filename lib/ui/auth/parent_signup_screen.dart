import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_proj/utils/utils.dart';

class ParentSignupScreen extends StatefulWidget {
  const ParentSignupScreen({Key? key}) : super(key: key);

  @override
  _ParentSignupScreenState createState() => _ParentSignupScreenState();
}

class _ParentSignupScreenState extends State<ParentSignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final reenterPasswordController = TextEditingController();
  final contactNumberController = TextEditingController();
  final childNameController = TextEditingController();
  final ageOfChildController = TextEditingController();
  final motherNameController = TextEditingController();
  final fatherNameController = TextEditingController();

  FirebaseAuth get _auth => FirebaseAuth.instance;
  Utils get _utils => Utils();

  bool submitted = false;
  bool _obscureText = true;
  String? passwordError;
  FocusNode ageFocusNode = FocusNode();
  DateTime? selectedDate;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    reenterPasswordController.dispose();
    contactNumberController.dispose();
    childNameController.dispose();
    ageOfChildController.dispose();
    motherNameController.dispose();
    fatherNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        backgroundColor: Color(0xFFEF9595),
        body: SafeArea(
          child: SingleChildScrollView(
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
                    'Parent Signup',
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
                    'App for Pre School Kids',
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
                  child: Form(
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
                              borderSide: BorderSide(color: Color(0xffE4E7E8)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (submitted && (value == null || value.isEmpty)) {
                              return 'Enter Email';
                            }
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
                            prefixIcon:
                                Icon(Icons.lock_open, color: Color(0xff323F4B)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xffE4E7E8)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _obscureText = !_obscureText;
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
                            if (submitted && (value == null || value.isEmpty)) {
                              return 'Enter Password';
                            }
                            bool passwordValid = RegExp(
                                    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$')
                                .hasMatch(value ?? '');
                            if (!passwordValid && submitted) {
                              return 'Enter a valid password \n 8 Characters that must contain both Alphabets(a-z) and Digits(1,2,..).';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          controller: reenterPasswordController,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            hintText: 'Re-enter Password',
                            fillColor: Color(0xFFEF9595),
                            filled: true,
                            prefixIcon:
                                Icon(Icons.lock_open, color: Color(0xff323F4B)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xffE4E7E8)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _obscureText = !_obscureText;
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
                            if (submitted && (value == null || value.isEmpty)) {
                              return 'Re-enter your password';
                            }
                            if (value != passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          controller: contactNumberController,
                          decoration: InputDecoration(
                            hintText: 'Contact Number (Optional)',
                            fillColor: Color(0xFFEF9595),
                            filled: true,
                            prefixIcon:
                                Icon(Icons.phone, color: Color(0xff323F4B)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xffE4E7E8)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (value != null && value.isNotEmpty) {
                              int? age = int.tryParse(value);
                              if (age == null || age <= 0) {
                                return 'Invalid age';
                              }
                            }
                            return null; // Validation passed
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          controller: childNameController,
                          decoration: InputDecoration(
                            hintText: 'Name of Child',
                            fillColor: Color(0xFFEF9595),
                            filled: true,
                            prefixIcon: Icon(Icons.child_care,
                                color: Color(0xff323F4B)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xffE4E7E8)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (submitted && (value == null || value.isEmpty)) {
                              return 'Enter Child\'s Name';
                            } else if (!RegExp(r'^[A-Z][a-z]*$')
                                .hasMatch(value!)) {
                              return 'Enter a valid name (First letter capital, only alphabets)';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: ageOfChildController,
                          decoration: InputDecoration(
                            hintText: 'Age of Child (Optional)',
                            fillColor: Color(0xFFEF9595),
                            filled: true,
                            prefixIcon:
                                Icon(Icons.cake, color: Color(0xff323F4B)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xffE4E7E8)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          focusNode: ageFocusNode,
                          onTap: () async {
                            // Show the date picker when the text field is tapped
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(DateTime.now().year - 100),
                              lastDate: DateTime.now(),
                            );

                            if (pickedDate != null) {
                              setState(() {
                                selectedDate = pickedDate;
                                ageOfChildController.text =
                                    (DateTime.now().year - pickedDate.year)
                                        .toString();
                                // Calculate the age based on the selected date
                              });
                            }
                          },
                          readOnly: true, // Make the text field read-only
                          validator: (value) {
                            if (value != null && value.isNotEmpty) {
                              int? age = int.tryParse(value);
                              if (age == null || age <= 0) {
                                return 'Invalid age';
                              }
                            }
                            return null; // Validation passed
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          controller: motherNameController,
                          decoration: InputDecoration(
                            hintText: 'Name of Mother (Optional)',
                            fillColor: Color(0xFFEF9595),
                            filled: true,
                            prefixIcon: Icon(Icons.person_outline,
                                color: Color(0xff323F4B)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xffE4E7E8)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (!RegExp(r'^[A-Z][a-z]*$').hasMatch(value!)) {
                              return 'Enter a valid name (First letter capital, only alphabets)';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          controller: fatherNameController,
                          decoration: InputDecoration(
                            hintText: 'Name of Father',
                            fillColor: Color(0xFFEF9595),
                            filled: true,
                            prefixIcon:
                                Icon(Icons.person, color: Color(0xff323F4B)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xffE4E7E8)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (submitted && (value == null || value.isEmpty)) {
                              return 'Enter Father\'s Name';
                            } else if (!RegExp(r'^[A-Z][a-z]*$')
                                .hasMatch(value!)) {
                              return 'Enter a valid name (First letter capital, only alphabets)';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                if (passwordError != null)
                  Text(
                    passwordError!,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                    ),
                  ),
                SizedBox(height: 50),
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
                          // Form validation successful, you can now proceed with signup logic
                          // You can access the form fields using the respective controllers
                          // For example:
                          // final email = emailController.text;
                          // final password = passwordController.text;
                          // final contactNumber = contactNumberController.text;
                          // final childName = childNameController.text;
                          // final ageOfChild = ageOfChildController.text;
                          // final motherName = motherNameController.text;
                          // final fatherName = fatherNameController.text;

                          // Perform signup logic here
                        }
                      },
                      child: Text(
                        "Signup",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
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
                            builder: (context) => ParentSignupScreen(),
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
    );
  }
}

void main() {
  runApp(ParentSignupScreen());
}
