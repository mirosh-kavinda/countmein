import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class LoadImagePage extends StatefulWidget {
  final String headerText;

  const LoadImagePage({Key? key, required this.headerText}) : super(key: key);

  @override
  _LoadImagePageState createState() => _LoadImagePageState();
}

class _LoadImagePageState extends State<LoadImagePage> {
  late DatabaseReference _databaseReference;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().then((value) {
      _databaseReference = FirebaseDatabase.instance.reference().child('orders');
    });
  }

  Future<Map<String, dynamic>> getOrderDetails(String orderId) async {
    DataSnapshot dataSnapshot = await _databaseReference.child(orderId).once();
    return Map<String, dynamic>.from(dataSnapshot.value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.headerText),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: getOrderDetails('your_order_id_here'), // Replace with the actual order ID
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Text('No data available');
          } else {
            // Extract data from the snapshot
            Map<String, dynamic> orderData = snapshot.data!;
            String customerName = orderData['name'];
            String orderDate = orderData['date'];
            String orderStatus = orderData['status'];
            String agentId = orderData['epf'];
            Map<String, dynamic> products = orderData['products'];

            // Now you can use the extracted data to display in your UI
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Customer Name: $customerName'),
                Text('Order Date: $orderDate'),
                Text('Order Status: $orderStatus'),
                Text('Agent ID: $agentId'),
                Text('Products:'),
                for (var productId in products.keys)
                  Text(
                    'Product ID: $productId, Quantity: ${products[productId]['quantity']}, Price: ${products[productId]['price']}',
                  ),
              ],
            );
          }
        },
      ),
    );
  }
}
