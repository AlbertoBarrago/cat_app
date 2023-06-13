import 'package:app_cats/auth/login_signup.dart';
import 'package:app_cats/pages/tabs/tab_cat.dart';
import 'package:app_cats/pages/tabs/tab_home.dart';
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
        return 'Welcome!';
      case 1:
        return 'Cat List';
      case 2:
        return 'Settings';
      default:
        return 'Welcome!';
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
              ? _buildTabContent(tabProvider.currentTab, userProvider.userName)
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
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.pets),
                label: 'Pets',
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

  void _onCollaboratePressed() {
    print('Collaborate button pressed');
  }

  Widget _buildTabContent(TabItem currentTab, username) {
    switch (currentTab) {
      case TabItem.tabCat:
        return const TabCat();
      case TabItem.tabHome:
        return  TabHome(username: username, onCollaboratePressed: _onCollaboratePressed);
      case TabItem.tabSettings:
        return const TabSettings(title : 'Tab Settings');
    }
  }
}