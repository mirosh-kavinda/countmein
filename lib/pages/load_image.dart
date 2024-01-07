
import 'package:countmein/common/custom_form_button.dart';
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
    appBar: AppBar(
       
    ),
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
                    : Container(
                      child: const Icon(
                          Icons.image_search,
                          color: Colors.black,
                          size: 70,
                          opticalSize: 1,
              ),
            ),
          ),
              
        
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  if (_showCaptureButton)
                   CustomFormButton(
                     textSize: 15.0,
                     inputSize: 0.4,
                            innerText: 'Capture Image',
                           onPressed: () => _getImageFromCamera(context),
                          ),
                    
                  if (_showChooseButton)
                    CustomFormButton(
                       textSize: 15.0,
                       inputSize: 0.4,
                      onPressed: () => _getImageFromGallery(context),
                      innerText: 'Choose Image',
                    ),
                  if (_showRetakeButton )
                    CustomFormButton(
                       textSize: 15.0,
                       inputSize: 0.4,
                      onPressed: () => _imageloadFromGalary
                          ? _getImageFromGallery(context)
                          : _getImageFromCamera(context),
                      innerText: (_imageloadFromGalary ? 'Re Choose' : 'Re Capture '),
                    ),
                  if(_showProceedButton)
                  CustomFormButton(
                     textSize: 15.0,
                     inputSize: 0.4,
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
                    innerText: 'Process Image',
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}
}