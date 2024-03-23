// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:simplethread/src/frontend/screens/setting/delete_account.dart';

// import 'package:simplethread/src/frontend/widget/darkmodeswitch.dart';
// import 'package:simplethread/src/frontend/widget/my_appbar.dart';
// import 'package:simplethread/src/frontend/widget/my_drawer.dart';
// import 'package:simplethread/src/frontend/screens/setting/ProfileUpdate.dart';
// import 'package:simplethread/src/frontend/screens/setting/contact_page.dart';

// class SettingPage extends StatelessWidget {
//   const SettingPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).colorScheme.background,
//       appBar: const MyAppBar(title: "Settings"),
//       drawer: MyDrawer(),
//       body: Padding(
//         padding: const EdgeInsets.only(top: 20.0),
//         child: ListView(
//           children: <Widget>[
//             const ListTile(
//               leading: Icon(
//                 Icons.dark_mode,
//               ),
//               title: DarkModeSwitch(),
//               horizontalTitleGap: -6.0,
//             ),
//             ListTile(
//               title: Row(
//                 children: <Widget>[
//                   const Icon(
//                     Icons.contact_mail,
//                     color: Colors.blue,
//                   ),
//                   const SizedBox(
//                     width: 8.0,
//                   ),
//                   Text(
//                     'Contact US',
//                     style: GoogleFonts.playfairDisplay(
//                       textStyle: Theme.of(context).textTheme.titleLarge,
//                     ),
//                   ),
//                 ],
//               ),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   PageTransition(
//                     type: PageTransitionType.rightToLeftWithFade,
//                     child: ContactPage(),
//                     duration: const Duration(milliseconds: 200),
//                   ),
//                 );
//               },
//             ),
//             ListTile(
//               title: Row(
//                 children: <Widget>[
//                   const Icon(
//                     Icons.person_3_sharp,
//                     color: Colors.green,
//                   ),
//                   const SizedBox(
//                     width: 8.0,
//                   ),
//                   Text(
//                     'Profile',
//                     style: GoogleFonts.playfairDisplay(
//                       textStyle: Theme.of(context).textTheme.titleLarge,
//                     ),
//                   ),
//                 ],
//               ),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   PageTransition(
//                     type: PageTransitionType.rightToLeftWithFade,
//                     child: const ProfileUpdate(),
//                     duration: const Duration(milliseconds: 200),
//                   ),
//                 );
//               },
//             ),
//             ListTile(
//               title: Row(
//                 children: <Widget>[
//                   const Icon(
//                     Icons.delete_sweep,
//                     color: Colors.red,
//                   ),
//                   const SizedBox(
//                     width: 8.0,
//                   ),
//                   Text(
//                     'Delete Profile',
//                     style: GoogleFonts.playfairDisplay(
//                       textStyle: Theme.of(context).textTheme.titleLarge,
//                     ),
//                   ),
//                 ],
//               ),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   PageTransition(
//                     type: PageTransitionType.rightToLeftWithFade,
//                     child: const DeleteProfile(),
//                     duration: const Duration(milliseconds: 200),
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:simplethread/src/frontend/screens/setting/delete_account.dart';
import 'package:simplethread/src/frontend/screens/setting/privacy.dart';

import 'package:simplethread/src/frontend/widget/darkmodeswitch.dart';
import 'package:simplethread/src/frontend/widget/my_appbar.dart';
import 'package:simplethread/src/frontend/widget/my_drawer.dart';
import 'package:simplethread/src/frontend/screens/setting/ProfileUpdate.dart';
import 'package:simplethread/src/frontend/screens/setting/contact_page.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  ListTile buildListTile(IconData icon, Color color, String text, Widget page,
      BuildContext context) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(
            icon,
            color: color,
          ),
          const SizedBox(
            width: 8.0,
          ),
          Text(
            text,
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
            child: page,
            duration: const Duration(milliseconds: 200),
          ),
        );
      },
    );
  }

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
              ),
              title: DarkModeSwitch(),
              horizontalTitleGap: -6.0,
            ),
            buildListTile(
              Icons.contact_mail,
              Colors.blue,
              'Contact US',
              ContactPage(),
              context,
            ),
            buildListTile(
              Icons.person_3_sharp,
              Colors.green,
              'Profile',
              const ProfileUpdate(),
              context,
            ),
            buildListTile(
              Icons.delete_sweep,
              Colors.red,
              'Delete Profile',
              DeleteProfile(),
              context,
            ),
            buildListTile(
              Icons.policy_sharp,
              Colors.purple,
              'Privacy Policy',
              const PrivacyPolicyPage(),
              context,
            ),
          ],
        ),
      ),
    );
  }
}
