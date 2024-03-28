// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:simplethread/src/backend/services/delete/delete.dart';
import 'package:simplethread/src/frontend/widget/my_appbar.dart';

//------------------------------------
//  Delete User Auth and Data Screen
//------------------------------------
class DeleteProfile extends StatelessWidget {
  DeleteProfile({super.key});

  final delete_data = DeleteDataProfile();

  //----------------------------------
  //  Main Build Widget
  //----------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: "Delete Account"),
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
                  'assets/animation/delete.json',
                  width: 150,
                  height: 150,
                ),
              ),
              Text(
                'Delete Account',
                style: GoogleFonts.roboto(
                  letterSpacing: .5,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 35),
              Text(
                'Consequences of Deleting Your Account',
                style: GoogleFonts.roboto(
                  letterSpacing: .5,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 15),
              for (var item in [
                ' All chat will be deleted.',
                ' Your account history will be erased.',
                ' Your profile will no longer be visible to any of your friends.',
                ' You will be logged out from all devices.',
                ' Account recovery will not be possible.'
              ])
                Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          '• ',
                          style: GoogleFonts.roboto(
                            fontSize: 20,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            item,
                            style: GoogleFonts.roboto(
                              fontSize: 20,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              const SizedBox(height: 35),
              //----------------------------------
              //  Elevated Button
              //----------------------------------
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero),
                ),
                onPressed: () {
                  //----------------------------------
                  //  Delete Dialog Box
                  //----------------------------------
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text(
                            'Are you sure you want to delete your account?'),
                        content: const Icon(Icons.warning,
                            color: Colors.red, size: 40),
                        actions: <Widget>[
                          ElevatedButton(
                            child: const Text('No'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          ElevatedButton(
                            child: const Text('Yes'),
                            onPressed: () => delete_data.deleteAccount(context),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.warning, color: Colors.white),
                    SizedBox(width: 10),
                    Text(
                      'Deleted Account',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
