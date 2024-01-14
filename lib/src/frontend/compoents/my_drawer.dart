import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../backend/services/auth/auth_service.dart';
import '../screens/home.dart';
import '../screens/setting_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});
  final String _animation = 'assets/animation/login_message.json';

  //logout from the application
  void logout() {
    final _auth = AuthService();
    _auth.signOut();
  }

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
                  textStyle: const TextStyle(
                    letterSpacing: .5,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),

//Version -02:
              // Padding(
              //   padding: const EdgeInsets.only(left: 25.0),
              //   child: ListTile(
              //     title: Text(
              //       "H O M E",
              //       style: GoogleFonts.playfairDisplay(
              //         color: Colors.black,
              //         // fontWeight: FontWeight.bold,
              //       ),
              //     ),
              //     leading: const Icon(Icons.home_rounded),
              //     onTap: () {
              //       // Check if the current page is the HomePage
              //       if (ModalRoute.of(context)?.settings.name ==
              //           HomePage.homerouter) {
              //         // If it is, just close the drawer
              //         Navigator.pop(context);
              //       } else {
              //         // If it's not, close the drawer and navigate to the Home Page
              //         // Navigator.pop(context);
              //         // Navigator.pushReplacement(
              //         //   context,
              //         //   MaterialPageRoute(
              //         //     builder: (context) => const HomePage(),
              //         //   ),
              //         // );
              //       }
              //     },
              //   ),
              // ),

              //version-03
              // Padding(
              //   padding: const EdgeInsets.only(left: 25.0),
              //   child: ListTile(
              //     title: Text(
              //       "H O M E",
              //       style: GoogleFonts.playfairDisplay(
              //         color: Colors.black,
              //         // fontWeight: FontWeight.bold,
              //       ),
              //     ),
              //     leading: const Icon(Icons.home_rounded),
              //     onTap: () {
              //       // Check if the current page is an instance of HomePage
              //       if (ModalRoute.of(context)?.settings.arguments
              //           is HomePage) {
              //         // If it is, just close the drawer
              //         Navigator.pop(context);
              //       } else {
              //         // If it's not, close the drawer and navigate to the Home Page
              //         Navigator.pop(context);
              //         Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //             builder: (context) => const HomePage(),
              //           ),
              //         );
              //       }
              //     },
              //   ),
              // ),

//Version-01

              // Padding(
              //   padding: const EdgeInsets.only(left: 25.0),
              //   child: ListTile(
              //     title: Text(
              //       "H O M E",
              //       style: GoogleFonts.playfairDisplay(
              //         color: Colors.black,
              //         // fontWeight: FontWeight.bold,
              //       ),
              //     ),
              //     leading: const Icon(Icons.home_rounded),
              //     onTap: () {
              //       // Check if the current page is not the Home Page
              //       if (ModalRoute.of(context)?.settings.name !=
              //           HomePage.routeName) {
              //         // If not, close the drawer and navigate back to the Home Page
              //         Navigator.popUntil(context, (route) => route.isFirst);
              //       } else {
              //         // If the Home Page is already open, just close the drawer
              //         Navigator.pop(context);
              //       }
              //     },
              //   ),
              // ),

              // Home Page Item Orginal Code with Reopening the Home Page
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  title: Text(
                    "H O M E",
                    style: GoogleFonts.playfairDisplay(
                      color: Colors.black,
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
                        builder: (context) => const HomePage(),
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
                      color: Colors.black,
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
                  color: Colors.black,
                  // fontWeight: FontWeight.bold,
                ),
              ),
              leading: const Icon(Icons.logout_rounded),
              onTap: logout,
            ),
          ),
        ],
      ),
    );
  }
}
