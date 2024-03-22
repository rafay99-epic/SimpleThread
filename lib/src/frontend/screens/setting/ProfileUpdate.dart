import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:simplethread/src/frontend/widget/customtextfeild2.dart';
import 'package:simplethread/src/frontend/widget/my_appbar.dart';

class ProfileUpdate extends StatefulWidget {
  const ProfileUpdate({Key? key}) : super(key: key);

  @override
  _ProfileUpdateState createState() => _ProfileUpdateState();
}

class _ProfileUpdateState extends State<ProfileUpdate> {
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final nameController = TextEditingController();

  // @override
  // void initState() {
  //   super.initState();
  //   // TODO: Load user data from Firestore and set the controllers' values
  // }
  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId == null) {
      // Handle the case where the user is not logged in
      return;
    }

    try {
      final docSnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .get();

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
    // TODO: Update user data in Firestore with the controllers' values
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
            const SizedBox(height: 10.0),
            CustomTextField(
              labelText: 'Email',
              hintText: 'Enter your email',
              prefixIcon: Icons.email,
              controller: emailController,
            ),
            const SizedBox(height: 10.0),
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
                    onPressed: () => {},
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
