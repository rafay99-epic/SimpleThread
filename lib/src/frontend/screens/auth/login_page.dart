// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simplethread/src/backend/services/auth/auth_service.dart';
import 'package:simplethread/src/frontend/screens/auth/verify_email.dart';
import 'package:simplethread/src/frontend/screens/chat/home.dart';
import 'package:simplethread/src/frontend/widget/my_button.dart';
import 'package:simplethread/src/frontend/widget/my_textfeild.dart';

// ignore: camel_case_types
class login_page extends StatelessWidget {
  //on tap register page
  final void Function()? onTap;

  //on tap forgot password page
  final void Function()? onForgotPassword;

  //email and Passwor Controller
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  login_page({super.key, this.onTap, this.onForgotPassword});

  //login function
  void login(BuildContext context) async {
    //get auth service
    final authiService = AuthService();

    //try login
    try {
      UserCredential userCredential = await authiService
          .signInWithEmailPassword(_emailController.text, _pwController.text);

      if (userCredential.user != null && userCredential.user!.emailVerified) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => VerifyEmail(),
          ),
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Login Failed"),
          content: Text(
            e.toString(),
            style: GoogleFonts.playfairDisplay(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'OK',
                style: GoogleFonts.playfairDisplay(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
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
              'Login',
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
              "Welcome Back, you've been missed",
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
            //password TextFeild
            MyTextFeild(
              hintText: "Password",
              obsuretext: true,
              controller: _pwController,
              icons: Icons.password_rounded,
            ),
            const SizedBox(
              height: 25,
            ),
            //login Button
            MyButton(
              text: "Login",
              onTap: () => login(context),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Forgot Your Password? ',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    )),
                GestureDetector(
                  onTap: onForgotPassword,
                  child: Text(
                    'Click here',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            //register Now Togo
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Not a member? ',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    )),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    'Register now',
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
