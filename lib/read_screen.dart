import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:my_proj/alphabet.dart';
import 'package:my_proj/ui/upload_image.dart';
import 'package:my_proj/digits.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Project',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ReadScreen(),
    );
  }
}

class ReadScreen extends StatefulWidget {
  @override
  _ReadScreenState createState() => _ReadScreenState();
}

class _ReadScreenState extends State<ReadScreen> {
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('ReadingAlphabets');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final ImagePicker _imagePicker = ImagePicker();
  PickedFile? _pickedImage;
  bool _isImageSelected = false;

  get data => null;

  Future<void> _pickImage() async {
    final pickedImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _pickedImage = pickedImage as PickedFile?;
        _isImageSelected = true;
      });
    }
  }

  Future<void> _openPictureDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Image.file(File(_pickedImage!.path)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reading Screen'),
        backgroundColor: Colors.orange,
        automaticallyImplyLeading: false, // Disable back arrow
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: _pickedImage != null
                  ? Image.file(File(_pickedImage!.path)).image
                  : AssetImage('images/profile.jpg'),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                    child: StreamBuilder(
                  stream: ref.onValue,
                  builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                    if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    } else {
                      Map<dynamic, dynamic> map =
                          snapshot.data!.snapshot.value as dynamic;
                      List<dynamic> list = [];
                      list.clear();
                      list = map.values.toList();
                      return ListView.builder(
                          itemCount: snapshot.data!.snapshot.children.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(list[index]['title']),
                              subtitle: Text(list[index]['id']),
                            );
                          });
                    }
                  },
                )),
                Expanded(
                  child: FirebaseAnimatedList(
                    query: ref,
                    defaultChild: Text('Loading'), //loading
                    itemBuilder: (context, snapshot, animation, index) {
                      return ListTile(
                        title: Text(snapshot.child('title').value.toString()),
                        subtitle: Text(snapshot.child('id').value.toString()),
                      );
                    },
                  ),
                ),
              ],
            ),
            RoundButton('Aplhabet', onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AlphabetScreen()));
            }, backgroundColor: Colors.blue),
            RoundButton('Number', onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DigitsImageDisplay(
                            imageUrl2: '',
                            imageUrl3: '',
                          )));
            }, backgroundColor: Colors.blue),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RoundButton(
                  'Myself',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DigitsImageDisplay(
                                  imageUrl2: '',
                                  imageUrl3: '',
                                )));
                  },
                  backgroundColor: Colors.blue,
                ),
                RoundButton(
                  'Upload Image',
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => UploadImage()));
                    // Handle the click for the third container
                  },
                  backgroundColor: Colors.blue,
                ),
                RoundButton(
                  'Custom',
                  onTap: () {},
                  backgroundColor: Colors.blue,
                ),
              ],
            ),
            SizedBox(height: 40),
            if (_isImageSelected)
              ElevatedButton(
                onPressed: _openPictureDialog,
                child: Text('View Selected Picture'),
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Change Profile Picture'),
            ),
          ],
        ),
      ),
    );
  }
}

class Num {}

class RoundButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;

  RoundButton(
    this.text, {
    this.onTap,
    required MaterialColor backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          color: Colors.blue, // Change the background color as needed
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.title, // Change the icon as needed
              color: Colors.white,
              size: 48,
            ),
            SizedBox(height: 10),
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
