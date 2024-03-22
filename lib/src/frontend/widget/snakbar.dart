import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSnackBar extends StatelessWidget {
  final String contentText;

  final int durationSeconds;

  const CustomSnackBar({
    super.key,
    required this.contentText,
    this.durationSeconds = 2,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: Theme.of(context).colorScheme.background,
              showCloseIcon: true,
              duration: Duration(seconds: durationSeconds),
              closeIconColor: Colors.red,
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
    );
  }
}
