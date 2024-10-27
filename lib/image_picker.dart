import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatefulWidget {
  final Function(PickedFile) onImagePicked;

  const ImagePickerWidget({required this.onImagePicked});

  @override
  _ImagePickerWidgetState createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  final ImagePicker _imagePicker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedImage = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      widget.onImagePicked(pickedImage as PickedFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: _pickImage,
          child: Text('Pick an Image'),
        ),
      ],
    );
  }
}
