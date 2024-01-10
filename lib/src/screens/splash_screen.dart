import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:simplethread/src/screens/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String _animation =
      "assets/animation/Black_white_animation.json";

  @override
  State<SplashScreen> createState() => SsplasScreenhState();
}

class SsplasScreenhState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
          context,
          PageTransition(
            child: const home(),
            type: PageTransitionType.fade,
            duration: const Duration(seconds: 3, milliseconds: 30),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [Lottie.asset(SplashScreen._animation)],
      ),
    );
  }
}
