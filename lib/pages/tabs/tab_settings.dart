import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/providers/tab_provider.dart';
import '../../services/providers/theme_provider.dart';
import '../../services/providers/user_provider.dart';
import '../../services/settings/const.dart';
import '../../services/settings/enum.dart';

class TabSettings extends StatefulWidget {
  const TabSettings({super.key});

  @override
  State<TabSettings> createState() => _TabSettingsState();
}

class _TabSettingsState extends State<TabSettings> {
  bool isDarkTheme = false;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final tabProvider = Provider.of<TabProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SwitchListTile(
            title: const Text('Dark Theme'),
            value: themeProvider.theme == ThemeMode.dark,
            onChanged: (value) {
              setState(() {
                isDarkTheme = value; // Update the theme state
                themeProvider
                    .changeTheme(value ? ThemeMode.dark : ThemeMode.light);
              });
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              userProvider.logout();
              tabProvider.changeTab(TabItem.tabHome, 'Welcome!');
            },
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(10.0),
        color: Colors.grey[200],
        child: const Text(
          version,
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}
