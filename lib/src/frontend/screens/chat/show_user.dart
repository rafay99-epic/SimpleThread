// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:simplethread/src/backend/services/auth/auth_service.dart';
import 'package:simplethread/src/backend/services/chat/chat_service.dart';
import 'package:simplethread/src/frontend/screens/chat/chat_page.dart';
import 'package:simplethread/src/constants/errorAndLoading/empty_screen.dart';
import 'package:simplethread/src/constants/errorAndLoading/error.dart';
import 'package:simplethread/src/constants/errorAndLoading/loading.dart';
import 'package:simplethread/src/constants/widget/my_appbar.dart';
import 'package:simplethread/src/constants/widget/user_title.dart';

class ShowUser extends StatefulWidget {
  const ShowUser({super.key});

  @override
  _ShowUserState createState() => _ShowUserState();
}

class _ShowUserState extends State<ShowUser> {
  //chat and Auth Services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "Contacts",
        backbutton: true,
        actionButtonEnabled: true,
        actionButtonVisible: true,
        actionButtonIcon: FontAwesomeIcons.search,
        onActionButtonPressed: () => {},
      ),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUserStream(),
      builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
        //error Handelling
        if (snapshot.hasError) {
          return const SingleChildScrollView(
            child: Center(
              child: ErrorScreen(),
            ),
          );
        }

        //loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        }

        // Check if there are any users
        if (snapshot.hasData && snapshot.data!.isEmpty) {
          return const NoDataFound();
        }

        //return list view
        return ListView(
          children: snapshot.data!
              .map<Widget>((userDate) => _builderUserListItem(
                    userDate,
                    context,
                  ))
              .toList(),
        );
      },
    );
  }

  //build indivial list title for user
  Widget _builderUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    if (userData["email"] != _authService.getcurrentUser()!.email) {
      return UserTile(
        text: userData['name'],
        profileImageURL: userData['photoUrl'],
        onTap: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => ChatPage(
                receiverEmail: userData["name"],
                receiverID: userData["uid"],
                profileImage: userData["photoUrl"],
              ),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                var begin = const Offset(1.0, 0.0);
                var end = Offset.zero;
                var tween = Tween(begin: begin, end: end);
                var offsetAnimation = animation.drive(tween);

                return SlideTransition(
                  position: offsetAnimation,
                  child: child,
                );
              },
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}
