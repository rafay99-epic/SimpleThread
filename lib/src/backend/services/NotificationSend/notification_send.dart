// ignore_for_file: library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:simplethread/src/constants/errorAndLoading/error.dart';
import 'package:simplethread/src/constants/errorAndLoading/loading.dart';

class MessageListener extends StatefulWidget {
  const MessageListener({super.key});

  @override
  _MessageListenerState createState() => _MessageListenerState();
}

class _MessageListenerState extends State<MessageListener> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> _showNotification(String title, String body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, title, body, platformChannelSpecifics);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('chat_rooms').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const SingleChildScrollView(
            child: Center(
              child: ErrorScreen(),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        }

        // If a new document is added, show a notification
        if (snapshot.data?.docChanges.isNotEmpty == true) {
          for (var change in snapshot.data!.docChanges) {
            if (change.type == DocumentChangeType.added) {
              var message = change.doc.data() as Map<String, dynamic>;
              _showNotification(
                message['title'] as String,
                message['body'] as String,
              );
            }
          }
        }

        return const Text('No new messages');
      },
    );
  }
}
