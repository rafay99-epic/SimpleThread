// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:simplethread/src/frontend/screens/errorAndLoading/loading.dart';
import 'package:simplethread/src/frontend/screens/home/splash_screen.dart';

class CheckInternetPage extends StatefulWidget {
  const CheckInternetPage({Key? key}) : super(key: key);

  @override
  _CheckInternetPageState createState() => _CheckInternetPageState();
}

class _CheckInternetPageState extends State<CheckInternetPage> {
  final Connectivity _connectivity = Connectivity();
  late Future<ConnectivityResult> _connectivityFuture;

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _connectivityFuture = _connectivity.checkConnectivity();
    _timer = Timer.periodic(
      const Duration(seconds: 10),
      (timer) => _checkInternetAndNavigate(),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _checkInternetAndNavigate() async {
    try {
      var connectivityResult = await _connectivity.checkConnectivity();
      if (connectivityResult != ConnectivityResult.none) {
        _timer?.cancel();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SplashScreen()),
        );
      }
    } catch (e) {
      print('Failed to check internet connection: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ConnectivityResult>(
      future: _connectivityFuture,
      builder:
          (BuildContext context, AsyncSnapshot<ConnectivityResult> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else if (snapshot.data == ConnectivityResult.none) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Lottie.asset(
                    'assets/animation/no_internet3.json',
                  ),
                ],
              ),
            ),
          );
        } else {
          return const SplashScreen();
        }
      },
    );
  }
}
