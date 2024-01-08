  import 'package:email_validator/email_validator.dart';
  import 'package:flutter/material.dart';
  import 'package:countmein/common/page_header.dart';
  import 'package:countmein/common/page_heading.dart';
  import 'package:countmein/auth/login_page.dart';
  import 'package:countmein/common/custom_form_button.dart';
  import 'package:countmein/common/custom_input_field.dart';
  import 'package:firebase_auth/firebase_auth.dart';
  import   'package:firebase_database/firebase_database.dart';

  class SignupPage extends StatefulWidget {
    const SignupPage({Key? key}) : super(key: key);

    @override
    State<SignupPage> createState() => _SignupPageState();
  }

  class _SignupPageState extends State<SignupPage> {
    final _signupFormKey = GlobalKey<FormState>();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _rePasswordController = TextEditingController();
     final TextEditingController _epfController = TextEditingController();


    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseDatabase database = FirebaseDatabase.instance;
    
    @override
    Widget build(BuildContext context) {
      return SafeArea(
        child: Scaffold(
        backgroundColor: const Color(0xffEEF1F3),
        body: Column(
          children: [
            const PageHeader(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                          child: SingleChildScrollView(
                            child: Form(
                key: _signupFormKey,
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        children: [
                          const PageHeading(
                            title: 'Sign-up',
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          CustomInputField(
                              controller: _nameController,
                              labelText: 'Name',
                              hintText: 'Enter Your name',
                              isDense: true,
                              validator: (textValue) {
                                if (textValue == null || textValue.isEmpty) {
                                  return 'Name field is required!';
                                }
                                return null;
                              }),
                          const SizedBox(
                            height: 16,
                          ),
                          CustomInputField(
                              controller: _emailController,
                              labelText: 'Email',
                              hintText: 'Enter Your email id',
                              isDense: true,
                              validator: (textValue) {
                                if (textValue == null || textValue.isEmpty) {
                                  return 'Email is required!';
                                }
                                if (!EmailValidator.validate(textValue)) {
                                  return 'Please enter a valid email';
                                }
                                return null;
                              }),
                          const SizedBox(
                            height: 16,
                          ),
                           CustomInputField(
                              controller: _epfController,
                              labelText: 'Epf Number',
                              hintText: 'Enter your EPF Number',
                              isDense: true,
                              validator: (textValue) {
                                if (textValue == null || textValue.isEmpty) {
                                  return 'Epf is required!';
                                }
                               
                                return null;
                              }),
                                 const SizedBox(
                            height: 16,
                          ),
                          CustomInputField(
                            controller: _passwordController,
                            labelText: 'Password',
                            hintText: 'Enter Your password',
                            isDense: true,
                            obscureText: true,
                            validator: (textValue) {
                              if (textValue == null || textValue.isEmpty) {
                                return 'Password is required!';
                              }
                              return null;
                            },
                            suffixIcon: true,
                          ),
                             const SizedBox(
                            height: 16,
                          ),
                              CustomInputField(
                            controller: _rePasswordController,
                            labelText: 'Re-Password',
                            hintText: 'Retype Your password',
                            isDense: true,
                            obscureText: true,
                            validator: (textValue) {
                              if (textValue == null || textValue.isEmpty) {
                                return 'Password is required!';
                              }else if(textValue!=_passwordController.text){
                                return 'Password is mismatched';
                              }
                              return null;
                            },
                            suffixIcon: true,
                          ),
                            
                          const SizedBox(
                            height: 22,
                          ),
                          CustomFormButton(
                             textSize: 18.0,
                             inputSize: 0.8,
                            innerText: 'Signup',
                            onPressed: _handleSignupUser,
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          SizedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  'Already have an account ? ',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Color(0xff939393),
                                      fontWeight: FontWeight.bold),
                                ),
                                GestureDetector(
                                  onTap: () => {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginPage()))
                                  },
                                  child: const Text(
                                    'Log-in',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color(0xff748288),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                            ),
                          ),
                        ),
              ),
      ),
       ],
        ),
      ),
    );
  }



  updateAccountInfo() {
    final User? user = auth.currentUser;

    if (user != null) {
      // Timestamp
    try {
        int timestamp = DateTime.now().millisecondsSinceEpoch;
        DatabaseReference ref =
            FirebaseDatabase.instance.ref("users/${user.uid}");

        Map<String, dynamic> hashMap = {
          "uid": user.uid,
          "email": _emailController.text,
          "name": _nameController.text,
          "timestamp": timestamp,
          "profileImage": "", // For the moment, keep it empty
          "userType": "user",
          "epf": _epfController.text, // Possible values are admin and user; make admin manually in the Firebase Realtime Database by changing this value
        };

        // Set data to the database
        ref.set(hashMap);

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Account Created..."),
        ));

        // Navigate to the home screen or any other screen you want after successful signup
        Navigator.pushReplacementNamed(context, '/home');
    } on FirebaseAuthException catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.message.toString()),
          ),
      );

      }
    }
  }

      void _handleSignupUser() {
        if (_signupFormKey.currentState!.validate()) {
          final email = _emailController.text.trim();
          final password = _passwordController.text.trim();

          if (email.isEmpty || password.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Email or password is empty"),
              ),
            );
            return;
          }

          try {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Submitting Data"),
              ),
            );

            auth
                .createUserWithEmailAndPassword(
                    email: _emailController.text,
                    password: _passwordController.text)
                .whenComplete(() => updateAccountInfo());
          } on FirebaseAuthException catch (error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(error.message.toString()),
              ),
            );
          }
        }
      }
}
  
