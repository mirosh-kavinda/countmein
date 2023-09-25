import 'package:flutter/material.dart';

class OrderDetailsPage extends StatelessWidget {
  final String orderId;

  const OrderDetailsPage(this.orderId, {super.key});

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
          ],
        ),
      ),
    );
  }
}
