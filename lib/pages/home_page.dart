import 'dart:math';

import 'package:countmein/pages/load_image.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final CollectionReference<Map<String, dynamic>> _usersCollection =
    FirebaseFirestore.instance.collection('USER_WORKORDERS');

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF3F6),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () =>
              Navigator.pushReplacementNamed(context, '/userAccount'),
          icon: const Icon(
            Icons.account_circle_rounded,
            color: Colors.black,
            size: 28,
            opticalSize: 1,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () => _handleLogoutUser(context),
              icon: const Icon(
                Icons.logout,
                color: Colors.black,
                size: 28,
                opticalSize: 1,
              ),
            ),
          ),
        ],
      ),
      body: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 24.0),
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(32.0),
                              topRight: Radius.circular(32.0),
                            ),
                          ),
                          child: Column(
                            children: [
                              const SizedBox(height: 24.0),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Pending Jobs To Proceed..',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 24.0), 
                               Expanded(
                                child: StreamBuilder<QuerySnapshot>(
                                  stream: _usersCollection.snapshots(),
                                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (snapshot.hasError) {
                                      return Center(
                                        child: Text('Error: ${snapshot.error}'),
                                      );
                                    }
                                
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                
                                    return RefreshIndicator(
                                      onRefresh: () async {
                                        // You can add code here to manually refresh the data
                                      },
                                     child: ListView(
                                      children: snapshot.data!.docs.map((DocumentSnapshot document) {
                                      Map<String, dynamic> data =
                                      document.data()! as Map<String, dynamic>;
                                         return ListTile(
                                            leading: Container(
                                              width: 60.0,
                                              height: 60.0,
                                              decoration: const BoxDecoration(
                                                color: Colors.blue,
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            title: Text(
                                              'Job Name : ${data['orderName']}',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            subtitle: Text(
                                                'Order status : ${data['status']}'),
                                            trailing: const Icon(
                                              Icons.keyboard_arrow_right,
                                            ),
                                            onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => LoadImagePage(headerText: 'Job Name : ${data['orderName']}', calculatedCount: data['quantity'], id:data['_id']),
                                                  ),
                                                );
                                              },
                                          );
                                          }).toList(),

                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
    );
  }

  void _handleLogoutUser(BuildContext context) {
    try {
      FirebaseAuth.instance
          .signOut()
          .whenComplete(() => ScaffoldMessenger.of(context)
              .showSnackBar(
                const SnackBar(
                  content: Text("Successfully Signed Out"),
                ),
              )
              .close)
          .then((value) => Navigator.pushReplacementNamed(context, '/'));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("An error occurred during logout. Please try again."),
        ),
      );
    }
  }
}
