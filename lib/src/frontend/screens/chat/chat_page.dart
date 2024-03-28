import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simplethread/src/backend/services/auth/auth_service.dart';
import 'package:simplethread/src/backend/services/chat/chat_service.dart';
import 'package:simplethread/src/frontend/widget/my_appbar.dart';
import 'package:simplethread/src/frontend/widget/my_textfeild.dart';

class ChatPage extends StatefulWidget {
  //Getting Data Variables
  final String receiverEmail;
  final String receiverID;

  //*loader for chat
  static const String _loader = "assets/animation/loader.json";
  //*For Empty Chat Screen
  static const String _emptyChat = "assets/images/empty_chat.svg";

  // getting  functions
  const ChatPage({
    super.key,
    required this.receiverID,
    required this.receiverEmail,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  //text Controller
  final TextEditingController _messageController = TextEditingController();

  //getting chat and auth services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  //for text feild focus
  FocusNode myFocusNode = FocusNode();

  // @override
  // void initState() {
  //   super.initState();
  //   myFocusNode.addListener(() {
  //     if (myFocusNode.hasFocus) {
  //       Future.delayed(const Duration(milliseconds: 500), () => scrollDown());
  //     }
  //   });

  //   Future.delayed(const Duration(milliseconds: 500), () => scrollDown());
  // }
  @override
  void initState() {
    super.initState();
    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        WidgetsBinding.instance.addPostFrameCallback((_) => scrollDown());
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => scrollDown());
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  //scroll controller
  final ScrollController _scrollController = ScrollController();
  // void scrollDown() {
  //   _scrollController.animateTo(
  //     _scrollController.position.maxScrollExtent,
  //     duration: const Duration(seconds: 1),
  //     curve: Curves.fastOutSlowIn,
  //   );
  // }
  void scrollDown() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
      );
    }
  }

  //* The main Widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: (widget.receiverEmail),
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
      await _chatService.sendMessage(
        widget.receiverID,
        _messageController.text,
      );
      _messageController.clear();
    }
    scrollDown();
  }

  //* building Message List between two users
  Widget _buildMessageList() {
    String senderID = _authService.getcurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessage(widget.receiverID, senderID),
      builder: (context, snapshot) {
        //* errors
        if (snapshot.hasError) {
          return const Text("Error on chat Application");
        }

        //* loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Lottie.asset(
              ChatPage._loader,
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
                controller: _scrollController,
                children: snapshot.data!.docs
                    .map((doc) => _buildMessageItem(doc))
                    .toList(),
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      ChatPage._emptyChat,
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
//  Orginal Code : Version 01: without seen Message
  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    String message = data["message"];
    String senderID = data["senderID"];
    bool isSender = senderID == _authService.getcurrentUser()!.uid;
    //Chat Bubble UI
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: isSender ? Colors.blueAccent : Colors.green,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  /* 
   ! Noting Changing the Value into the datastore:
   ! 1. Firebase is open. Need Acess Text Me. 
   ! 2. The orginal Code is V1, Don't delete it.Just comment it Plz. 
   ! 3. There are some values that I have commented out, in file chat_service.dart,
   !    message.dart.
   ! 4. Everything is the same. 
   *                        Good Luck 
  */

  // Version 04: Chaging the value into the database

  // Widget _buildMessageItem(DocumentSnapshot doc) {
  //   Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
  //   String message = data["message"];
  //   String senderID = data["senderID"];
  //   bool isRead = data["read"] ?? false;
  //   bool isSender = senderID == _authService.getcurrentUser()!.uid;

  //   return VisibilityDetector(
  //     key: Key(doc.id),
  //     onVisibilityChanged: (visibilityInfo) {
  //       var visiblePercentage = visibilityInfo.visibleFraction * 100;
  //       if (visiblePercentage == 100 && !isRead && isSender) {
  //         // Update the 'read' field in Firestore
  //         FirebaseFirestore.instance
  //             .collection("chat_rooms")
  //             .doc(
  //               ChatService.ch,
  //             ) // Assuming ChatService has a static property chatRoomId
  //             .collection("messages")
  //             .doc(doc.id)
  //             .update({'read': true});
  //       }
  //     },
  //     child: Column(
  //       crossAxisAlignment:
  //           isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
  //       children: [
  //         Align(
  //           alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
  //           child: Container(
  //             margin: const EdgeInsets.all(8.0),
  //             padding: const EdgeInsets.all(12.0),
  //             decoration: BoxDecoration(
  //               color: isSender ? Colors.blueAccent : Colors.green,
  //               borderRadius: BorderRadius.circular(8.0),
  //             ),
  //             child: Text(
  //               message,
  //               style: const TextStyle(color: Colors.white),
  //             ),
  //           ),
  //         ),
  //         if (isSender)
  //           Container(
  //             margin: const EdgeInsets.only(right: 8.0),
  //             child: Icon(
  //               Icons.check_rounded,
  //               color: isRead
  //                   ? Theme.of(context).colorScheme.secondary
  //                   : Theme.of(context).colorScheme.primary,
  //               size: 12.0,
  //             ),
  //           ),
  //       ],
  //     ),
  //   );
  // }

  //* Sent Message Input
  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: Row(
        children: [
          Expanded(
            child: MyTextFeild(
              controller: _messageController,
              hintText: "Type your Message",
              obsuretext: false,
              focusNode: myFocusNode,
              icons: Icons.message_rounded,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(50),
            ),
            margin: const EdgeInsets.only(right: 25),
            child: IconButton(
              onPressed: sendMessage,
              icon: const Icon(
                Icons.send_rounded,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
