// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:simplethread/src/backend/services/auth/auth_service.dart';
import 'package:simplethread/src/frontend/screens/auth/verify_email.dart';

import 'package:simplethread/src/frontend/widget/my_button.dart';
import 'package:simplethread/src/frontend/widget/my_textfeild.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _confirmPwController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  RegisterPage({super.key, this.onTap});
  //register User
  Future<void> register(BuildContext context) async {
    final _auth = AuthService();

    // pass match -> create User
    if (_pwController.text == _confirmPwController.text) {
      try {
        _auth.signUpWithEmailPassword(
          _emailController.text,
          _pwController.text,
          _nameController.text,
          _phoneNumberController.text,
        );

        // Navigate to VerifyEmail page
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const VerifyEmail(),
          ),
        );
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              e.toString(),
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            "Verify Password Is Not Matching",
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      );
    }
  }

  //on tap to redirect to login Page
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Intro text
              Text(
                'Sign Up',
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                    letterSpacing: .5,
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              //Welcome Back Messaage
              Text(
                "Let's create an account for you",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 25,
              ),

              //Email TextFeild
              MyTextFeild(
                hintText: "Email",
                obsuretext: false,
                controller: _emailController,
                icons: Icons.email_rounded,
              ),
              const SizedBox(
                height: 10,
              ),
              MyTextFeild(
                hintText: "Name",
                obsuretext: false,
                controller: _nameController,
                icons: Icons.person_rounded,
              ),
              const SizedBox(
                height: 10,
              ),
              MyTextFeild(
                hintText: "Phone Number",
                obsuretext: false,
                controller: _phoneNumberController,
                icons: Icons.phone_rounded,
                isNumeric: true,
              ),
              const SizedBox(
                height: 10,
              ),
              //password TextFeild
              MyTextFeild(
                hintText: "Password",
                obsuretext: true,
                controller: _pwController,
                icons: Icons.password_rounded,
              ),
              const SizedBox(
                height: 10,
              ),
              //Confirm password TextFeild
              MyTextFeild(
                hintText: "Confirm password",
                obsuretext: true,
                controller: _confirmPwController,
                icons: Icons.password_rounded,
              ),

              const SizedBox(
                height: 25,
              ),
              //login Button
              MyButton(
                text: "Register",
                onTap: () => register(context),
              ),
              const SizedBox(
                height: 15,
              ),
              //register Now Togo
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have an account? ',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      )),
                  GestureDetector(
                    onTap: onTap,
                    child: Text(
                      'Login now',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
