import 'package:flutter/material.dart';
import 'package:workout_app/core/constants/styles.dart';

class ExerciseImage extends StatelessWidget {
  final int selectedExercise;
  final VoidCallback onTap;
  final int index;
  const ExerciseImage({
    Key? key,
    required this.selectedExercise,
    required this.onTap,
    required this.index,
  }) : super(key: key);

  String getExerciseImage(int index) {
    switch (index) {
      case 0:
        return 'assets/exercises/barbell-row.png';
      case 1:
        return 'assets/exercises/bench-press.png';
      case 2:
        return 'assets/exercises/shoulder-press.png';
      case 3:
        return 'assets/exercises/deadlift.png';
      case 4:
        return 'assets/exercises/squat.png';
      default:
        return 'assets/exercises/squat.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          borderRadius: kImageBorderRadius,
          border: Border.all(
            width: 1,
            color: selectedExercise == index ? Colors.blueAccent : Colors.white,
          ),
          image: DecorationImage(
            image: Image.asset(getExerciseImage(index)).image,
          ),
        ),
      ),
    );
  }
}
