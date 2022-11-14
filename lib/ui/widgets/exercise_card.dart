import 'package:flutter/material.dart';
import 'package:workout_app/core/constants/sample_workouts.dart';
import 'package:workout_app/core/constants/styles.dart';
import 'package:workout_app/data/models/exercise.dart';
import 'package:workout_app/ui/screens/exercise_page.dart';
import 'package:workout_app/ui/screens/workout_page.dart';

class ExerciseCard extends StatelessWidget {
  final Exercise exercise;
  final int index;
  final VoidCallback onTapDelete;
  final VoidCallback onTapNavigate;
  const ExerciseCard({
    Key? key,
    required this.exercise,
    required this.index,
    required this.onTapDelete,
    required this.onTapNavigate,
  }) : super(key: key);

  String getExerciseName(ExerciseType exercise) {
    switch (exercise) {
      case ExerciseType.barbellRow:
        return "Barbell Row";
      case ExerciseType.benchPress:
        return "Bench Press";
      case ExerciseType.shoulderPress:
        return "Shoulder Press";
      case ExerciseType.deadlift:
        return "Deadlift";
      case ExerciseType.squat:
        return "Squat";
      default:
        return "Empty";
    }
  }

  String getExerciseImage(ExerciseType exercise) {
    switch (exercise) {
      case ExerciseType.barbellRow:
        return 'assets/exercises/barbell-row.png';
      case ExerciseType.benchPress:
        return 'assets/exercises/bench-press.png';
      case ExerciseType.shoulderPress:
        return 'assets/exercises/shoulder-press.png';
      case ExerciseType.deadlift:
        return 'assets/exercises/deadlift.png';
      case ExerciseType.squat:
        return 'assets/exercises/squat.png';
      default:
        return 'assets/exercises/squat.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTapNavigate,
        leading: Container(
          height: 52,
          width: 52,
          decoration: BoxDecoration(
            borderRadius: kImageBorderRadius,
            image: DecorationImage(
              image: Image.asset(getExerciseImage(exercise.exercise)).image,
            ),
          ),
        ),
        title: Text(getExerciseName(exercise.exercise)),
        subtitle: const Text('Tap to edit your exercise'),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: onTapDelete,
        ),
      ),
    );
  }
}
