
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AnimationScreen extends StatefulWidget {
  const AnimationScreen({Key? key}) : super(key: key);

  @override
  State<AnimationScreen> createState() => AnimationState();
}

class AnimationState extends State<AnimationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          widthFactor: 15,
          heightFactor: 20.1,
          child: Lottie.asset(
            'assets/animations/google-pay-success.json',
            width: 200,
            height: 200,
            fit: BoxFit.cover,
            repeat: false,
          ))
    );
  }
}
