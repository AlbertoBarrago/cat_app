import 'package:flutter/cupertino.dart';

class TabCat extends StatelessWidget {
  const TabCat({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(title),
    );
  }
}