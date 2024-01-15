import 'package:flutter/material.dart';
import 'package:simplethread/src/frontend/compoents/my_appbar.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({
    super.key,
    required this.receiverEmail,
  });
  final String receiverEmail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: (receiverEmail),
      ),
    );
  }
}
