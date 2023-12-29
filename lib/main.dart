import 'package:countmein/pages/defect_track.dart';
import 'package:countmein/pages/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:countmein/auth/login_page.dart';
import 'package:countmein/pages/template_select.dart';
import 'package:countmein/pages/order_details.dart';
import 'package:countmein/pages/home_page.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:countmein/pages/load_image.dart';
import 'firebase_options.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    DevicePreview(
      enabled: true,
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
      title: 'CountMeIn',
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) =>  LandingPage(),
        '/home': (context) => const HomePage(),
        '/templateSelect': (context) => const TemplateSelect(),
        '/orderDetails': (context) => const OrderDetailsPage("your_order_id"),
        '/loadImage': (context) => const LoadImagePage(),
        '/defectTrack': (context) => const DefectTrackPage()
      },
    );
  }
}
