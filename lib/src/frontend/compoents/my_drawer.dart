import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import 'package:simplethread/src/backend/services/auth/auth_service.dart';
import 'package:simplethread/src/frontend/screens/home.dart';
import 'package:simplethread/src/frontend/screens/login_page.dart';
import 'package:simplethread/src/frontend/screens/setting_page.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({super.key});
  final String _animation = 'assets/animation/login_message.json';
  final _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              //Logo
              const SizedBox(
                height: 60,
              ),
              Lottie.asset(
                _animation,
                fit: BoxFit.fill,
                width: 100,
                height: 100,
              ),
              Text(
                'Simple Thread',
                style: GoogleFonts.playfairDisplay(
                  textStyle: TextStyle(
                    letterSpacing: .5,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),

              // Home Page Item Orginal Code with Reopening the Home Page
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  title: Text(
                    "H O M E",
                    style: GoogleFonts.playfairDisplay(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                  leading: const Icon(Icons.home_rounded),
                  onTap: () => {
                    //opening the Home Page by closing the drawer
                    Navigator.pop(context),
                    //Opening the Setting Page

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    ),
                  },
                ),
              ),

              //Setting Page Item
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  title: Text(
                    "S E T T I N G S",
                    style: GoogleFonts.playfairDisplay(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                  leading: const Icon(Icons.settings_rounded),
                  onTap: () => {
                    //Closing the drawer and opening the Setting Page
                    Navigator.pop(context),

                    //Opening the Setting Page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SettingPage(),
                      ),
                    ),
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0, bottom: 25.0),
            child: ListTile(
              title: Text(
                "L O G O U T",
                style: GoogleFonts.playfairDisplay(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  // fontWeight: FontWeight.bold,
                ),
              ),
              leading: const Icon(Icons.logout_rounded),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      title: Text(
                        'Logout',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      content: Text(
                        'Do you want to logout?',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: Text(
                            'Yes',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          onPressed: () {
                            _auth.signOut();

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => login_page(),
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
