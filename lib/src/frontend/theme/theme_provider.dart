import 'package:flutter/material.dart';
import 'package:simplethread/src/frontend/theme/dark_mode.dart';
import 'package:simplethread/src/frontend/theme/light_mode.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkMode;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    if (isDarkMode) {
      themeData = lightMode;
    } else {
      themeData = darkMode;
    }
    notifyListeners();
  }
}
