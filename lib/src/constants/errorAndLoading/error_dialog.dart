// dialog_utils.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void showErrorDialog(BuildContext context, String message, String title) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        title,
        style: GoogleFonts.roboto(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      content: Text(
        message,
        style: GoogleFonts.roboto(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.w400,
          fontSize: 18,
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('OK'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    ),
  );
}
