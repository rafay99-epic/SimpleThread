import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:simplethread/firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:simplethread/src/frontend/screens/internet_check/check_internet_page.dart';
import 'package:simplethread/src/constants/theme/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const CheckInternetPage(),
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
