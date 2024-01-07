
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ...




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
          onPressed: () =>Navigator.pushReplacementNamed(context, '/userAccount'),
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
              onPressed: () =>_handleLogoutUser(context) ,
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
                 const  SizedBox(height: 24.0),
                  const Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 16.0),
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
                    child: ListView.builder(
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/loadImage');
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Card(
                              elevation: 2.0,
                              child: ListTile(
                                leading: Container(
                                  width: 60.0,
                                  height: 60.0,
                                  decoration: const BoxDecoration(
                                    color: Colors.blue,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                title: Text(
                                  'Job ${index + 1}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: const Text('select this job to count steal bars'),
                                trailing: const Icon(
                                  Icons.keyboard_arrow_right,
                                ),
                              ),
                            ),
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
    
    FirebaseAuth.instance.signOut().whenComplete(() => 
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Successfully Signed Out"),
      ),
    ).close
    ).then((value) =>   Navigator.pushReplacementNamed(context, '/'));
    
  } catch (e) {

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("An error occurred during logout. Please try again."),
      ),
    );
  }
}
}
