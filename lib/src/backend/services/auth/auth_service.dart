// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//----------------------------------
//  Auth Service Class
//----------------------------------
class AuthService {
  //------------------------------------
  //  Firebase  and Firestore Instances
  //------------------------------------
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //----------------------------------
  //  Getting Current User
  //----------------------------------
  User? getcurrentUser() {
    return _auth.currentUser;
  }

  //----------------------------------
  //  Sign in with Email and Password
  //----------------------------------
  Future<UserCredential> signInWithEmailPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //-------------------------------------------------------------
  //  Register with Email and Password, name and phone number
  //-------------------------------------------------------------
  Future<UserCredential> signUpWithEmailPassword(
    String email,
    String password,
    String name,
    String phoneNumber,
    String photourl,
  ) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await userCredential.user?.sendEmailVerification();

      _firestore.collection("Users").doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
        'name': name,
        'phoneNumber': phoneNumber,
        'photoUrl': photourl,
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //----------------------------------
  //  Sign Out User
  //----------------------------------
  Future<void> signOut() async {
    return await _auth.signOut();
  }

  //----------------------------------
  //  Send Reset Password Link
  //----------------------------------
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //----------------------------------
  //  Check User Email Verification
  //----------------------------------
  Future<bool> isEmailVerified() async {
    User? user = _auth.currentUser;
    await user?.reload();
    return user?.emailVerified ?? false;
  }

  //----------------------------------
  //  Send Email Verification Link
  //----------------------------------
  Future<void> sendVerificationEmail() async {
    User? user = _auth.currentUser;

    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }
}
