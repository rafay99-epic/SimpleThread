import 'package:flutter/material.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:simplethread/src/backend/services/auth/auth_gate.dart';
import 'package:simplethread/src/constants/animation/lottie_animation.dart';
import 'package:simplethread/src/constants/widget/appbar/my_appbar.dart';
import 'package:simplethread/src/constants/widget/buttons/my_button.dart';

class UpdateApplication extends StatelessWidget {
  UpdateApplication({super.key});
  final LottieAnimation lottieAnimation = LottieAnimation();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppBar(
          title: "Update Application",
          backbutton: false,
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 100),
                lottieAnimationFunction(context),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Row(
                    children: <Widget>[
                      MyButton(
                        text: "Update App Now",
                        onTap: () => applicationUpdate(),
                      ),
                      MyButton(
                        text: "Update App Later",
                        onTap: () => updateLater(context),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Widget lottieAnimationFunction(BuildContext context) {
    return Lottie.asset(
      lottieAnimation.updatePage,
    );
  }

  void applicationUpdate() async {
    await InAppUpdate.startFlexibleUpdate().then((_) {
      InAppUpdate.completeFlexibleUpdate();
    });
  }

  void updateLater(BuildContext context) {
    Navigator.pop(context);
    Navigator.pushReplacement(
      context,
      PageTransition(
        child: const AuthGate(),
        type: PageTransitionType.rightToLeftWithFade,
        duration: const Duration(seconds: 1, milliseconds: 50),
      ),
    );
  }
}
