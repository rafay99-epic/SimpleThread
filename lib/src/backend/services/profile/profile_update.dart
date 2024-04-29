import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//----------------------------------
//  Profile Page Functionalitty
//----------------------------------
class ProfileService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //----------------------------------
  //  Checking the Current User
  //----------------------------------
  Future<User?> getCurrentUser() async {
    return _auth.currentUser;
  }

  //----------------------------------
  //  Getting  User ID
  //----------------------------------
  Future<DocumentSnapshot> getUserData(String userId) async {
    return _firestore.collection('Users').doc(userId).get();
  }

  //----------------------------------
  //  Update User Data
  //----------------------------------

  Future<void> updateUserData(String userId, String email, String name,
      String phoneNumber, String password, String photoUrl) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null && user.email != email) {
      await _checkEmail(email);
      await _reauthenticateUser(user, password);
      await _updateEmail(user, email);
      await _sendVerificationEmail(user);
    }

    return _updateFirestore(userId, email, name, phoneNumber, photoUrl);
  }

  //----------------------------------
  //  Checking for Existing Email
  //----------------------------------

  Future<void> _checkEmail(String email) async {
    final signInMethods =
        await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
    if (signInMethods.isNotEmpty) {
      throw Exception('The email is already in use.');
    }
  }

  //-----------------------------------------
  //  Reauthenticating User: Changing Email
  //----------------------------------------

  Future<void> _reauthenticateUser(User user, String password) async {
    AuthCredential credential =
        EmailAuthProvider.credential(email: user.email!, password: password);
    await user.reauthenticateWithCredential(credential);
  }

  //----------------------------------
  //  Updaing Email Adress
  //----------------------------------

  Future<void> _updateEmail(User user, String email) async {
    await user.updateEmail(email).catchError((error) {
      throw Exception(
          'Failed to update email in Firebase Authentication: $error');
    });
  }

  //----------------------------------
  //  Send Verfication Code
  //----------------------------------

  Future<void> _sendVerificationEmail(User user) async {
    await user.sendEmailVerification().catchError((error) {
      throw Exception('Failed to send verification email: $error');
    });
  }

  //----------------------------------
  //  Update Data in Firestore
  //----------------------------------

  Future<void> _updateFirestore(String userId, String email, String name,
      String phoneNumber, String photoUrl) {
    return _firestore.collection('Users').doc(userId).update({
      'email': email,
      'name': name,
      'phoneNumber': phoneNumber,
      'photoUrl': photoUrl
    });
  }
}
