// ignore_for_file: library_private_types_in_public_api

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
  //-------------------------
  // Connectivity Variables
  //-------------------------
  final Connectivity _connectivity = Connectivity();
  late Future<ConnectivityResult> _connectivityFuture;
  Timer? _internetCheckTimer;

  //-------------------------------
  // Init state and dispose state
  //-------------------------------
  @override
  void initState() {
    super.initState();
    _connectivityFuture = _connectivity.checkConnectivity();
    _internetCheckTimer = Timer.periodic(
      const Duration(seconds: 10),
      (timer) => _checkInternetAndNavigate(),
    );
  }

  @override
  void dispose() {
    _internetCheckTimer?.cancel();
    super.dispose();
  }

  //-------------------------
  // Check Internet Connection
  //-------------------------
  Future<void> _checkInternetAndNavigate() async {
    try {
      var connectivityResult = await _connectivity.checkConnectivity();
      if (connectivityResult != ConnectivityResult.none) {
        _internetCheckTimer?.cancel();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SplashScreen()),
        );
      }
    } catch (e) {
      print('Failed to check internet connection: $e');
    }
  }

  //-------------------------
  // Build Method
  //-------------------------
  @override
  Widget build(BuildContext context) {
    return _buildConnectivityFutureBuilder();
  }

  //-------------------------------------
  // Build Connectivity Future Builder
  //-------------------------------------
  Widget _buildConnectivityFutureBuilder() {
    return FutureBuilder<ConnectivityResult>(
      future: _connectivityFuture,
      builder: (context, snapshot) =>
          _buildConnectivitySnapshotBuilder(context, snapshot),
    );
  }

  //--------------------------------------
  // Build Connectivity Snapshot Builder
  //---------------------------------------
  Widget _buildConnectivitySnapshotBuilder(
      BuildContext context, AsyncSnapshot<ConnectivityResult> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const LoadingScreen();
    } else if (snapshot.data == ConnectivityResult.none) {
      return _buildNoInternetConnectionScreen();
    } else {
      return const SplashScreen();
    }
  }

  //--------------------------------------
  // No Internet Connection Screen
  //---------------------------------------
  Widget _buildNoInternetConnectionScreen() {
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
  }
}
