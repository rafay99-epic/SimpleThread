// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simplethread/src/backend/services/auth/auth_service.dart';
import 'package:simplethread/src/backend/services/auth/login_or_register.dart';
import 'package:simplethread/src/frontend/screens/chat/home.dart';
import 'package:simplethread/src/frontend/widget/my_appbar.dart';

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
  bool _isButtonDisabled = false;
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
              builder: (context) => HomePage(),
            ),
          );
        }
      },
    );
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
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              Center(
                child: FaIcon(
                  FontAwesomeIcons.envelopeOpenText,
                  size: MediaQuery.of(context).size.width * 0.3,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Center(
                child: Text(
                  "Please Verify Your Email Address",
                  style: GoogleFonts.playfairDisplay(
                    letterSpacing: .5,
                    fontSize: 25,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.arrow_back),
                  TextButton(
                    child: Text(
                      'Back to Login',
                      style: GoogleFonts.playfairDisplay(
                        letterSpacing: .5,
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    onPressed: () => {
                      _auth.signOut(),
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const LoginOrRegister(),
                        ),
                      ),
                    },
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.arrow_back),
                  TextButton(
                    onPressed: _isButtonDisabled
                        ? null
                        : () {
                            setState(() {
                              _isButtonDisabled = true;
                            });
                            _auth.sendVerificationEmail();

                            Timer(const Duration(minutes: 1, seconds: 30), () {
                              setState(() {
                                _isButtonDisabled = false;
                              });
                            });
                          },
                    child: Text(
                      'Resend Confirm Email',
                      style: GoogleFonts.playfairDisplay(
                        letterSpacing: .5,
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
