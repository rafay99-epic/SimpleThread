import 'package:flutter/material.dart';
import 'package:simplethread/src/frontend/screens/auth/login_page.dart';
import 'package:simplethread/src/frontend/screens/auth/register_page.dart';
import 'package:simplethread/src/frontend/screens/auth/forgot_password.dart'; // import the ForgotPassword page

//version03:
class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({Key? key}) : super(key: key);

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool showLoginPage = true;
  bool showRegisterPage = false;
  bool showForgotPasswordPage = false;

  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
      showRegisterPage = !showRegisterPage;
    });
  }

  void showForgotPassword() {
    setState(() {
      showForgotPasswordPage = true;
      showLoginPage = false;
      showRegisterPage = false;
    });
  }

  void showLoginPage2() {
    setState(() {
      showLoginPage = true;
      showForgotPasswordPage = false;
      showRegisterPage = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: showForgotPasswordPage
            ? ForgotPassword(
                onTapLogin: showLoginPage2,
                onForgotPassword: () {
                  setState(() {
                    showForgotPasswordPage = false;
                    showLoginPage = true;
                  });
                },
              )
            : showLoginPage
                ? login_page(
                    onTap: togglePages,
                    onForgotPassword: showForgotPassword,
                  )
                : RegisterPage(
                    onTap: togglePages,
                  ),
        transitionBuilder: (child, animation) {
          final offsetAnimation = Tween(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          ));

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }
}
