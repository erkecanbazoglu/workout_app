import 'package:flutter/material.dart';

class SetsCard extends StatelessWidget {
  final List<int> set;
  final int index;
  final VoidCallback onTap;
  const SetsCard({
    Key? key,
    required this.set,
    required this.index,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text("Set ${index + 1} - ${set.toString()}"),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: onTap,
        ),
      ),
    );
  }
}
