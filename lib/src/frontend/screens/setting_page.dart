import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../compoents/my_drawer.dart';
import '../compoents/darkmodeswitch.dart';
import '../compoents/my_appbar.dart';
import 'contact_page.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: const MyAppBar(title: "Settings"),
      drawer: const MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: ListView(
          children: <Widget>[
            const DarkModeSwitch(), // Use the DarkModeSwitch widget
            ListTile(
              title: Text(
                'Contact US',
                style: GoogleFonts.playfairDisplay(
                  textStyle: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ContactPage(),
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
