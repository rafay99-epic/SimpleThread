import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

import 'package:simplethread/src/frontend/widget/darkmodeswitch.dart';
import 'package:simplethread/src/frontend/widget/my_appbar.dart';
import 'package:simplethread/src/frontend/widget/my_drawer.dart';
import 'package:simplethread/src/frontend/screens/setting/ProfileUpdate.dart';
import 'package:simplethread/src/frontend/screens/setting/contact_page.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: const MyAppBar(title: "Settings"),
      drawer: MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: ListView(
          children: <Widget>[
            const ListTile(
              leading: Icon(
                Icons.dark_mode,
              ), // Add an icon next to the DarkModeSwitch
              title: DarkModeSwitch(), // Use the DarkModeSwitch widget
              horizontalTitleGap: -6.0,
            ),
            ListTile(
              title: Row(
                children: <Widget>[
                  const Icon(
                    Icons.contact_mail,
                  ),
                  const SizedBox(
                    width: 8.0,
                  ), // Add some spacing between the icon and the title
                  Text(
                    'Contact US',
                    style: GoogleFonts.playfairDisplay(
                      textStyle: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeftWithFade,
                    child: ContactPage(),
                    duration: const Duration(milliseconds: 200),
                  ),
                );
              },
            ),
            ListTile(
              title: Row(
                children: <Widget>[
                  const Icon(
                    Icons.person_3_sharp,
                  ),
                  const SizedBox(
                    width: 8.0,
                  ), // Add some spacing between the icon and the title
                  Text(
                    'Profile',
                    style: GoogleFonts.playfairDisplay(
                      textStyle: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType
                        .rightToLeftWithFade, // Fade transition from right to left
                    child: const ProfileUpdate(),
                    duration: const Duration(milliseconds: 200),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
