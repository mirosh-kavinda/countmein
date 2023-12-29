import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class OrderDetailsPage extends StatelessWidget {
  final String orderId;

  const OrderDetailsPage(this.orderId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Order Details for Order ID: $orderId'),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/templateSelect');
              },
              child: const Text('Go to Template Select'),
            ),
             ListView(
          children: [
    
          ListTile(
            // leading: Icon(CupertinoIcons.hash_circle_fill),
            title: Text('Order No.'),
            subtitle: Text('1234567890'),
          ),
          // Checked by
          ListTile(
            // leading: Icon(CupertinoIcons.person_fill),
            title: Text('Checked By'),
            subtitle: Text('John Doe'),
          ),
          // Order package
          ListTile(
            // leading: Icon(CupertinoIcons.package_fill),
            title: Text('Order Package'),
            subtitle: Text('Box'),
          ),
          ],
        ),
          ]
        ),
      ),
    );
  }
}
