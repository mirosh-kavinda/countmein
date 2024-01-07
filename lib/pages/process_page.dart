// process_page.dart

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String baseUrl = 'http://192.168.43.75:5000'; // Replace with your IP address


class ProcessPage extends StatefulWidget {
  final File imageFile;

  const ProcessPage({Key? key, required this.imageFile}) : super(key: key);

  @override
  _ProcessPageState createState() => _ProcessPageState();
}

class _ProcessPageState extends State<ProcessPage> {
  late File? _processedImageFile;
  bool _isLoading = true;
  String stealcount='';

  @override
  void initState() {
    super.initState();
    _processImage(widget.imageFile);
    _processedImageFile=null;
  }

Future<void> getImage() async {
  final response = await http.get(Uri.parse(baseUrl + '/get_image/output_image.jpg'));
    
    // Save the downloaded image to a local file
    File tempImageFile = File(widget.imageFile.path.replaceAll('.jpg', '_processed.jpg'));
    await tempImageFile.writeAsBytes(response.bodyBytes);

    
      setState(() {
        _processedImageFile = tempImageFile;
        _isLoading=false;
    
      });
}
  Future<void> _processImage(File imageFile) async {
  
    var request =  http.MultipartRequest('POST', Uri.parse(baseUrl+'/predict'));
    // // Add the image file to the request
    request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));
    // // Send the request
    var response = await request.send();
    // // Check the status code of the response
    if (response.statusCode == 200) {
    //   // Parse the response
    var jsonResponse = await http.Response.fromStream(response);

      String resCount=jsonDecode(jsonResponse.body)['stealcount'];
      getImage();
    
  
      setState(() {
        stealcount=resCount;
      });
    } else {
      print('Request failed with status: ${response.statusCode}');
    //   // Handle error if needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Process Page'),
        ),
      body: SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                child: _isLoading
                      ? CircularProgressIndicator()
                      : Center(
                          child: _processedImageFile != null
                              ? Image.file(
                                  _processedImageFile!,
                                  fit: BoxFit.cover,
                                  height: double.infinity,
                                  width: double.infinity,
                                )
                          : Container(), // Display an empty container if the image is null
              ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                if(stealcount!="")
                  Text('Steal Count = '+stealcount),
                  
              ],
            )
          ],
        ),
      ),
      ));
  }
}
