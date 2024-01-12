import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simplethread/src/compoents/my_button.dart';
import 'package:simplethread/src/compoents/my_textfeild.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _confirmPwController = TextEditingController();
  // final String _animation = "assets/animation/register.json";
  // final String _imageLogo = 'assets/images/register.png';
  RegisterPage({super.key, this.onTap});
  //register User
  void register() {}

  //on tap to redirect to login Page
  final void Function()? onTap;

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
              'Sign Up',
              style: GoogleFonts.playfairDisplay(
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
              onTap: register,
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
    );
  }
}
