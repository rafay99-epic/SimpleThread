import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //get current user
  Future<User?> getCurrentUser() async {
    return _auth.currentUser;
  }

  //get User Data
  Future<DocumentSnapshot> getUserData(String userId) async {
    return _firestore.collection('Users').doc(userId).get();
  }

  //Update user data
  Future<void> updateUserData(
      String userId, String email, String name, String phoneNumber) async {
    return _firestore.collection('Users').doc(userId).update({
      'email': email,
      'name': name,
      'phoneNumber': phoneNumber,
    });
  }
}
