import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:my_proj/utils/utils.dart';
import 'package:my_proj/widgets/round_button.dart';

class AlphabetScreen extends StatefulWidget {
  const AlphabetScreen({Key? key}): super(key: key);

  @override
  State<AlphabetScreen> createState() => _AlphabetScreenState();
}

class _AlphabetScreenState extends State<AlphabetScreen> {

  final postController = TextEditingController();
  bool loading = false;
  final databaseRef = FirebaseDatabase.instance.ref('ReadingAlphabets');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alphabet'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            TextFormField(
              maxLines: 4,
              controller: postController,
              decoration: InputDecoration(
                hintText: 'What is in your mind?',
                border: OutlineInputBorder(),

              ),
            ),
            SizedBox(
              height: 30,
            ),
            RoundButton(title: 'Add',
              loading: loading,
              onTap: () {
              setState(() {
                loading =true;
              });
              databaseRef.child(DateTime.now().millisecondsSinceEpoch.toString()).set({
                'title' : postController.text.toString(),
                'id': DateTime.now().millisecondsSinceEpoch.toString()
              }).then((value){
                Utils().toastMessage('Post Successfully updated');
                setState(() {
                  loading =false;
                });
              }).onError((error, stackTrace){
                Utils().toastMessage(error.toString());
                setState(() {
                  loading =false;
                });
              });
              },)
          ],

        ),
      ),
    );
  }
}
