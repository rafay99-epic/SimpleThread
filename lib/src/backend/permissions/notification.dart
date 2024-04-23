import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationPermission {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  void requestNotificationPermissions() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
  }
}
