import 'dart:convert';
import 'package:countmein/pages/process_page.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


class LoadImagePage extends StatefulWidget {
  const LoadImagePage({Key? key}) : super(key: key);

  @override
  _LoadImagePageState createState() => _LoadImagePageState();
}

class _LoadImagePageState extends State<LoadImagePage> {
  bool _showCaptureButton = true;
  bool _showChooseButton = true;
  bool _showRetakeButton = false;
  bool _showProceedButton = false;
  bool _imageloadFromGalary=false;
  late File? _imageFile; 


 @override
  void initState() {
    super.initState();
    _imageFile = null; 
  }

  Future<void> _getImageFromCamera(BuildContext context) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
        _showCaptureButton = false;
        _showChooseButton = false;
        _showRetakeButton = true;
        _showProceedButton = true;
        _imageloadFromGalary=false;
      });
    }
  }

  Future<void> _getImageFromGallery(BuildContext context) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
        _showChooseButton = false;
        _showCaptureButton = false;
        _showRetakeButton = true;
        _showProceedButton = true;
         _imageloadFromGalary=true;
      });
    }
  }

  

  @override
 Widget build(BuildContext context) {
  return Scaffold(
    body: SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: _imageFile != null
                    ? Image.file(
                        _imageFile!,
                        fit: BoxFit.cover,
                        height: double.infinity,
                        width: double.infinity,
                      )
                    : Container(), // Display an empty container if the image is null
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                if (_showCaptureButton)
                  ElevatedButton(
                  
                    onPressed: () => _getImageFromCamera(context),
                    child: const Text('Capture Image'),
                  ),
                if (_showChooseButton)
                  ElevatedButton(
                  
                    onPressed: () => _getImageFromGallery(context),
                    child: const Text('Choose Image'),
                  ),
                if (_showRetakeButton )
                  ElevatedButton(
                    onPressed: () => _imageloadFromGalary
                        ? _getImageFromGallery(context)
                        : _getImageFromCamera(context),
                    child: Text(_imageloadFromGalary ? 'Re Choose' : 'Re Capture '),
                  ),
                if(_showProceedButton)
                ElevatedButton(
                
                  onPressed: () {
                    if (_imageFile != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProcessPage(imageFile: _imageFile!),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please Select Image !"),
                        ),
                      );
                    }
                  },
                  child: const Text('Process Image'),
                ),
              ],
            )
          ],
        ),
      ),
    ),
  );
}
}