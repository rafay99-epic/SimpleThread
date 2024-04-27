import 'package:flutter/material.dart';

// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:simplethread/src/backend/services/auth/auth_service.dart';
import 'package:simplethread/src/backend/services/chat/chat_service.dart';
// import 'package:simplethread/src/frontend/screens/chat/show_user.dart';
import 'package:simplethread/src/constants/errorAndLoading/empty_screen.dart';
import 'package:simplethread/src/constants/errorAndLoading/error.dart';
import 'package:simplethread/src/constants/errorAndLoading/loading.dart';
import 'package:simplethread/src/constants/widget/my_appbar.dart';
import 'package:simplethread/src/constants/widget/user_title.dart';
import 'package:simplethread/src/frontend/screens/chat/chat_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  //chat and Auth Services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: 'Simple Thread',
        backbutton: false,
      ),
      body: _buildUserList(),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) => const ShowUser()),
      //     );
      //   },
      //   backgroundColor: Theme.of(context).colorScheme.background,
      //   foregroundColor: Theme.of(context).colorScheme.primary,
      //   child: const FaIcon(
      //     FontAwesomeIcons.message,
      //   ),
      // ),
    );
  }

  // Widget _buildUserList() {
  //   return StreamBuilder<Set<Map<String, dynamic>>>(
  //     stream: _chatService.getUserStreamMessage(),
  //     builder: (context, snapshot) {
  //       if (!snapshot.hasData) {
  //         return const Center(child: CircularProgressIndicator());
  //       }
  //       if (snapshot.hasError) {
  //         return Text('Error: ${snapshot.error}');
  //       }
  //       Set<Map<String, dynamic>> users = snapshot.data!;
  //       if (users.isEmpty) {
  //         return const Text('No users found');
  //       }
  //       return ListView.builder(
  //         itemCount: users.length,
  //         itemBuilder: (context, index) {
  //           return _builderUserListItem(users.elementAt(index), context);
  //         },
  //       );
  //     },
  //   );
  // }
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
