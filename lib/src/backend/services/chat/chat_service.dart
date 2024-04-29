import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:simplethread/src/backend/model/message.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<List<Map<String, dynamic>>> getUserStream() {
    return _firestore.collection('Users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        //go through each User and fetch data
        final user = doc.data();
        //return those users
        return user;
      }).toList();
    });
  }

  // Stream<Set<Map<String, dynamic>>> getUserStreamMessage() {
  //   final String currentUserId = _auth.currentUser!.uid;
  //   StreamController<Set<Map<String, dynamic>>> controller = StreamController();

  //   _firestore
  //       .collection('chat_rooms')
  //       .where('senderID', isEqualTo: currentUserId)
  //       .snapshots()
  //       .listen((snapshot) async {
  //     Set<Map<String, dynamic>> users = {};
  //     print("------------------------------------------------");
  //     print('chat_rooms docs: ${snapshot.docs.length}');
  //     print("-------------------------------------------------");

  //     for (var chatRoomDoc in snapshot.docs) {
  //       print("--------------------------------------------");
  //       print('chatRoomDoc id: ${chatRoomDoc.id}');
  //       print("--------------------------------------------");
  //       final otherUserID = chatRoomDoc.data()['reciverID'];
  //       print('otherUserID: $otherUserID');
  //       final otherUserDoc =
  //           await _firestore.collection('Users').doc(otherUserID).get();
  //       if (otherUserDoc.exists && !users.contains(otherUserDoc.data())) {
  //         users.add(otherUserDoc.data()!);
  //       }
  //     }

  //     print("-------------------------------");
  //     print('users: ${users.length}');
  //     print("-------------------------------");

  //     controller.add(users);
  //   });

  //   return controller.stream;
  // }

  Future<void> sendMessage(String reciverID, message) async {
    final String currentuserID = _auth.currentUser!.uid;
    final String currentuserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    Message newMessage = Message(
      senderID: currentuserID,
      senderEmail: currentuserEmail,
      reciverID: reciverID,
      message: message,
      timestamp: timestamp,
      // read: false,
    );

    //contruct chat room ID for two users
    List<String> ids = [currentuserID, reciverID];
    ids.sort(); //sort them to chatroom ID and making sure they are in the same room
    String chatRomID = ids.join('_');
    //add message to the db
    await _firestore
        .collection("chat_rooms")
        .doc(chatRomID)
        .collection("messages")
        .add(newMessage.toMap());
  }

  //get message from users
  Stream<QuerySnapshot<Map<String, dynamic>>> getMessage(
      String userID, otherUserID) {
    // constructer a chat room between tow users.
    List<String> ids = [userID, otherUserID];
    ids.sort(); //sort them to chatroom ID and making sure they are in the same room
    String chatRoomID = ids.join('_');

    return _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}
