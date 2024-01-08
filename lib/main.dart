import 'package:countmein/pages/landing_page.dart';
import 'package:countmein/pages/user_account.dart';
import 'package:flutter/material.dart';
import 'package:countmein/pages/home_page.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:countmein/pages/load_image.dart';
import 'firebase_options.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    DevicePreview(
      enabled: false,
      tools: [...DevicePreview.defaultTools],
      builder: (context) => const CountMeIn(),
    ),
  );
}

class CountMeIn extends StatelessWidget {
  const CountMeIn({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, 
      title: 'CountMeIn',
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => AnimatedSplashScreen(
              splash: Image.asset(
                'assets/images/friendship.png',
              ),
              duration: 1500,
              backgroundColor: Colors.white,
              splashIconSize: double.infinity,
              splashTransition: SplashTransition.fadeTransition,
              nextScreen: LandingPage(),
            ),
        '/home': (context) =>  const HomePage(),
        // '/loadImage': (context) => const LoadImagePage(),
        '/userAccount':(context)=>const userAccount()
      },
    );
  }
}
