import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeState = ThemeMode.light;

  ThemeMode get theme => _themeState;

  isDarkModeOn() {
    return _themeState == ThemeMode.dark;
  }

  void changeTheme(ThemeMode theme) {
    _themeState = theme;
    notifyListeners();
  }
}