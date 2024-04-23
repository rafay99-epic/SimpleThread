// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:simplethread/src/backend/services/auth/auth_service.dart';
import 'package:simplethread/src/backend/services/auth/login_or_register.dart';
import 'package:simplethread/src/frontend/screens/home/bottom_navbar.dart';
import 'package:simplethread/src/constants/widget/my_appbar.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  //----------------------------------
  //  Controller and Variables
  //----------------------------------
  final _auth = AuthService();
  bool _isButtonDisabled = true;
  Timer? _timer;

  //----------------------------------
  //  init Function: timmer
  //----------------------------------
  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(
      const Duration(seconds: 3),
      (timer) async {
        if (await _auth.isEmailVerified()) {
          timer.cancel();
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const Navbar(),
            ),
          );
        }
      },
    );

    Timer(const Duration(minutes: 1, seconds: 30), () {
      if (mounted) {
        setState(() {
          _isButtonDisabled = false;
        });
      }
    });
  }

  //----------------------------------
  //  Dispose Function: timmer
  //----------------------------------
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  //----------------------------------
  //  Build Widget Function
  //----------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: "Verify Email",
        backbutton: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: MediaQuery.of(context).size.width * 0.05,
            right: MediaQuery.of(context).size.width * 0.05,
          ),
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Center(
                    child: Lottie.asset(
                  'assets/animation/verfication_email.json',
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.width * 0.5,
                )),
                Column(
                  children: <Widget>[
                    Text(
                      "Please Verify Your Email Address",
                      style: GoogleFonts.roboto(
                        letterSpacing: .5,
                        fontSize: 22,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Text(
                      "Check your email address for the verification link. If you didn't receive the email, please click the resend button.",
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.roboto(
                        letterSpacing: .5,
                        fontSize: 17,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      icon: FaIcon(
                        FontAwesomeIcons.lock,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      label: Text(
                        'Login',
                        style: GoogleFonts.roboto(
                          letterSpacing: .5,
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      onPressed: () {
                        _auth.signOut();
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const LoginOrRegister(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                          side: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.height * 0.01,
                    ),
                    ElevatedButton.icon(
                      icon: FaIcon(
                        FontAwesomeIcons.envelope,
                        color: _isButtonDisabled
                            ? Colors.grey
                            : Theme.of(context).colorScheme.primary,
                      ),
                      label: Text(
                        'Resend',
                        style: GoogleFonts.roboto(
                          letterSpacing: .5,
                          fontSize: 20,
                          color: _isButtonDisabled
                              ? Colors.grey
                              : Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      onPressed: _isButtonDisabled
                          ? null
                          : () {
                              setState(() {
                                _isButtonDisabled = true;
                              });
                              _auth.sendVerificationEmail();

                              Timer(const Duration(minutes: 1, seconds: 30),
                                  () {
                                setState(() {
                                  _isButtonDisabled = false;
                                });
                              });
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isButtonDisabled
                            ? Colors.grey[300]
                            : Theme.of(context).colorScheme.secondary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                          side: BorderSide(
                            color: _isButtonDisabled
                                ? Colors.grey
                                : Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
