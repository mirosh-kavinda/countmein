// process_page.dart

import 'dart:convert';
import 'dart:io';

import 'package:countmein/common/custom_form_button.dart';
import 'package:countmein/pages/landing_page.dart';
import 'package:countmein/pages/order_summary.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:photo_view/photo_view.dart';

const String baseUrl = 'http://192.168.43.75:5000'; // Replace with your IP address


class ProcessPage extends StatefulWidget {
  final File imageFile;
  final int calculatedCount;
  final String id;
  const ProcessPage({Key? key, required this.imageFile ,required this.calculatedCount , required this.id}) : super(key: key);

  @override
  _ProcessPageState createState() => _ProcessPageState();
}

class _ProcessPageState extends State<ProcessPage> {
  late File? _processedImageFile;
  late bool isMatched;
  bool _isLoading = true;
  String stealcount='';

  @override
  void initState() {
    super.initState();
    _processImage(widget.imageFile);
    _processedImageFile=null;
    isMatched=false;
  }

Future<void> getImage(String respones) async {
  final response = await http.get(Uri.parse('http://192.168.43.75:5000/get_image/output_image.jpg'));
    
    // Save the downloaded image to a local file
    File tempImageFile = File(widget.imageFile.path.replaceAll('.jpg', '_processed.jpg'));
    await tempImageFile.writeAsBytes(response.bodyBytes);
      
      setState(() {
        _processedImageFile = tempImageFile;
        stealcount=respones;
        isMatched=(widget.calculatedCount.toString()==respones)?true:false;
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
      
      await getImage(resCount);
    
    } else {
      print('Request failed with status: ${response.statusCode}');
    //   // Handle error if needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Process Page'),
        ),
      body: SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                child: _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      :  _processedImageFile != null
                        ? PhotoView(
                            imageProvider: FileImage(_processedImageFile!),
                            minScale: PhotoViewComputedScale.contained,
                            maxScale: PhotoViewComputedScale.covered * 2,
                            enableRotation: true,
                          )
                         : Container(), // Display an empty container if the image is null
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  if(stealcount!="")  
                    CustomFormButton(
                         textSize: 15.0,
                         inputSize: 0.4,
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProcessPage(imageFile: widget.imageFile,calculatedCount: widget.calculatedCount,id: widget.id),
                            ),
                          ),
                        innerText: 'Reprocess',
                      ),
                  if(stealcount!="")   
                    CustomFormButton(
                        textSize: 15.0,
                        inputSize: 0.4,
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrderSummary(isMatched: isMatched,stealCount: stealcount , id:widget.id),
                          ),
                        ),
                      innerText: 'Next',
                    ),
                ],
              ),
            )
          ],
        ),
      ),
      ));
  }
}
