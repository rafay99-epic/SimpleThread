import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

import 'package:simplethread/src/backend/services/auth/auth_gate.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String _animation =
      "assets/animation/Black_white_animation.json";

  @override
  State<SplashScreen> createState() => SsplasScreenhState();
}

class SsplasScreenhState extends State<SplashScreen> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  void _requestNotificationPermissions() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  @override
  void initState() {
    super.initState();
    _requestNotificationPermissions();
    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
          context,
          PageTransition(
            child: const AuthGate(),
            type: PageTransitionType.rightToLeftWithFade,
            duration: const Duration(seconds: 1, milliseconds: 50),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Transform.scale(
            scale: 1.3,
            child: Lottie.asset(SplashScreen._animation),
          ),
        ],
      ),
    );
  }
}
