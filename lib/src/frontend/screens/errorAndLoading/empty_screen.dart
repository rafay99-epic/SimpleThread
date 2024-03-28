import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class NoDataFound extends StatelessWidget {
  const NoDataFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(
              left: 8.0, right: 8.0, top: 20.0, bottom: 20.0),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 10),
              Lottie.asset('assets/animation/datanotfound.json'),
              const SizedBox(height: 10),
              Text(
                "Sorry!! No search results found.",
                style: GoogleFonts.roboto(
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
