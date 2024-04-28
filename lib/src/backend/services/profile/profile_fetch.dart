import 'package:firebase_auth/firebase_auth.dart';
import 'package:simplethread/src/backend/class/user_data.dart';
import 'package:simplethread/src/backend/services/profile/profile_update.dart';

class ProfileProvider {
  final ProfileService profileService = ProfileService();

  Future<UserData> loadUserData() async {
    final user = await _getCurrentUser();
    if (user == null) {
      throw Exception("You need to have an account..Please Login");
    }

    try {
      final data = await _getUserData(user.uid);
      if (data != null) {
        return UserData(
          email: data['email'] as String,
          phoneNumber: data['phoneNumber'] as String,
          name: data['name'] as String,
          photoUrl: data['photoUrl'],
        );
      } else {
        throw Exception("Your Data Does not Exist, Please Create an account");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<User?> _getCurrentUser() async {
    try {
      return await profileService.getCurrentUser();
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> _getUserData(String uid) async {
    try {
      final docSnapshot = await profileService.getUserData(uid);
      if (docSnapshot.exists) {
        return docSnapshot.data() as Map<String, dynamic>;
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }
}
