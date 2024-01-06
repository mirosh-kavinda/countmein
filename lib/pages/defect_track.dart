import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;


fetchdata(String url) async {
  http.Response response = await http.get(Uri.parse(url));
  return response.body;

}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}


class _HomeState extends State<Home> {
  String url = '';
  var data;
  String output = 'Initial Output';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Simple Flask App')),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            TextField(
              onChanged: (value) {
                url = 'http://192.168.43.75:5000/api?query=' + value.toString();
              },
            ),
            TextButton(
                onPressed: () async {
                  print("hello");
                  data = await fetchdata(url);
                  var decoded = jsonDecode(data);
                    print("hello3");
                  setState(() {

                    output = decoded['output'];
                  });
                  print("hello2");
                  
                },
                child: Text(
                  'Fetch ASCII Value',
                  style: TextStyle(fontSize: 20),
                )),
            Text(
              output,
              style: TextStyle(fontSize: 40, color: Colors.green),
            )
          ]),
        ),
      ),
    );
  }
}
