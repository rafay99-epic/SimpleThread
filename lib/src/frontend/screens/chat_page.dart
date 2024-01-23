import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '/src/backend/services/auth/auth_service.dart';
import '/src/backend/services/chat/chat_service.dart';
import '/src/frontend/compoents/my_appbar.dart';
import '/src/frontend/compoents/my_textfeild.dart';

class ChatPage extends StatelessWidget {
  //Getting Data Variables
  final String receiverEmail;
  final String receiverID;

  //*loader for chat
  static const String _loader = "animation/loader.json";
  //*For Empty Chat Screen
  static const String _emptyChat = "assets/images/empty_chat.svg";

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
          return Center(
            child: Lottie.asset(
              _loader,
              width: 150,
              height: 150,
              repeat: true,
              reverse: false,
            ),
          );
        }

        //* return list view
        return snapshot.hasData && snapshot.data!.docs.isNotEmpty
            ? ListView(
                children: snapshot.data!.docs
                    .map((doc) => _buildMessageItem(doc))
                    .toList(),
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      _emptyChat,
                      width: 300,
                      height: 300,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Begin Chat by saying Hi!",
                      style: GoogleFonts.playfairDisplay(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
              );
      },
    );
  }

  //* Displaying Messsage in the UI
  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    String message = data["message"];
    String senderID = data["senderID"];
    bool isSender = senderID == _authService.getcurrentUser()!.uid;

    return Align(
      alignment: isSender ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: isSender ? const Color.fromRGBO(54, 54, 54, 1) : Colors.green,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
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
