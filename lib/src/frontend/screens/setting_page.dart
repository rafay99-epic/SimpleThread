import 'package:flutter/material.dart';

import '../compoents/My_drawer.dart';
import '../compoents/my_appbar.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(title: "Settings"),
      drawer: MyDrawer(),
    );
  }
}
