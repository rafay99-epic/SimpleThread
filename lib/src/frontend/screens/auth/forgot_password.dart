import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:simplethread/src/backend/services/auth/auth_service.dart';
import 'package:simplethread/src/frontend/screens/errorAndLoading/error_dialog.dart';
import 'package:simplethread/src/frontend/widget/my_button.dart';
import 'package:simplethread/src/frontend/widget/my_textfeild.dart';

class ForgotPassword extends StatelessWidget {
  //-----------------------
  // Controllers & actions
  //-----------------------

  final void Function()? onTapLogin;
  final void Function() onForgotPassword;
  final TextEditingController _emailController = TextEditingController();

  ForgotPassword({Key? key, this.onTapLogin, required this.onForgotPassword})
      : super(key: key);

  //-----------------------
  // Build Widget
  //-----------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        //-----------------------
        // Login Redirect
        //-----------------------
        _buildLoginRedirect(context),
      ],
    );
  }

  //-----------------------
  // Form Components
  //-----------------------
  Text _buildIntroText(BuildContext context) {
    return Text(
      'Forgot Password',
      style: GoogleFonts.playfairDisplay(
        textStyle: TextStyle(
          letterSpacing: .5,
          fontSize: 42,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  Text _buildInstructionMessage(BuildContext context) {
    return Text(
      "Please Enter your Email Address",
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
    );
  }

  MyButton _buildSendEmailButton(BuildContext context) {
    return MyButton(
      text: "Send Email",
      onTap: () => _forgetPassword(context),
    );
  }

  Row _buildLoginRedirect(BuildContext context) {
    return Row(
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
    );
  }

  //-----------------------------
  // Future Function for forget
  //-----------------------------
  Future<void> _forgetPassword(BuildContext context) async {
    final authService = AuthService();

    if (_emailController.text.isNotEmpty) {
      try {
        await authService.sendPasswordResetEmail(_emailController.text);
        _emailController.clear();
        _showSnackBar(context, 'Reset link has been sent to your email');
      } catch (e) {
        showErrorDialog(context, e.toString(), "Error");
      }
    } else {
      _showSnackBar(context, 'Please enter your email');
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        showCloseIcon: true,
        closeIconColor: Colors.red,
        content: Text(
          message,
          style: GoogleFonts.roboto(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
