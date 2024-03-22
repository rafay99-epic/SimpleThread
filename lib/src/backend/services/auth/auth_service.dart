// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simplethread/src/frontend/screens/home.dart';

class AuthService {
  // Initialize Firebase
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //getting the current users info
  User? getcurrentUser() {
    return _auth.currentUser;
  }

  //login

  Future<void> signInWithEmailPassword(
      String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      //saving the current User information into a serperate doc if it doesn't exist
      _firestore.collection("Users").doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
      });

      // Navigate to the next page after successful login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(), // replace with your next page
        ),
      );
    } on FirebaseAuthException catch (e) {
      // Show a dialog with the error message
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            "Login Failed",
            style: GoogleFonts.playfairDisplay(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          content: Text(
            e.toString(),
            style: GoogleFonts.playfairDisplay(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'OK',
                style: GoogleFonts.playfairDisplay(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }
  }
  // Future<UserCredential> signInWithEmailPassword(
  //     String email, String password, context) async {
  //   try {
  //     UserCredential userCredential = await _auth.signInWithEmailAndPassword(
  //         email: email, password: password);

  //     //saving the current User information into a serperate doc if it doesn't exist
  //     _firestore.collection("Users").doc(userCredential.user!.uid).set({
  //       'uid': userCredential.user!.uid,
  //       'email': email,
  //     });

  //     return userCredential;
  //   } on FirebaseAuthException catch (e) {
  //     throw Exception(e.code);
  //   }
  // }

  //regisrter user
  Future<UserCredential> signUpWithEmailPassword(
    String email,
    String password,
    String name,
    String phoneNumber,
  ) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      //saving the current User information into a serperate doc
      _firestore.collection("Users").doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
        'name': name,
        'phoneNumber': phoneNumber,
      });
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //logout
  Future<void> signOut() async {
    return await _auth.signOut();
  }

  //forget password
  // Send password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }
}
