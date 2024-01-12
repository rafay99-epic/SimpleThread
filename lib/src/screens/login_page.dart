import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simplethread/src/auth/auth_service.dart';
import 'package:simplethread/src/compoents/my_button.dart';
import 'package:simplethread/src/compoents/my_textfeild.dart';

// ignore: camel_case_types
class login_page extends StatelessWidget {
  //email and Passwor Controller
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  login_page({super.key, this.onTap});

  //login function
  void login(BuildContext context) async {
    //get auth service
    final authiService = AuthService();

    //try login
    try {
      await authiService.signInWithEmailPassword(
        _emailController.text,
        _pwController.text,
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
        ),
      );
    }

    //catch error
  }

  //on tap register page
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
