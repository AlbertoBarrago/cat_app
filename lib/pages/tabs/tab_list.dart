import 'package:flutter/cupertino.dart';

class TabList extends StatelessWidget {
  const TabList({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(title),
    );
  }
}
