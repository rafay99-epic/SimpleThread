// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:simplethread/src/backend/services/auth/login_or_register.dart';

//----------------------------------
//  Delete User Auth and Data
//----------------------------------
class DeleteDataProfile {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //----------------------------------
  //  Delete User Auth
  //----------------------------------
  Future<void> deleteUserAuth() async {
    try {
      await _auth.currentUser?.delete();
    } catch (e) {
      print(e.toString());
      // Handle error as needed
    }
  }

  //----------------------------------
  //  Delete User Data
  //----------------------------------
  Future<void> deleteUserData(String userId) async {
    try {
      await _firestore.collection('Users').doc(userId).delete();
    } catch (e) {
      print(e.toString());
      // Handle error as needed
    }
  }

  //----------------------------------
  //  Delete User Chat Room Data
  //----------------------------------
  Future<void> deleteChatRoomData(String userId) async {
    final QuerySnapshot querySnapshot = await _firestore
        .collection('chat_rooms')
        .where('Users', arrayContains: userId)
        .get();
    for (final DocumentSnapshot documentSnapshot in querySnapshot.docs) {
      await documentSnapshot.reference.delete();
    }
  }

//----------------------------------
//  Delete User Profile Image
//----------------------------------
  Future<void> deleteUserProfileImage(String email) async {
    try {
      final encodedEmail = base64Url.encode(utf8.encode(email));

      final ref = FirebaseStorage.instance
          .ref()
          .child('profile_pictures')
          .child(encodedEmail);

      // Delete the file
      await ref.delete();
    } catch (e) {
      print(e.toString());
    }
  }

  //----------------------------------
  //  Calling All Delete Functions
  //----------------------------------
  Future<void> deleteAccount(BuildContext context) async {
    final String userId = _auth.currentUser!.uid;
    final String userEmail = _auth.currentUser!.email!;
    await deleteUserAuth();
    await deleteUserData(userId);
    await deleteUserProfileImage(userEmail);
    await deleteChatRoomData(userId);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginOrRegister(),
      ),
    );
  }
}
