// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:simplethread/src/backend/services/profile/profile.dart';
import 'package:simplethread/src/frontend/widget/customtextfeild2.dart';
import 'package:simplethread/src/frontend/widget/my_appbar.dart';
import 'package:simplethread/src/frontend/widget/snakbar.dart';

class ProfileUpdate extends StatefulWidget {
  const ProfileUpdate({Key? key}) : super(key: key);

  @override
  _ProfileUpdateState createState() => _ProfileUpdateState();
}

class _ProfileUpdateState extends State<ProfileUpdate> {
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final nameController = TextEditingController();
  ProfileService profileService = ProfileService();

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    final user = await profileService.getCurrentUser();

    if (user == null) {
      // Handle the case where the user is not logged in
      return;
    }

    try {
      final docSnapshot = await profileService.getUserData(user.uid);

      if (docSnapshot.exists) {
        final data = docSnapshot.data() as Map<String, dynamic>;

        emailController.text = data['email'] as String;
        phoneNumberController.text = data['phoneNumber'] as String;
        nameController.text = data['name'] as String;
      } else {
        // Handle the case where the user's data does not exist
      }
    } catch (e) {
      // Handle any errors
    }
  }

  void updateProfile() async {
    final user = await profileService.getCurrentUser();

    if (user == null) {
      const CustomSnackBar(
        contentText: 'Please create an account ',
      );
      return;
    }

    try {
      await profileService.updateUserData(
        user.uid,
        emailController.text,
        nameController.text,
        phoneNumberController.text,
      );
      const CustomSnackBar(
        contentText: 'Profile Updated Successfully',
      );
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: "Profile"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20.0),
            CustomTextField(
              labelText: 'Name',
              hintText: 'Enter your name',
              prefixIcon: Icons.person,
              controller: nameController,
            ),
            const SizedBox(height: 15.0),
            CustomTextField(
              labelText: 'Email',
              hintText: 'Enter your email',
              prefixIcon: Icons.email,
              controller: emailController,
            ),
            const SizedBox(height: 15.0),
            CustomTextField(
              labelText: 'Phone Number',
              hintText: 'Enter your phone number',
              prefixIcon: Icons.phone,
              controller: phoneNumberController,
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => updateProfile(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).colorScheme.inversePrimary,
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
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.1),
                  child: ElevatedButton(
                    onPressed: () => {Navigator.of(context).pop()},
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).colorScheme.inversePrimary,
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
