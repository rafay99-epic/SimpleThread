// ignore_for_file: must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:simplethread/src/backend/services/auth/auth_service.dart';
import 'package:simplethread/src/backend/services/auth/login_or_register.dart';
import 'package:simplethread/src/constants/errorAndLoading/error_dialog.dart';
import 'package:simplethread/src/constants/errorAndLoading/snakbar.dart';
import 'package:simplethread/src/constants/widget/appbar/my_appbar.dart';
import 'package:simplethread/src/constants/widget/buttons/my_button.dart';
import 'package:simplethread/src/constants/widget/textfeild/my_textfeild.dart';

class ChangePassword extends StatelessWidget {
  //-----------------------
  // Controllers & actions
  //-----------------------
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
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
      body: Center(
        child: SingleChildScrollView(
          //-----------------------
          // Forget Password Form
          //-----------------------
          child: _buildForgotPasswordForm(context),
        ),
      ),
    );
  }

  //------------------------------
  // Forget Password Form Widget
  //------------------------------
  Column _buildForgotPasswordForm(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //-----------------------
        // Intro Text
        //-----------------------
        _buildIntroText(context),
        const SizedBox(height: 10),
        //-----------------------
        // Instruction Message
        //-----------------------
        _buildInstructionMessage(context),
        const SizedBox(height: 25),
        //-----------------------
        // Email TextFeild
        //-----------------------
        _buildEmailTextField(),
        const SizedBox(height: 10),
        //-----------------------
        // Send Email Button
        //-----------------------
        _buildSendEmailButton(context),
        const SizedBox(height: 10),
      ],
    );
  }

  //-----------------------
  // Form Components
  //-----------------------
  Text _buildIntroText(BuildContext context) {
    return Text(
      'Change Password',
      style: TextStyle(
        letterSpacing: .5,
        fontSize: 42,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.primary,
      ),
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

  //-----------------------------
  // Future Function for forget
  //-----------------------------
  Future<void> _changePassword(BuildContext context) async {
    final authService = AuthService();
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
