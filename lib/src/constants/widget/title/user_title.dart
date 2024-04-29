import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserTile extends StatelessWidget {
  const UserTile({
    super.key,
    required this.text,
    this.onTap,
    required this.profileImageURL,
  });
  final String text;
  final String profileImageURL;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double iconSpacing = screenWidth * 0.05;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        margin: EdgeInsets.symmetric(
          vertical: screenWidth * 0.02,
          horizontal: screenWidth * 0.04,
        ),
        padding: EdgeInsets.all(screenWidth * 0.03),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: (profileImageURL.isEmpty)
                  ? const AssetImage('assets/images/user.png') as ImageProvider
                  : NetworkImage(profileImageURL),
            ),
            SizedBox(
              width: iconSpacing,
            ),
            Text(
              text,
              style: GoogleFonts.roboto(
                letterSpacing: .5,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
