import 'package:flutter/material.dart';

class EmptyPage extends StatelessWidget {
  final String title;
  const EmptyPage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(title),
      ),
    );
  }
}
