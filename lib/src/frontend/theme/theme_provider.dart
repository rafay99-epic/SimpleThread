import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:simplethread/src/frontend/theme/dark_mode.dart';
import 'package:simplethread/src/frontend/theme/light_mode.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData;

  ThemeProvider() : _themeData = lightMode {
    _loadTheme();
  }

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkMode;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    _saveTheme(themeData == darkMode);
    notifyListeners();
  }

  void toggleTheme() {
    themeData = isDarkMode ? lightMode : darkMode;
  }

  _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDarkMode = prefs.getBool('isDarkMode') ?? false;
    _themeData = isDarkMode ? darkMode : lightMode;
    notifyListeners();
  }

  _saveTheme(bool isDarkMode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode);
  }
}


//  Orginal Code: Version: 01

// import 'package:flutter/material.dart';
// import 'package:simplethread/src/frontend/theme/dark_mode.dart';
// import 'package:simplethread/src/frontend/theme/light_mode.dart';

// class ThemeProvider extends ChangeNotifier {
//   ThemeData _themeData = lightMode;

//   ThemeData get themeData => _themeData;

//   bool get isDarkMode => _themeData == darkMode;

//   set themeData(ThemeData themeData) {
//     _themeData = themeData;
//     notifyListeners();
//   }

//   void toggleTheme() {
//     if (isDarkMode) {
//       themeData = lightMode;
//     } else {
//       themeData = darkMode;
//     }
//     notifyListeners();
//   }
// }
