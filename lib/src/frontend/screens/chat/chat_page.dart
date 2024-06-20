import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simplethread/src/backend/services/auth/auth_service.dart';
import 'package:simplethread/src/backend/services/chat/chat_service.dart';
import 'package:simplethread/src/constants/animation/lottie_animation.dart';
import 'package:simplethread/src/constants/errorAndLoading/error.dart';
import 'package:simplethread/src/constants/errorAndLoading/loading.dart';

class ChatPage extends StatefulWidget {
  //Getting Data Variables
  final String receiverEmail;
  final String receiverID;
  final String profileImage;

  const ChatPage({
    super.key,
    required this.receiverID,
    required this.receiverEmail,
    required this.profileImage,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final LottieAnimation animation = LottieAnimation();
  //text Controller
  final TextEditingController _messageController = TextEditingController();
  bool _showEmojiPicker = false;

  //getting chat and auth services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  //for text feild focus
  FocusNode myFocusNode = FocusNode();

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

  void toggleEmojiPicker() {
    setState(() {
      _showEmojiPicker = !_showEmojiPicker;
    });
  }

  void onEmojiSelected(Category? category, Emoji emoji) {
    _messageController.text += emoji.emoji;
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  //scroll controller
  final ScrollController _scrollController = ScrollController();

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
      appBar: AppBar(
        title: Text(
          widget.receiverEmail,
          style: TextStyle(
            letterSpacing: .5,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: CircleAvatar(
            backgroundImage: (widget.profileImage.isEmpty)
                ? const AssetImage("assets/images/user.png") as ImageProvider
                : NetworkImage(widget.profileImage),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  //* sending a message function
  void sendMessage() async {
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
          return const SingleChildScrollView(
            child: Center(
              child: ErrorScreen(),
            ),
          );
        }

        //* loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
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
                      animation.emptyChat,
                      width: 300,
                      height: 300,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Begin Chat by saying Hi!",
                      style: TextStyle(
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

  //* Sent Message Input
  Widget _buildMessageInput() {
    return Column(
      children: [
        if (_showEmojiPicker)
          EmojiPicker(
            onEmojiSelected: onEmojiSelected,
            config: const Config(
              height: 200,
              swapCategoryAndBottomBar: true,
            ),
          ),
        Padding(
          padding: const EdgeInsets.only(bottom: 25.0),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 14),
                  child: TextField(
                    controller: _messageController,
                    focusNode: myFocusNode,
                    obscureText: false,
                    style: const TextStyle(fontSize: 16.0),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      fillColor: Theme.of(context).colorScheme.secondary,
                      filled: true,
                      hintText: "Type your Message",
                      hintStyle: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(_showEmojiPicker
                            ? Icons.keyboard
                            : Icons.emoji_emotions),
                        onPressed: toggleEmojiPicker,
                      ),
                    ),
                  ),
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
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
