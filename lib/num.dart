import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';


class FirestoreImageDisplay extends StatefulWidget {
  const FirestoreImageDisplay({Key? key}) : super(key: key);

  @override
  FirestoreImageDisplayState createState() => FirestoreImageDisplayState();
}

class FirestoreImageDisplayState extends State<FirestoreImageDisplay> {
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
    final ref = storage.ref().child('coumting.png');
    final ref1 = storage.ref().child('logo kids.png');
    final url = await ref.getDownloadURL();
    final url1 = await ref1.getDownloadURL();
    setState(() {
      imageUrl = url;
      imageUrl1 = url1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Display image from Firestore'),
      ),
      body: Column(
        children: [
          // Center the first image
          Center(
            child: SizedBox(
              height: 300, // Adjust the height as needed
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Center the second image using a Card
          Card(
            child: Center(
              child: SizedBox(
                height: 300, // Adjust the height as needed
                child: Image.network(
                  imageUrl1,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    // Handle the error here, e.g., display a placeholder image or an error message.
                    return Text('Error loading image');
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
