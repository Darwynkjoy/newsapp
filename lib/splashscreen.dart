import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset("assets/images/Animation - 1739863862725.json"),
      ),
    );
  }
}