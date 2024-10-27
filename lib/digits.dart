import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DigitsImageDisplay extends StatelessWidget {
  final String imageUrl2;
  final String imageUrl3;

  const DigitsImageDisplay(
      {Key? key, required this.imageUrl2, required this.imageUrl3})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Display Images from Firestore'),
      ),
      body: Column(
        children: [
          Center(
            child: SizedBox(
              height: 300,
              child: Image.network(
                imageUrl2,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Card(
            child: Center(
              child: SizedBox(
                height: 300,
                child: Image.network(
                  imageUrl3,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FirestoreImageDisplayState extends StatefulWidget {
  const FirestoreImageDisplayState({Key? key}) : super(key: key);

  @override
  _FirestoreImageDisplayState createState() => _FirestoreImageDisplayState();
}

class _FirestoreImageDisplayState extends State<FirestoreImageDisplayState> {
  late String imageUrl;
  late String imageUrl1;
  final storage = FirebaseStorage.instance;

  @override
  void initState() {
    super.initState();
    imageUrl = '';
    imageUrl1 = '';
    getImageUrl();
  }

  Future<void> getImageUrl() async {
    final ref = storage.ref().child('A.png');
    final ref1 = storage.ref().child('B.png');
    final url = await ref.getDownloadURL();
    final url1 = await ref1.getDownloadURL();
    setState(() {
      imageUrl = url;
      imageUrl1 = url1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DigitsImageDisplay(imageUrl2: imageUrl, imageUrl3: imageUrl1);
  }
}
