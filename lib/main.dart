import 'package:app_cats/pages/home.dart';
import 'package:app_cats/services/providers/tab_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => TabProvider(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: TabLayout(),
      ),
    ),
  );
}