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
    apiKey: 'AIzaSyCfR8MvX0ZrcJ28UsF-Byl6dbd9HB1VhjM',
    appId: '1:388043742986:web:9bfed16c9e9025c4a2a4f3',
    messagingSenderId: '388043742986',
    projectId: 'qr-attendance-32190',
    authDomain: 'qr-attendance-32190.firebaseapp.com',
    storageBucket: 'qr-attendance-32190.appspot.com',
    measurementId: 'G-M2M0YQHKCY',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCpLEg0IbsVp3p66LrAykZx5c1J5Z15Jyw',
    appId: '1:388043742986:android:41ad40fbd003ebeba2a4f3',
    messagingSenderId: '388043742986',
    projectId: 'qr-attendance-32190',
    storageBucket: 'qr-attendance-32190.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB_D6UWAE0HmYFBeQBXEU4zz8F1scpEStY',
    appId: '1:388043742986:ios:99fa6364075ff10ea2a4f3',
    messagingSenderId: '388043742986',
    projectId: 'qr-attendance-32190',
    storageBucket: 'qr-attendance-32190.appspot.com',
    iosClientId: '388043742986-2jlrgm0drv6dhpnv8g5os6krcmg4r9u7.apps.googleusercontent.com',
    iosBundleId: 'com.example.qa',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB_D6UWAE0HmYFBeQBXEU4zz8F1scpEStY',
    appId: '1:388043742986:ios:9bd553c57c1dd95ea2a4f3',
    messagingSenderId: '388043742986',
    projectId: 'qr-attendance-32190',
    storageBucket: 'qr-attendance-32190.appspot.com',
    iosClientId: '388043742986-240962couia52k0oihv98iaiv49pbc5v.apps.googleusercontent.com',
    iosBundleId: 'com.example.qa.RunnerTests',
  );
}
