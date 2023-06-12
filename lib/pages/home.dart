import 'package:app_cats/pages/tabs/tab_cat.dart';
import 'package:app_cats/pages/tabs/tab_list.dart';
import 'package:app_cats/pages/tabs/tab_settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/providers/tab_provider.dart';
import '../services/settings/enum.dart';

class TabLayout extends StatelessWidget {
  const TabLayout({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the TabProvider instance using Provider.of<T>
    final tabProvider = Provider.of<TabProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tab Layout'),
      ),
      body: _buildTabContent(tabProvider.currentTab),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: tabProvider.currentTab.index,
        onTap: (index) {
          // Call the changeTab method to update the selected tab
          tabProvider.changeTab(TabItem.values[index]);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Cats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent(TabItem currentTab) {
    switch (currentTab) {
      case TabItem.tabCat:
        return const TabCat(title: 'Tab Cat');
      case TabItem.tabList:
        return const TabList(title: 'Tab List');
      case TabItem.tabSettings:
        return const TabSettings(title : 'Tab Settings');
    }
  }
}