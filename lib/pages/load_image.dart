import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class LoadImagePage extends StatelessWidget {
  const LoadImagePage({Key? key}) : super(key: key);

  Future<void> _getImageFromCamera(BuildContext context) async {
    final picker = ImagePicker();
    // ignore: deprecated_member_use
    final pickedImage = await picker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      File imageFile = File(pickedImage.path);
      // Do something with the image file

      // For example, you can navigate to a new page with the captured image
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CapturedImagePage(imageFile: imageFile)),
      );
    }
  }

  Future<void> _getImageFromGallery(BuildContext context) async {
    final picker = ImagePicker();
    // ignore: deprecated_member_use
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      File imageFile = File(pickedImage.path);
      // Do something with the image file

      // For example, you can navigate to a new page with the selected image
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SelectedImagePage(imageFile: imageFile)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _getImageFromCamera(context),
              child: const Text('Capture Image'),
            ),
            ElevatedButton(
              onPressed: () => _getImageFromGallery(context),
              child: const Text('Choose Image'),
            ),
          ],
        ),
      ),
    );
  }
}

class CapturedImagePage extends StatelessWidget {
  final File imageFile;

  const CapturedImagePage({Key? key, required this.imageFile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Captured Image'),
      ),
      body: Center(
        child: Image.file(imageFile),
      ),
    );
  }
}

class SelectedImagePage extends StatelessWidget {
  final File imageFile;

  const SelectedImagePage({Key? key, required this.imageFile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selected Image'),
      ),
      body: Center(
        child: Image.file(imageFile),
      ),
    );
  }
}

