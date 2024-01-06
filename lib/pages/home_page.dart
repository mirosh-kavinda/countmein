
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
          onPressed: () {
            // Implement menu functionality here
          },
          icon: const Icon(
            Icons.menu,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () =>_handleLogoutUser(context) ,
           
            icon: const Icon(
              Icons.logout,
              color: Colors.black,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Templates',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'See All',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
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
                                  'Template ${index + 1}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: const Text('select this template to count steal bars'),
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
