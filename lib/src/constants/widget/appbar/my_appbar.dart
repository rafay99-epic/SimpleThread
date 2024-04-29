// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
//   //parameters for the app bar
//   final String title;
//   final bool backbutton;
//   const MyAppBar({
//     super.key,
//     required this.title,
//     this.backbutton = true,
//   });

//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);

//   //Build the app bar
//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       centerTitle: false,
//       automaticallyImplyLeading: backbutton,
//       title: Text(
//         title,
//         style: GoogleFonts.roboto(
//           textStyle: TextStyle(
//             letterSpacing: .5,
//             fontWeight: FontWeight.bold,
//             color: Theme.of(context).colorScheme.primary,
//           ),
//         ),
//       ),
//       backgroundColor: Theme.of(context).colorScheme.background,
//       iconTheme: IconThemeData(
//         color: Theme.of(context).colorScheme.inversePrimary,
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool backbutton;
  final bool actionButtonVisible;
  final bool actionButtonEnabled;
  final VoidCallback? onActionButtonPressed;
  final IconData? actionButtonIcon;

  const MyAppBar({
    Key? key,
    required this.title,
    this.backbutton = false,
    this.actionButtonVisible = false,
    this.actionButtonEnabled = false,
    this.onActionButtonPressed,
    this.actionButtonIcon,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
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
      actions: actionButtonVisible
          ? [
              IconButton(
                icon: FaIcon(
                  actionButtonIcon,
                  color: Theme.of(context).colorScheme.primary,
                ),
                onPressed: actionButtonEnabled ? onActionButtonPressed : null,
              ),
            ]
          : null,
    );
  }
}
