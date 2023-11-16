import 'package:flutter/material.dart';

class CountingPage extends StatefulWidget {
  @override
  _CountingPageState createState() => _CountingPageState();
}

class _CountingPageState extends State<CountingPage> {
  int _count = 0;

  void incrementCount() {
    setState(() {
      _count++;
    });
  }

  void decrementCount() {
    setState(() {
      _count--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Counting Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$_count',
              style: TextStyle(fontSize: 50),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FloatingActionButton(
                  onPressed: decrementCount,
                  child: Icon(Icons.remove),
                ),
                FloatingActionButton(
                  onPressed: incrementCount,
                  child: Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
