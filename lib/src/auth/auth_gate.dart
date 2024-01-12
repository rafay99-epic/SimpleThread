import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:simplethread/src/auth/login_or_register.dart';
import 'package:simplethread/src/screens/home.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // if (snapshot.connectionState == ConnectionState.active) {
          //   if (snapshot.hasData) {
          //     return const home();
          //   } else {
          //     return const Center(
          //       child: Text('No user is signed in'),
          //     );
          //   }
          // } else {
          //   return const Center(
          //     child: CircularProgressIndicator(),
          //   );
          // }

          if (snapshot.hasData) {
            return const HomePage();
          } else {
            return const LoginOrRegister();
          }
        },
      ),
    );
  }
}