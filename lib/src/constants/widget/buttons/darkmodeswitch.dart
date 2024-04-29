import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:simplethread/src/constants/theme/theme_provider.dart';

class DarkModeSwitch extends StatelessWidget {
  const DarkModeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(
        'Dark Mode',
        style: GoogleFonts.roboto(
          textStyle: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      value: Provider.of<ThemeProvider>(context).isDarkMode,
      onChanged: (bool value) {
        Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
      },
    );
  }
}
