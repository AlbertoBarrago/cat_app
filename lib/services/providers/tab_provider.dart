import 'package:flutter/cupertino.dart';
import '../settings/enum.dart';

class TabProvider with ChangeNotifier {
  TabItem _currentTab = TabItem.tabCat;

  TabItem get currentTab => _currentTab;

  void changeTab(TabItem newTab) {
    _currentTab = newTab;
    notifyListeners();
  }
}