import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

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
