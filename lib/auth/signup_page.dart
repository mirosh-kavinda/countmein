  import 'package:email_validator/email_validator.dart';
  import 'package:firebase_core/firebase_core.dart';
  import 'package:flutter/material.dart';
  import 'package:countmein/auth/common/page_header.dart';
  import 'package:countmein/auth/common/page_heading.dart';
  import 'package:countmein/auth/login_page.dart';
  import 'package:countmein/auth/common/custom_form_button.dart';
  import 'package:countmein/auth/common/custom_input_field.dart';
  import 'package:firebase_auth/firebase_auth.dart';

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

    FirebaseAuth auth = FirebaseAuth.instance;
    @override
    Widget build(BuildContext context) {
      return SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xffEEF1F3),
          body: SingleChildScrollView(
            child: Form(
              key: _signupFormKey,
              child: Column(
                children: [
                  const PageHeader(),
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
                            hintText: 'Your name',
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
                            hintText: 'Your email id',
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
                          controller: _passwordController,
                          labelText: 'Password',
                          hintText: 'Your password',
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
                          height: 22,
                        ),
                        CustomFormButton(
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
      );
    }

    void _handleSignupUser() {
      // signup user
      print('Email: ${_emailController.text}');
  print('Password: ${_passwordController.text}');

      if (_signupFormKey.currentState!.validate()) {
 auth
            .createUserWithEmailAndPassword(
                email: _emailController.text, password: _passwordController.text)
            .whenComplete(
              () => ScaffoldMessenger.of(context)
                  .showSnackBar(
                    const SnackBar(
                      content: Text("Successfully Signed Up"),
                    ),
                  )
            //       .closed
            //       .then((_) => Navigator.pushReplacementNamed(context, '/loadImage')),
            // );
            );
      }
    }
  }
