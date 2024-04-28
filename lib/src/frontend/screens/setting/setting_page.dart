import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:simplethread/src/backend/services/auth/auth_service.dart';
import 'package:simplethread/src/backend/services/auth/login_or_register.dart';
import 'package:simplethread/src/frontend/screens/setting/widgets/change_password.dart';
import 'package:simplethread/src/frontend/screens/setting/widgets/delete_account.dart';
import 'package:simplethread/src/frontend/screens/setting/widgets/privacy.dart';
import 'package:simplethread/src/constants/widget/buttons/darkmodeswitch.dart';
import 'package:simplethread/src/constants/widget/appbar/my_appbar.dart';
import 'package:simplethread/src/frontend/screens/setting/widgets/ProfileUpdate.dart';
import 'package:simplethread/src/frontend/screens/setting/widgets/contact_page.dart';

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
            style: GoogleFonts.roboto(
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
    final _auth = AuthService();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: const MyAppBar(title: "Settings"),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: ListView(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(left: 20.0, right: 15.0),
              child: Text(
                'About',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            buildListTile(
              Icons.contact_mail,
              Colors.blue,
              'Feedback',
              ContactPage(),
              context,
            ),
            buildListTile(
              Icons.policy_sharp,
              Colors.purple,
              'Privacy Policy',
              const PrivacyPolicyPage(),
              context,
            ),
            //app version
            ListTile(
              leading: Icon(
                Icons.info,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: Text(
                'App Version',
                style: GoogleFonts.roboto(
                  textStyle: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              subtitle:
                  Text('2.0.0', style: TextStyle(color: Colors.grey[600])),
            ),

            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.only(left: 20.0, right: 15.0),
              child: Text(
                'App Setting',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            const ListTile(
              leading: Icon(
                Icons.dark_mode,
              ),
              title: DarkModeSwitch(),
              horizontalTitleGap: -6.0,
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
              Icons.password,
              Colors.blue,
              'Change Password',
              ChangePassword(),
              context,
            ),
            buildListTile(
              Icons.update,
              Colors.cyan,
              'App Update',
              ChangePassword(),
              context,
            ),
            ListTile(
              title: Row(
                children: <Widget>[
                  const Icon(
                    Icons.logout_rounded,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    "Logout",
                    style: GoogleFonts.roboto(
                      textStyle: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ],
              ),
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
                                builder: (context) => const LoginOrRegister(),
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
          ],
        ),
      ),
    );
  }
}
