import 'package:countmein/pages/home_page.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:countmein/auth/common/custom_input_field.dart';
import 'package:countmein/auth/common/page_header.dart';
import 'package:countmein/auth/forget_password_page.dart';
import 'package:countmein/auth/signup_page.dart';
import 'package:countmein/auth/common/page_heading.dart';
import 'package:countmein/auth/common/custom_form_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
final _loginFormKey = GlobalKey<FormState>();
final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();
bool showSnackBar=false;
String snakMessage='';
FirebaseAuth auth = FirebaseAuth.instance;  


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffEEF1F3),
        body: Column(
          children: [
            const PageHeader(),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: _loginFormKey,
                    child: Column(
                      children: [
                        const PageHeading(
                          title: 'Log-in',
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

                        CustomInputField(
                          controller: _passwordController, // Pass the controller to the CustomInputField
                          labelText: 'Password',
                          hintText: 'Your password',
                          obscureText: true,
                          suffixIcon: true,
                          validator: (textValue) {
                            if (textValue == null || textValue.isEmpty) {
                              return 'Password is required!';
                            }
                            // Add password validation logic here if needed
                            return null; // Return null when the input is valid
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Container(
                          width: size.width * 0.80,
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ForgetPasswordPage()))
                            },
                            child: const Text(
                              'Forget password?',
                              style: TextStyle(
                                color: Color(0xff939393),
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomFormButton(
                          innerText: 'Login',
                          onPressed: _handleLoginUser,
                        ),
                        const SizedBox(
                          height: 48,
                        ),
                        SizedBox(
                          width: size.width * 0.8,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Don\'t have an account ? ',
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
                                              const SignupPage()))
                                },
                                child: const Text(
                                  'Sign-up',
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
                          height: 40,
                        ),
                      ],
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


  void _handleLoginUser() async {
   
    if (_loginFormKey.currentState!.validate()) {
      if (_emailController.text.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("controller is emtpy"),
            ),
          );
  
        return;
      } else {
        try {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Submitting Data"),
            ),
          );

          await auth.signInWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim()
              ).whenComplete(() => ScaffoldMessenger.of(context)
                  .showSnackBar(
                    const SnackBar(
                      content: Text("Successfully Logged In"),
                    ),
                  )
                  .closed
                  .then((_) => Navigator.pushReplacementNamed(context, '/home')),
              );

    
        } on FirebaseAuthException catch (error) {
        
          String snakMessage='';
          switch (error.code) {
            case 'user-not-found':
              snakMessage = 'Invalid email or password.';
              break;
            case 'wrong-password':
              snakMessage = 'Incorrect password.';
              break;
            case 'invalid-email':
              snakMessage = 'Invalid email .';
              break;
            default:
              snakMessage = 'An error occurred. Please try again.';
              break;
          }

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(snakMessage),
            ),
          );
        }
      }
    }
  }
}
