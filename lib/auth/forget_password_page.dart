import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:countmein/common/custom_form_button.dart';
import 'package:countmein/common/page_header.dart';
import 'package:countmein/common/page_heading.dart';
import 'package:countmein/auth/login_page.dart';
import 'package:countmein/common/custom_input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {

  final _forgetPasswordFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
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
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20),),
                  ),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _forgetPasswordFormKey,
                      child: Column(
                        children: [
                          const PageHeading(title: 'Forgot password',),
                          CustomInputField(
                              controller: _emailController ,
                              labelText: 'Email',
                              hintText: 'Your email id',
                              isDense: true,
                              validator: (textValue) {
                                if(textValue == null || textValue.isEmpty) {
                                  return 'Email is required!';
                                }
                                if(!EmailValidator.validate(textValue)) {
                                  return 'Please enter a valid email';
                                }
                                return null;
                              }
                          ),
                          const SizedBox(height: 20,),
                          CustomFormButton(
                             textSize: 20.0,
                            innerText: 'Submit', 
                            onPressed: _handleForgetPassword,
                             inputSize: 0.8,
                            ),
                          const SizedBox(height: 20,),
                          Container(
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: () => {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()))
                              },
                              child: const Text(
                                'Back to login',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Color(0xff939393),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
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

  void _handleForgetPassword() {
    // forget password
    if (_forgetPasswordFormKey.currentState!.validate()) {
      auth
          .sendPasswordResetEmail(email: _emailController.text)
          .whenComplete(() => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Password reset link sent to your email"),
                ),
              ));
    }
  }
}
