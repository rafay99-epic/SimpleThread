import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:simplethread/src/backend/services/auth/login_or_register.dart';
import 'package:simplethread/src/frontend/screens/auth/verify_email.dart';
import 'package:simplethread/src/frontend/screens/chat/home.dart';

//--------------------------------------------------
//  Auth Gateway: Check Signed In and Verify Email
//--------------------------------------------------
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            User? user = snapshot.data;
            if (user == null) {
              return const LoginOrRegister();
            } else if (!user.emailVerified) {
              return const VerifyEmail();
            } else {
              return HomePage();
            }
          } else {
            // Show a loading spinner while waiting for the stream
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
