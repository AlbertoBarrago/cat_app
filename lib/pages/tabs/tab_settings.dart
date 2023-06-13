import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/providers/tab_provider.dart';
import '../../services/providers/user_provider.dart';
import '../../services/settings/enum.dart';

class TabSettings extends StatelessWidget {
  const TabSettings({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final tabProvider = Provider.of<TabProvider>(context);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              userProvider.logout();
              tabProvider.changeTab(TabItem.tabCat, 'Tab Cat');
            },
          ),
        ],
      ),
    );
  }
}
