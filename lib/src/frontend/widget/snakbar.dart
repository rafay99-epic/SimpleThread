import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSnackBar extends StatelessWidget {
  final String contentText;
  final int durationSeconds;

  const CustomSnackBar({
    Key? key,
    required this.contentText,
    this.durationSeconds = 2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                backgroundColor: Theme.of(context).colorScheme.background,
                duration: Duration(seconds: durationSeconds),
                content: Text(
                  contentText,
                  style: GoogleFonts.roboto(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            );
          });

          return const SizedBox.shrink(); // Return an empty widget
        },
      ),
    );
  }
}
