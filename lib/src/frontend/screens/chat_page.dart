import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:simplethread/src/backend/services/auth/auth_service.dart';
import 'package:simplethread/src/backend/services/chat/chat_service.dart';
import 'package:simplethread/src/frontend/compoents/my_appbar.dart';
import 'package:simplethread/src/frontend/compoents/my_textfeild.dart';

class ChatPage extends StatelessWidget {
  //Getting Data Variables
  final String receiverEmail;
  final String receiverID;
  // getting  functions
  ChatPage({
    super.key,
    required this.receiverID,
    required this.receiverEmail,
  });

  //text Controller
  final TextEditingController _messageController = TextEditingController();

  //getting chat and auth services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  //* The main Widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: (receiverEmail),
      ),
      body: Column(
        children: [
          //displaying all chat information
          Expanded(
            child: _buildMessageList(),
          ),
          //user input or inputing messaging
          _buildMessageInput(),
        ],
      ),
    );
  }

  //* sending a message function
  void sendMessage() async {
    //if there is something inside the textfeild the textfeild then send it
    if (_messageController.text.isNotEmpty) {
      //send the message
      await _chatService.sendMessage(receiverID, _messageController.text);
      _messageController.clear();
    }
  }

  //* building Message List between two users
  Widget _buildMessageList() {
    String senderID = _authService.getcurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessage(receiverID, senderID),
      builder: (context, snapshot) {
        //* errors
        if (snapshot.hasError) {
          return const Text("Error on chat Application");
        }

        //* loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading error on chat Application...");
        }

        //* return list view
        return ListView(
          children:
              snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
        );
      },
    );
  }

  //* Displaying Messsage in the UI
  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Text(data["message"]);
  }

  //* Sent Message Input
  Widget _buildMessageInput() {
    return Row(
      children: [
        Expanded(
          child: MyTextFeild(
            controller: _messageController,
            hintText: "Type your Message",
            obsuretext: false,
            icons: Icons.message_rounded,
          ),
        ),
        IconButton(
          onPressed: sendMessage,
          icon: const Icon(
            Icons.send_rounded,
          ),
        ),
      ],
    );
  }
}
