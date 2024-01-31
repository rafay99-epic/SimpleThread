import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:simplethread/src/frontend/screens/splash_screen.dart';

class CheckInternetPage extends StatefulWidget {
  const CheckInternetPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CheckInternetPageState createState() => _CheckInternetPageState();
}

class _CheckInternetPageState extends State<CheckInternetPage> {
  final Connectivity _connectivity = Connectivity();
  late Future<ConnectivityResult> _connectivityFuture;

  @override
  void initState() {
    super.initState();
    _connectivityFuture = _connectivity.checkConnectivity();
  }

  Future<void> _checkInternetAndNavigate() async {
    try {
      var connectivityResult = await _connectivity.checkConnectivity();
      if (connectivityResult != ConnectivityResult.none) {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SplashScreen()),
        );
      }
    } catch (e) {
      // Handle the error
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
          return Center(
            child: Lottie.asset(
              'assets/animation/loader.json',
            ),
          );
        } else if (snapshot.data == ConnectivityResult.none) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Lottie.asset('assets/animation/check_internet.json'),
                  Text(
                    'No Internet Connection',
                    style: GoogleFonts.playfairDisplay(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _checkInternetAndNavigate,
                    child: const Text(
                      'Check Your Internet Connection!! Try Again',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const SplashScreen(); // Show SplashScreen if there is internet connection
        }
      },
    );
  }
}
