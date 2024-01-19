import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:simplethread/src/backend/model/message.dart';

class ChatService {
  // get firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //getting the user id
  final FirebaseAuth _auth = FirebaseAuth.instance;

/*
! I've worked on this code for ten hours. Please don't alter the structure. If you do decide to alter the code, you should add the necessary time to this counter. 
! Counter: 10h

* Stream<List<Map<String, dynamic>>>

*This code goes through each document that a user has in the firestore by 
*navigating across them.

*/
  //get user stream or data from the database
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

  //send message to different Users
  Future<void> sendMessage(String reciverID, message) async {
    //getting current user is
    final String currentuserID = _auth.currentUser!.uid;
    final String currentuserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    //create a new message
    Message newMessage = Message(
      senderID: currentuserEmail,
      senderEmail: currentuserID,
      reciverID: reciverID,
      message: message,
      timestamp: timestamp,
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
}
