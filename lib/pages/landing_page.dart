import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:countmein/auth/login_page.dart';
import 'package:countmein/pages/home_page.dart';

class LandingPage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: _auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User? user = snapshot.data;
          if (user == null) {
            // User is not logged in, show login page
            return LoginPage();
          } else {
            // User is logged in, show home page
            return HomePage();
          }
        } else {
          // Connection state is not active, show loading indicator
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}

