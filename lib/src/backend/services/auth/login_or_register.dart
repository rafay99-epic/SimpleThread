import 'package:flutter/material.dart';
import 'package:simplethread/src/frontend/screens/login_page.dart';
import 'package:simplethread/src/frontend/screens/register_page.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({Key? key}) : super(key: key);

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool showLoginPage = true;

  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: showLoginPage
            ? login_page(
                onTap: togglePages,
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



//  ██████╗ ██████╗ ██╗ ██████╗ ██╗███╗   ██╗ █████╗ ██╗          ██████╗ ██████╗ ██████╗ ███████╗       ███╗   ██╗ ██████╗      █████╗ ███╗   ██╗██╗███╗   ███╗ █████╗ ████████╗██╗ ██████╗ ███╗   ██╗    
// ██╔═══██╗██╔══██╗██║██╔════╝ ██║████╗  ██║██╔══██╗██║         ██╔════╝██╔═══██╗██╔══██╗██╔════╝██╗    ████╗  ██║██╔═══██╗    ██╔══██╗████╗  ██║██║████╗ ████║██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║    
// ██║   ██║██████╔╝██║██║  ███╗██║██╔██╗ ██║███████║██║         ██║     ██║   ██║██║  ██║█████╗  ╚═╝    ██╔██╗ ██║██║   ██║    ███████║██╔██╗ ██║██║██╔████╔██║███████║   ██║   ██║██║   ██║██╔██╗ ██║    
// ██║   ██║██╔══██╗██║██║   ██║██║██║╚██╗██║██╔══██║██║         ██║     ██║   ██║██║  ██║██╔══╝  ██╗    ██║╚██╗██║██║   ██║    ██╔══██║██║╚██╗██║██║██║╚██╔╝██║██╔══██║   ██║   ██║██║   ██║██║╚██╗██║    
// ╚██████╔╝██║  ██║██║╚██████╔╝██║██║ ╚████║██║  ██║███████╗    ╚██████╗╚██████╔╝██████╔╝███████╗╚═╝    ██║ ╚████║╚██████╔╝    ██║  ██║██║ ╚████║██║██║ ╚═╝ ██║██║  ██║   ██║   ██║╚██████╔╝██║ ╚████║    
//  ╚═════╝ ╚═╝  ╚═╝╚═╝ ╚═════╝ ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝╚══════╝     ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝       ╚═╝  ╚═══╝ ╚═════╝     ╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝╚═╝     ╚═╝╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝    
                                                                                                                                                                                                        

// import 'package:flutter/material.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:simplethread/src/screens/login_page.dart';
// import 'package:simplethread/src/screens/register_page.dart';

// class LoginOrRegister extends StatefulWidget {
//   const LoginOrRegister({super.key});

//   @override
//   State<LoginOrRegister> createState() => _LoginOrRegisterState();
// }

// class _LoginOrRegisterState extends State<LoginOrRegister> {
//   bool showLoginPage = true;
//   void togglePages() {
//     setState(() {
//       showLoginPage = !showLoginPage;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (showLoginPage) {
//       return login_page(
//         onTap: togglePages,
//       );
//     } else {
//       return RegisterPage(
//         onTap: togglePages,
//         // PageTransition(
//         //   type: PageTransitionType.leftToRight,
//         //   child: RegisterPage(
//         //     onTap: togglePages,
//         //   ),
//         //),
//       );
//     }
//   }
// }