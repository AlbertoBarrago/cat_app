import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeState = ThemeMode.system;

  ThemeMode get theme => _themeState;

  void changeTheme(ThemeMode theme) {
    _themeState = theme;
    notifyListeners();
  }
}