import 'package:app_cats/auth/login_signup.dart';
import 'package:app_cats/pages/tabs/tab_cat.dart';
import 'package:app_cats/pages/tabs/tab_dog.dart';
import 'package:app_cats/pages/tabs/tab_settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/providers/tab_provider.dart';
import '../services/providers/user_provider.dart';
import '../services/settings/enum.dart';

class TabLayout extends StatelessWidget {
  const TabLayout({super.key});

  String prepareTitleByIndex(int index) {
    switch (index) {
      case 0:
        return 'Tab Cat';
      case 1:
        return 'Tab List';
      case 2:
        return 'Tab Settings';
      default:
        return 'Tab Cat';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer2<TabProvider, UserProvider>(
        builder: (context, tabProvider, userProvider, child) {
          return userProvider.isUserLoggedIn
              ? Text(tabProvider.getTitleTab)
              : const Text('Welcome');
        },
        ),
      ),
      body: Consumer2<TabProvider, UserProvider>(
        builder: (context, tabProvider, userProvider, child) {
          return userProvider.isUserLoggedIn
              ? _buildTabContent(tabProvider.currentTab)
              : const LoginSignUp();
        },
      ),
      bottomNavigationBar: Consumer2<TabProvider, UserProvider>(
        builder: (context, tabProvider, userProvider, child) {
          return userProvider.isUserLoggedIn
              ? BottomNavigationBar(
            currentIndex: tabProvider.currentTab.index,
            onTap: (index) {
              tabProvider.changeTab(TabItem.values[index], prepareTitleByIndex(index));
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Cats',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.pets),
                label: 'List',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          ) : const Text('');
        },
      ),
    );
  }

  Widget _buildTabContent(TabItem currentTab) {
    switch (currentTab) {
      case TabItem.tabCat:
        return const TabCat(title: 'Cats ♥️');
      case TabItem.tabList:
        return const TabList(title: 'Tab List');
      case TabItem.tabSettings:
        return const TabSettings(title : 'Tab Settings');
    }
  }
}