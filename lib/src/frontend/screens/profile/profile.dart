// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, file_names

import 'package:flutter/material.dart';
import 'package:simplethread/src/backend/class/user_data.dart';
import 'package:simplethread/src/backend/services/profile/profile_fetch.dart';
import 'package:simplethread/src/constants/errorAndLoading/error.dart';
import 'package:simplethread/src/constants/errorAndLoading/loading.dart';
import 'package:simplethread/src/constants/widget/appbar/my_appbar.dart';
import 'package:simplethread/src/constants/widget/textfeild/profile_textfield.dart';

// ignore: must_be_immutable
class Profile extends StatelessWidget {
  Profile({Key? key}) : super(key: key);

  ProfileProvider profileProvider = ProfileProvider();

  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  String firebaseImageUrl = "";

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserData>(
      future: profileProvider.loadUserData(),
      builder: (BuildContext context, AsyncSnapshot<UserData> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else if (snapshot.hasError) {
          return const SingleChildScrollView(
            child: Center(
              child: ErrorScreen(),
            ),
          );
        } else {
          final data = snapshot.data!;
          emailController.text = data.email;
          phoneNumberController.text = data.phoneNumber;
          nameController.text = data.name;
          firebaseImageUrl = data.photoUrl;
          return Scaffold(
            appBar: const MyAppBar(title: "Profile"),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                  left: MediaQuery.of(context).size.width * 0.05,
                  right: MediaQuery.of(context).size.width * 0.05,
                ),
                child: Column(
                  children: [
                    //Profile Image
                    const SizedBox(height: 30),
                    Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: (firebaseImageUrl.isEmpty)
                              ? const AssetImage("assets/images/user.png")
                                  as ImageProvider
                              : NetworkImage(firebaseImageUrl),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: Column(
                        children: <Widget>[
                          buildField(
                              'Name', Icons.person, nameController, context),
                          const SizedBox(height: 25.0),
                          buildField(
                              'Email', Icons.email, emailController, context),
                          const SizedBox(height: 25.0),
                          buildField('Phone Number', Icons.phone,
                              phoneNumberController, context),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
