import 'package:app_cats/pages/home.dart';
import 'package:app_cats/services/providers/tab_provider.dart';
import 'package:app_cats/services/providers/theme_provider.dart';
import 'package:app_cats/services/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const AppCat());
}

class AppCat extends StatefulWidget {
  const AppCat({super.key});

  @override
  State<AppCat> createState() => _MyAppState();
}

class _MyAppState extends State<AppCat> {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TabProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData.light(
              useMaterial3: true,
            ),
            darkTheme: ThemeData.dark(
              useMaterial3: true,
            ),
            themeMode: themeProvider.theme,
            home: const TabLayout(),
          );
        },
      ),
    );
  }
}
