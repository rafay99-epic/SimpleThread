import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class snakbar {
  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        showCloseIcon: true,
        closeIconColor: Colors.red,
        content: Text(
          message,
          style: GoogleFonts.roboto(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
