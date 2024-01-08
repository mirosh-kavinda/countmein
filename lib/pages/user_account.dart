import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class userAccount extends StatefulWidget {
  const userAccount({Key? key}) : super(key: key);

  @override
  State<userAccount> createState() => _userAccountState();
}

class _userAccountState extends State<userAccount> {
  late User? _user;
  late Map<String, dynamic> _userData = {};
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _initializeUser();
  }

  Future<void> _initializeUser() async {
    User? user = auth.currentUser;
    if (user != null) {
      setState(() {
        _user = user;
      });

      // Fetch user details from Realtime Database
      await _fetchUserData(user.uid);
    }
  }

  Future<void> _fetchUserData(String uid) async {
    DatabaseReference databaseReference =
        FirebaseDatabase.instance.ref().child('users').child(uid);

    DatabaseEvent dataSnapshot = await databaseReference.once();

    if (dataSnapshot.snapshot.value != null) {
      Map<String, dynamic>? userData =
          dataSnapshot.snapshot.value as Map<String, dynamic>?;

      if (userData != null) {
        setState(() {
          _userData = userData;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: const Color(0xFFEFF3F6),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: IconButton(
            onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
            icon: const Icon(
              Icons.home,
              color: Colors.black,
              size: 28,
              opticalSize: 1,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: () => {},
                icon: const Icon(
                  Icons.edit_note_outlined,
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
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                         const Icon(
                          Icons.person_3_rounded,
                          color: Colors.black,
                          size: 170,
                          opticalSize: 1,
                          ),
                          if (_user != null)
                            Text(
                              ' ${_userData['name']}',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          const SizedBox(height: 8),
                          Text('Email: ${_userData['email'] ?? ''}'),
                          const SizedBox(height: 8),
                          Text('Epf: ${_userData["epf"] ?? ''}'),
                            const SizedBox(height: 8),
                          Text('User Type: ${_userData["userType"] ?? ''}'),
                      
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )),
          ],
        ),
      );
}
