// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import 'package:simplethread/src/backend/services/profile/profile_update.dart';
import 'package:simplethread/src/frontend/widget/customtextfeild2.dart';
import 'package:simplethread/src/frontend/widget/my_appbar.dart';

class ProfileUpdate extends StatefulWidget {
  const ProfileUpdate({Key? key}) : super(key: key);

  @override
  _ProfileUpdateState createState() => _ProfileUpdateState();
}

class _ProfileUpdateState extends State<ProfileUpdate> {
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
    emailController.text = data['email'] as String;
    phoneNumberController.text = data['phoneNumber'] as String;
    nameController.text = data['name'] as String;
  }

  //----------------------------------
  //  All the Error Handelling Methods
  //----------------------------------
  void _handleNoUserError() {
    // Handle the case where the user is not logged in
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
    // Handle the case where the user's data does not exist
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

  void _handleUnknownError(dynamic error) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          error.toString(),
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
    // Handle any errors
  }

  //----------------------------------
  //  Calling Update Function
  //----------------------------------

  void updateProfile() async {
    FocusManager.instance.primaryFocus?.unfocus();

    final user = await profileService.getCurrentUser();
    if (user == null) {
      _showSnackBar('Please create an account');
      return;
    }

    final password = await _askPassword();
    if (password == null || password.isEmpty) {
      return;
    }

    try {
      await profileService.updateUserData(
        user.uid,
        emailController.text,
        nameController.text,
        phoneNumberController.text,
        password,
      );
      _showSnackBar('Profile Updated Successfully');
    } catch (e) {
      _showErrorDialog(e.toString());
    }

    passwordController.clear();
  }

  //----------------------------------
  //  Ask for Password Function
  //----------------------------------
  Future<String?> _askPassword() {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Enter Your Password",
            style: GoogleFonts.playfairDisplay(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: CustomTextField(
              labelText: 'Password Please',
              hintText: 'Password',
              prefixIcon: Icons.password_rounded,
              controller: passwordController,
              obsuretext: true,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(passwordController.text);
              },
            ),
          ],
        );
      },
    );
  }

  //----------------------------------
  //  SnakBar and Error Dialog
  //----------------------------------
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: GoogleFonts.roboto(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        behavior: SnackBarBehavior.floating,
        showCloseIcon: true,
        closeIconColor: Colors.red,
        backgroundColor: Theme.of(context).colorScheme.background,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          message,
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }

  //----------------------------------
  //  Build Function
  //----------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: "Update Profile"),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: MediaQuery.of(context).size.width * 0.05,
            right: MediaQuery.of(context).size.width * 0.05,
          ),
          child: Column(
            children: [
              Container(
                child: Lottie.asset(
                  'assets/animation/user.json',
                  width: 150,
                  height: 150,
                ),
              ),
              Text(
                'Profile Update',
                style: TextStyle(
                  letterSpacing: .5,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 35),
              CustomTextField(
                labelText: 'Email',
                hintText: 'Enter your email',
                prefixIcon: Icons.email,
                controller: emailController,
                enabled: false,
              ),
              const SizedBox(height: 25.0),
              CustomTextField(
                labelText: 'Name',
                hintText: 'Enter your name',
                prefixIcon: Icons.person,
                controller: nameController,
              ),
              const SizedBox(height: 25.0),
              CustomTextField(
                labelText: 'Phone Number',
                hintText: 'Enter your phone number',
                prefixIcon: Icons.phone,
                controller: phoneNumberController,
              ),
              const SizedBox(height: 25.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => updateProfile(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.background,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      'Update',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  ElevatedButton(
                    onPressed: () => {Navigator.of(context).pop()},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.background,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
