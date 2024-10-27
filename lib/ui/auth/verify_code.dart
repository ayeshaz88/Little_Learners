import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_proj/home_screen.dart';
import '../../widgets/round_button.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String verificationId;
  const VerifyCodeScreen({Key? key, required this.verificationId})
      : super(key: key);

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  bool loading = false;
  final verificationCodeController = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 50),
            TextFormField(
              controller: verificationCodeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: '6 digit Code',
              ),
            ),
            SizedBox(height: 80),
            RoundButton(
              title: 'Verify',
              loading: loading,
              onTap: () async {
                setState(() {
                  loading = true;
                });
                final credential = PhoneAuthProvider.credential(
                    verificationId: widget.verificationId,
                    smsCode: verificationCodeController.text.toString());
                try {
                  await auth.signInWithCredential(credential);
                  // Replace with the screen you want to navigate to after successful verification
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                } catch (e) {
                  setState(() {
                    loading = false;
                  });
                  // Replace with your error handling logic
                  print(e.toString());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
