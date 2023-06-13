import 'package:flutter/cupertino.dart';
import '../settings/enum.dart';

class TabProvider with ChangeNotifier {
  TabItem _currentTab = TabItem.tabCat;
  String titleTab = 'Tab Cat';

  TabItem get currentTab => _currentTab;
  String get getTitleTab => titleTab;

  void changeTab(TabItem newTab, String title) {
    _currentTab = newTab;
    titleTab = title;
    notifyListeners();
  }
}