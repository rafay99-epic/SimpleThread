import 'package:flutter/material.dart';
import 'package:simplethread/src/compoents/my_appbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(
        title: 'Home',
        icon: Icons.home_rounded,
      ),
    );
  }
}
