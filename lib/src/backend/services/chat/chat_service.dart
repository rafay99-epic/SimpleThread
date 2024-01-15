import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  // get firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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

  //get message from users
}
