import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class OrderDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
      ),
      body: ListView(
        children: [
          // Order number
          // ListTile(
          //   leading: Icon(CupertinoIcons.hash_circle_fill),
          //   title: Text('Order No.'),
          //   subtitle: Text('1234567890'),
          // ),
          // // Checked by
          // ListTile(
          //   leading: Icon(CupertinoIcons.person_fill),
          //   title: Text('Checked By'),
          //   subtitle: Text('John Doe'),
          // ),
          // Order package
          // // ListTile(
          // //   leading: Icon(CupertinoIcons.package_fill),
          // //   title: Text('Order Package'),
          // //   subtitle: Text('Box'),
          // // ),
          // Weight bridge count (KG)
          // ListTile(
          //   leading: Icon(CupertinoIcons.weight_kg),
          //   title: Text('Weight Bridge Count (KG)'),
          //   subtitle: Text('10'),
          // ),
          // // Next button
          // ListTile(
          //   trailing: Icon(CupertinoIcons.forward),
          //   title: Text('Next'),
          //   onTap: () {
          //     // Navigate to the next page
          //   },
          
        ],
      ),
    );
  }
}
