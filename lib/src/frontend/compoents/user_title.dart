import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserTile extends StatelessWidget {
  const UserTile({
    super.key,
    required this.text,
    this.onTap,
  });
  final String text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double iconSpacing = screenWidth * 0.05; // 5% of screen width

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        margin: EdgeInsets.symmetric(
          vertical: screenWidth * 0.03,
          horizontal: screenWidth * 0.04,
        ), // 3% vertical, 4% horizontal
        padding: EdgeInsets.all(screenWidth * 0.05), // 5% of screen width
        child: Row(
          children: [
            //icon
            const Icon(Icons.person_rounded),
            // adding Space
            SizedBox(
              width: iconSpacing,
            ),
            //username
            Text(
              text,
              style: GoogleFonts.playfairDisplay(
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

//  Orginal Code: No Media Queries

// @override
  // Widget build(BuildContext context) {
  //   return GestureDetector(
  //     onTap: onTap,
  //     child: Container(
  //       decoration: BoxDecoration(
  //         color: Theme.of(context).colorScheme.secondary,
  //         borderRadius: BorderRadius.circular(12),
  //       ),
  //       // margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 35),
  //       margin: const EdgeInsets.fromLTRB(15, 15, 15, 15),
  //       padding: const EdgeInsets.all(20),
  //       child: Row(
  //         children: [
  //           //icon
  //           const Icon(Icons.person_rounded),
  //           // adding Space
  //           const SizedBox(
  //             width: 20,
  //           ),
  //           //username
  //           Text(
  //             text,
  //             style: GoogleFonts.playfairDisplay(
  //               letterSpacing: .5,
  //               fontWeight: FontWeight.bold,
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
