// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import 'package:simplethread/src/backend/services/auth/auth_service.dart';
import 'package:simplethread/src/backend/services/chat/chat_service.dart';
import 'package:simplethread/src/frontend/compoents/my_appbar.dart';
import 'package:simplethread/src/frontend/compoents/my_drawer.dart';
import 'package:simplethread/src/frontend/compoents/user_title.dart';
import 'package:simplethread/src/frontend/screens/chat_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  //chat and Auth Services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: 'Home',
        // icon: Icons.home_rounded,
      ),
      drawer: MyDrawer(),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
      builder: (context, snapshot) {
        //error Handelling
        try {
          if (snapshot.hasError) {
            return const Text("Error");
          }
        } catch (e) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(
                e.toString(),
                style: GoogleFonts.playfairDisplay(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          );
        }

        //loading
        try {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        } catch (e) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(
                e.toString(),
                style: GoogleFonts.playfairDisplay(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          );
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
      stream: _chatService.getUserStream(),
    );
  }

  //build indivial list title for user
  Widget _builderUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    //display all user expect current user

    if (userData["email"] != _authService.getcurrentUser()!.email) {
      return UserTile(
        text: userData['name'],
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                receiverEmail: userData["name"],
                receiverID: userData["uid"],
              ),
            ),
          );
        },
      );
    } else {
      return Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/animation/nousers.json'),
              Text(
                'No User yet',
                style: GoogleFonts.playfairDisplay(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
