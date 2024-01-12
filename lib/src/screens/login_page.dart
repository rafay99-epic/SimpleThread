import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:simplethread/src/compoents/my_button.dart';
import 'package:simplethread/src/compoents/my_textfeild.dart';

// ignore: camel_case_types
class login_page extends StatelessWidget {
  //email and Passwor Controller
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final String _animation = 'assets/animation/login_message.json';
  login_page({super.key, this.onTap});

  //login function
  void login() {}

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
            //logo
            Lottie.asset(
              _animation,
              width: 200,
              height: 200,
              fit: BoxFit.fill,
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
            ),
            const SizedBox(
              height: 10,
            ),
            //password TextFeild
            MyTextFeild(
              hintText: "Password",
              obsuretext: true,
              controller: _pwController,
            ),
            const SizedBox(
              height: 25,
            ),
            //login Button
            MyButton(
              text: "Login",
              onTap: login,
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
