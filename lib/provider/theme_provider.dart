import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }

  bool isDarkMode(Brightness platformBrightness) {
    if (_themeMode == ThemeMode.system) {
      return platformBrightness == Brightness.dark;
    }
    return _themeMode == ThemeMode.dark;
  }
}

// import 'package:flutter/material.dart';

// class ThemeProvider with ChangeNotifier {
//   ThemeMode _themeMode = ThemeMode.system;

//   ThemeMode get themeMode => _themeMode;

//   void setThemeMode(ThemeMode mode) {
//     _themeMode = mode;
//     notifyListeners();
//   }

//   bool get isDarkMode => _themeMode == ThemeMode.dark;
// }

// class ThemeProvider extends ChangeNotifier {
//   bool isDarkModeOn = false;

//   void toggleTheme() {
//     isDarkModeOn = !isDarkModeOn;
//     notifyListeners();
//   }
// }
