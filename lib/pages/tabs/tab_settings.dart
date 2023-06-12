import 'package:flutter/cupertino.dart';

class TabSettings extends StatelessWidget {
  const TabSettings({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(title),
    );
  }
}
