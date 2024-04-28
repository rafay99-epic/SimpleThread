// ignore_for_file: must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:simplethread/src/backend/services/auth/auth_service.dart';
import 'package:simplethread/src/backend/services/auth/login_or_register.dart';
import 'package:simplethread/src/constants/animation/lottie_animation.dart';
import 'package:simplethread/src/constants/errorAndLoading/error_dialog.dart';
import 'package:simplethread/src/constants/errorAndLoading/snakbar.dart';
import 'package:simplethread/src/constants/widget/appbar/my_appbar.dart';
import 'package:simplethread/src/constants/widget/buttons/my_button.dart';
import 'package:simplethread/src/constants/widget/textfeild/my_textfeild.dart';

class ChangePassword extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final LottieAnimation lottieAnimation = LottieAnimation();
  final authService = AuthService();
  String userEmail = "";

  snakbar snakebar = snakbar();

  ChangePassword({
    Key? key,
  }) : super(key: key);

  //-----------------------
  // Build Widget
  //-----------------------
  @override
  Widget build(BuildContext context) {
    userEmail = _auth.currentUser!.email!;
    _emailController.text = userEmail;
    return Scaffold(
      appBar: const MyAppBar(
        title: "Change Password",
        backbutton: true,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: buildChangePasswordForm(context),
      ),
    );
  }

  Column buildChangePasswordForm(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 40),
        lottieAnimationFunction(context),
        const SizedBox(height: 10),
        _buildInstructionMessage(context),
        const SizedBox(height: 25),
        _buildEmailTextField(),
        const SizedBox(height: 10),
        _buildSendEmailButton(context),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget lottieAnimationFunction(BuildContext context) {
    return Lottie.asset(
      lottieAnimation.changePassword,
      // width: 200,
      // height: 200,
      // fit: BoxFit.fill,
    );
  }

  Text _buildInstructionMessage(BuildContext context) {
    return Text(
      "Password reset email sent",
      style: TextStyle(
        color: Theme.of(context).colorScheme.primary,
        fontSize: 16,
      ),
    );
  }

  MyTextFeild _buildEmailTextField() {
    return MyTextFeild(
      hintText: "Email",
      obsuretext: false,
      controller: _emailController,
      icons: Icons.email_rounded,
      isEnabled: false,
    );
  }

  MyButton _buildSendEmailButton(BuildContext context) {
    return MyButton(
      text: "Send Email",
      onTap: () => _changePassword(context),
    );
  }

  Future<void> _changePassword(BuildContext context) async {
    if (_emailController.text.isNotEmpty) {
      try {
        await authService.sendPasswordResetEmail(_emailController.text);
        snakebar.showSnackBar(
            context, 'Password Reset Email Sent, Please Check Your Email');
        await Future.delayed(const Duration(seconds: 7));
        authService.signOut();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginOrRegister(),
          ),
        );
        showErrorDialog(
            context,
            "Password Changed, Please Login with the New Password",
            "Password Reset");
      } catch (e) {
        showErrorDialog(context, e.toString(), "Error");
      }
    } else {
      snakebar.showSnackBar(context, 'Please enter your email');
    }
  }
}
