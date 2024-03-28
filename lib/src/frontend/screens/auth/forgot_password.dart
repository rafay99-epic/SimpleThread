// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simplethread/src/backend/services/auth/auth_service.dart';
import 'package:simplethread/src/frontend/widget/my_button.dart';
import 'package:simplethread/src/frontend/widget/my_textfeild.dart';

// ignore: camel_case_types
class ForgotPassword extends StatelessWidget {
  //on tap register page
  final void Function()? onTapLogin;

  //on tap forgot password page
  final void Function() onForgotPassword;

  //email and Passwor Controller
  final TextEditingController _emailController = TextEditingController();

  ForgotPassword({super.key, this.onTapLogin, required this.onForgotPassword});

  //login function
  void forgetPassword(BuildContext context) async {
    //get auth service
    final authiService = AuthService();

    //try login
    try {
      if (_emailController.text.isNotEmpty) {
        //forget password
        authiService.sendPasswordResetEmail(_emailController.text);
        _emailController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: Theme.of(context).colorScheme.secondary,
            showCloseIcon: true,
            closeIconColor: Colors.red,
            content: Text(
              'Reset link has been sent to your email',
              style: GoogleFonts.roboto(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: Theme.of(context).colorScheme.secondary,
            showCloseIcon: true,
            duration: const Duration(seconds: 2),
            closeIconColor: Colors.red,
            content: Text(
              'Please enter your email',
              style: GoogleFonts.roboto(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        );
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            e.toString(),
            style: GoogleFonts.playfairDisplay(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Intro text
            Text(
              'Forgot Password',
              style: GoogleFonts.playfairDisplay(
                textStyle: TextStyle(
                  letterSpacing: .5,
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            //Welcome Back Messaage
            Text(
              "Please Enter your Email Address",
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

            MyButton(
              text: "Send Email",
              onTap: () => forgetPassword(context),
            ),
            const SizedBox(
              height: 10,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Remember your Password? ',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    )),
                GestureDetector(
                  onTap: onTapLogin,
                  child: Text(
                    'Go Back to Login',
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
    );
  }
}
