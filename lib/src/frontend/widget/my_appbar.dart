import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  //parameters for the app bar
  final String title;
  final bool backbutton;
  const MyAppBar({
    super.key,
    required this.title,
    this.backbutton = true,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  //Build the app bar
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      automaticallyImplyLeading: backbutton,
      title: Text(
        title,
        style: GoogleFonts.roboto(
          textStyle: TextStyle(
            letterSpacing: .5,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      iconTheme: IconThemeData(
        color: Theme.of(context).colorScheme.inversePrimary,
      ),
    );
  }
}
