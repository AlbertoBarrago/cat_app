import 'package:flutter/cupertino.dart';

class UserProvider with ChangeNotifier {
  String userName = '';
  String userRole = '';
  bool isUserLoggedIn = false;

  get getUserName => userName;
  get getUserRole => userRole;
  get getIsUserLoggedIn => isUserLoggedIn;

  void setUser(String name, String role) {
    userName = name;
    userRole = role;
    isUserLoggedIn = true;
    notifyListeners();
  }

  void logout() {
    userName = '';
    userRole = '';
    isUserLoggedIn = false;
    notifyListeners();
  }
}