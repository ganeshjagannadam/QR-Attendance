
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:qa/firebase_options.dart';
import 'SplashScreen.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QR Code',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      home:  const SplashScreen(),
    );
  }
}