import 'package:app_cats/pages/home.dart';
import 'package:app_cats/services/providers/tab_provider.dart';
import 'package:app_cats/services/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TabProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          cupertinoOverrideTheme: const CupertinoThemeData(
            brightness: Brightness.light,
          ),
        ),
        home: const TabLayout(),
      ),
    ),
  );
}
