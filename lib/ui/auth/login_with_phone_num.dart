import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_proj/ui/auth/verify_code.dart';
import 'package:my_proj/widgets/round_button.dart';

import '../../utils/utils.dart';

class LoginWithPhoneNum extends StatefulWidget {
  const LoginWithPhoneNum  ({Key? key}) : super(key: key);

  @override
  State<LoginWithPhoneNum> createState() => _LoginWithPhoneNumState();
}

class _LoginWithPhoneNumState extends State<LoginWithPhoneNum> {

  bool loading =false;
  final phoneNumberController = TextEditingController();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 50,),

            TextFormField(
              controller: phoneNumberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: '+1 234 3455 234'
              ),
            ),
            SizedBox(height: 80,),
           RoundButton(title: 'Login',loading: loading, onTap: (){

             setState(() {
               loading = true;
             });

             auth.verifyPhoneNumber(
               phoneNumber: phoneNumberController.text,
                 verificationCompleted: (_){
                   setState(() {
                     loading = false;
                   });

                 },
                 verificationFailed: (e){
                   setState(() {
                     loading = false;
                   });
                 Utils().toastMessage(e.toString());
                 },
                 codeSent: (String verificationId, int? token){
                 Navigator.push(context,
                     MaterialPageRoute(builder: (context)=> VerifyCodeScreen(verificationId: verificationId,) ));
                 setState(() {
                   loading = false;
                 });
                 },

                 codeAutoRetrievalTimeout: (e){
                   setState(() {
                     loading = false;
                   });
                   Utils().toastMessage(e.toString());
                 }
             );
           },
           )],
        ),
      ),
    );
  }
}
