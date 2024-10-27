import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_proj/widgets/round_button.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../utils/utils.dart';

import 'dart:io';

String getOperatingSystem() {
  return Platform.operatingSystem;
}


class UploadImage extends StatefulWidget {
  const UploadImage({Key? key}) : super(key: key);

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {

  bool loading = false;
  File? _image;
  final picker = ImagePicker();

  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;

  DatabaseReference databaseRef = FirebaseDatabase.instance.ref('ReadingAlphabets');

  Future getImageGallery()async{
    final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    setState(() {
      if(pickedFile != null){

        _image = File(pickedFile.path);

      }else {
        print('no image picked');
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Image'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: InkWell(
                onTap: (){
                  getImageGallery();
                },
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black
                    )
                  ),
                 child: _image!= null ? Image.file(_image!.absolute) : Center(child: Icon(Icons.image)),
                ),
              ),
            ),
            SizedBox(height: 39),
            RoundButton(
              title: 'Upload', loading: loading, // Make sure to provide the necessary arguments if required
              onTap: () async{

                setState(() {
                  loading = true;
                });
                firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref('/Kids/' + DateTime.now().millisecondsSinceEpoch.toString());
                firebase_storage.UploadTask uploadTask = ref.putFile(_image!.absolute);
                Future.value(uploadTask).then((value)async{
                  var newUrl = await ref.getDownloadURL();

                  databaseRef.child('1').set({
                    'id' : '1212',
                    'title' : newUrl.toString()
                  }).then((value){
                    setState(() {
                      loading = false;
                    });
                    Utils().toastMessage('uploaded');
                  }).onError((error, stackTrace){
                    setState(() {
                      loading = false;
                    });
                  });
                }).onError((error, stackTrace){
                  Utils().toastMessage(error.toString());
                  setState(() {
                    loading = false;
                  });
                });

              },
            ),
          ],
        ),
      ),
    );
  }
}
