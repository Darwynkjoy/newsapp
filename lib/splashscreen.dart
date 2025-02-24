import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:newsapp/homepage.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  void pusher(BuildContext context) {
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Homepage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => pusher(context));
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Lottie.asset("assets/images/news.json",width: 150,height: 150,fit: BoxFit.cover)),
          RichText(
  text: TextSpan(
    text: "Read",
    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500, color: Colors.black),
    children: <TextSpan>[
      TextSpan(
        text: "I",
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.blue),
      ),
      TextSpan(
        text: "t",
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
      )
    ],
  ),
),
        ],
      ),
    );
  }
}
