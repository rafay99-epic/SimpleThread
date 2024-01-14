import 'package:flutter/material.dart';

import '../compoents/My_drawer.dart';
import '../compoents/my_appbar.dart';
// import 'package:simplethread/src/compoents/My_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static const String homerouter = '/home';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(
        title: 'Home',
        // icon: Icons.home_rounded,
      ),
      drawer: MyDrawer(),
    );
  }
}
