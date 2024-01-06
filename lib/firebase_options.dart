// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAliRllgPPWF8F-yXLYvHprJvk3K2DaHf8',
    appId: '1:29633496293:web:900446f30e4c84afd1000c',
    messagingSenderId: '29633496293',
    projectId: 'countmein-e7dcb',
    authDomain: 'countmein-e7dcb.firebaseapp.com',
    storageBucket: 'countmein-e7dcb.appspot.com',
    measurementId: 'G-B4JRKFNWYB',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB8hehDfWvvTBuwAuYCUcxG9ezUkAWe0bs',
    appId: '1:29633496293:android:fa429701acb93321d1000c',
    messagingSenderId: '29633496293',
    projectId: 'countmein-e7dcb',
    storageBucket: 'countmein-e7dcb.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAPbRcm4gomNvdkLbtSjbPNMjDbvsXkDTA',
    appId: '1:29633496293:ios:0c52b4ee3cb07c74d1000c',
    messagingSenderId: '29633496293',
    projectId: 'countmein-e7dcb',
    storageBucket: 'countmein-e7dcb.appspot.com',
    iosBundleId: 'com.example.countmeinApp1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAPbRcm4gomNvdkLbtSjbPNMjDbvsXkDTA',
    appId: '1:29633496293:ios:0c52b4ee3cb07c74d1000c',
    messagingSenderId: '29633496293',
    projectId: 'countmein-e7dcb',
    storageBucket: 'countmein-e7dcb.appspot.com',
    iosBundleId: 'com.example.countmeinApp1',
  );
}