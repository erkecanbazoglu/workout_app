import 'package:flutter/material.dart';

class CustomProgressIndicator extends StatelessWidget {
  //Defining the key here for widget testing
  // @override
  // Key? get key => const Key("progress-indicator");

  const CustomProgressIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 60,
        width: 60,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: Colors.blueGrey,
        ),
      ),
    );
  }
}
