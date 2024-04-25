// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:simplethread/src/backend/services/auth/auth_service.dart';
import 'package:simplethread/src/frontend/screens/auth/verify_email.dart';
import 'package:simplethread/src/constants/errorAndLoading/error_dialog.dart';

import 'package:simplethread/src/constants/widget/my_button.dart';
import 'package:simplethread/src/constants/widget/my_textfeild.dart';

class RegisterPage extends StatelessWidget {
  //-----------------------
  //- Controllers -
  //-----------------------
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  RegisterPage({Key? key, this.onTap}) : super(key: key);

  final void Function()? onTap;

  //-----------------------
  //- Build Widget -
  //-----------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: SingleChildScrollView(
          //-----------------------
          //- Form Widget -
          //-----------------------
          child: _buildRegistrationForm(context),
        ),
      ),
    );
  }

  //-----------------------
  //- Register User Form -
  //-----------------------
  Column _buildRegistrationForm(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //----------------------------
        //- All the Form Compoent -
        //----------------------------
        _buildIntroText(context),
        const SizedBox(height: 10),
        _buildWelcomeMessage(context),
        const SizedBox(height: 25),
        _buildEmailTextField(),
        const SizedBox(height: 10),
        _buildNameTextField(),
        const SizedBox(height: 10),
        _buildPhoneNumberTextField(),
        const SizedBox(height: 10),
        _buildPasswordTextField(),
        const SizedBox(height: 10),
        _buildConfirmPasswordTextField(),
        const SizedBox(height: 25),
        _buildRegisterButton(context),
        const SizedBox(height: 15),
        _buildLoginRedirect(context),
      ],
    );
  }

  //----------------------------
  //- All the Form Compoent -
  //  Intro Welcome
  //----------------------------
  Text _buildIntroText(BuildContext context) {
    return Text(
      'Sign Up',
      style: GoogleFonts.roboto(
        textStyle: TextStyle(
          letterSpacing: .5,
          fontSize: 42,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  //----------------------------
  //- All the Form Compoent -
  //  Welcome Message
  //----------------------------
  Text _buildWelcomeMessage(BuildContext context) {
    return Text(
      "Let's create an account for you",
      style: TextStyle(
        color: Theme.of(context).colorScheme.primary,
        fontSize: 16,
      ),
    );
  }

  //----------------------------
  //- All the Form Compoent -
  //----------------------------
  MyTextFeild _buildEmailTextField() {
    return MyTextFeild(
      hintText: "Email",
      obsuretext: false,
      controller: _emailController,
      icons: Icons.email_rounded,
    );
  }

  MyTextFeild _buildNameTextField() {
    return MyTextFeild(
      hintText: "Name",
      obsuretext: false,
      controller: _nameController,
      icons: Icons.person_rounded,
    );
  }

  MyTextFeild _buildPhoneNumberTextField() {
    return MyTextFeild(
      hintText: "Phone Number",
      obsuretext: false,
      controller: _phoneNumberController,
      icons: Icons.phone_rounded,
      isNumeric: true,
    );
  }

  MyTextFeild _buildPasswordTextField() {
    return MyTextFeild(
      hintText: "Password",
      obsuretext: true,
      controller: _passwordController,
      icons: Icons.password_rounded,
    );
  }

  MyTextFeild _buildConfirmPasswordTextField() {
    return MyTextFeild(
      hintText: "Confirm password",
      obsuretext: true,
      controller: _confirmPasswordController,
      icons: Icons.password_rounded,
    );
  }

  //----------------------------
  //- All the Form Compoent -
  //   Button for Register
  //----------------------------
  MyButton _buildRegisterButton(BuildContext context) {
    return MyButton(
      text: "Register",
      onTap: () => _registerUser(context),
    );
  }

  //----------------------------
  //- All the Form Compoent -
  //  Redirect to Login
  //----------------------------
  Row _buildLoginRedirect(BuildContext context) {
    return Row(
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
    );
  }

  //---------------------------------------
  //- Future Function for Register User
  //---------------------------------------
  Future<void> _registerUser(BuildContext context) async {
    //-----------------------
    //- Calling Auth Service
    //-----------------------
    final authService = AuthService();

    //---------------------------------------
    //- No Empty Feild
    //---------------------------------------
    if (_emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty ||
        _nameController.text.isEmpty ||
        _phoneNumberController.text.isEmpty) {
      showErrorDialog(context, "Please fill in all fields", "Error");
      return;
    }
    //-------------------
    //- Verify Password
    //-------------------
    if (_passwordController.text != _confirmPasswordController.text) {
      showErrorDialog(context, "Verify Password Is Not Matching", "Error");
      return;
    }
    //---------------------------------------
    //- Add User to Firebase
    //---------------------------------------
    try {
      await authService.signUpWithEmailPassword(
        _emailController.text,
        _passwordController.text,
        _nameController.text,
        _phoneNumberController.text,
        "",
      );

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const VerifyEmail(),
        ),
      );
    } catch (e) {
      showErrorDialog(context, e.toString(), "Error");
    }
  }
}
