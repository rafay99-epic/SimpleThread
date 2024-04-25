// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simplethread/src/backend/services/profile/profile_update.dart';
import 'package:simplethread/src/constants/errorAndLoading/error_dialog.dart';
import 'package:simplethread/src/constants/widget/my_appbar.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  //----------------------------------
  //  Controllers & Services
  //----------------------------------
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  ProfileService profileService = ProfileService();

  //----------------------------------
  //  init Function
  //----------------------------------
  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  //----------------------------------
  //  Loading User Data
  //----------------------------------
  Future<void> loadUserData() async {
    final user = await _getCurrentUser();
    if (user == null) {
      _handleNoUserError();
      return;
    }

    try {
      final data = await _getUserData(user.uid);
      if (data != null) {
        _populateFields(data);
      } else {
        _handleNoUserDataError();
      }
    } catch (e) {
      _handleUnknownError(e);
    }
  }

  //----------------------------------
  //  Getting Current User
  //----------------------------------
  Future<User?> _getCurrentUser() async {
    try {
      return await profileService.getCurrentUser();
    } catch (e) {
      _handleUnknownError(e);
    }
    return null;
  }

  //----------------------------------
  //  Get user Data using UID
  //----------------------------------
  Future<Map<String, dynamic>?> _getUserData(String uid) async {
    try {
      final docSnapshot = await profileService.getUserData(uid);
      if (docSnapshot.exists) {
        return docSnapshot.data() as Map<String, dynamic>;
      }
    } catch (e) {
      _handleUnknownError(e);
    }
    return null;
  }

  //----------------------------------
  //  Populate Fields with data
  //----------------------------------
  void _populateFields(Map<String, dynamic> data) {
    setState(() {
      emailController.text = data['email'] as String;
      phoneNumberController.text = data['phoneNumber'] as String;
      nameController.text = data['name'] as String;
    });
  }

  //----------------------------------
  //  All the Error Handelling Methods
  //----------------------------------
  void _handleNoUserError() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "You need to have an account..Please Login",
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }

  void _handleNoUserDataError() {
    if (mounted) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            "Your Data Does not Exist, Please Create an account",
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      );
    }
  }

  void _handleUnknownError(error) {
    if (mounted) {
      showErrorDialog(context, error, "Error");
      // Handle any errors
    }
  }

  Widget buildField(
      String fieldName, IconData icon, TextEditingController controller) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(
          icon,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              fieldName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Text(
              controller.text,
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 22,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  //----------------------------------
  //  Build Function
  //----------------------------------
  @override
  Widget build(BuildContext context) {
    String firebaseImageUrl = "";
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
                height: 150,
                width: 150,
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
                    buildField('Name', Icons.person, nameController),
                    const SizedBox(height: 25.0),
                    buildField('Email', Icons.email, emailController),
                    const SizedBox(height: 25.0),
                    buildField(
                        'Phone Number', Icons.phone, phoneNumberController),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
