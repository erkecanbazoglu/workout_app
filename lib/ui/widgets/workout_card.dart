import 'package:flutter/material.dart';
import 'package:workout_app/core/constants/styles.dart';
import 'package:workout_app/data/models/exercise.dart';
import 'package:workout_app/data/models/workout.dart';
import 'package:workout_app/ui/screens/workout_page.dart';

class WorkoutCard extends StatelessWidget {
  final Workout workout;
  final int index;
  final VoidCallback onTapDelete;
  final VoidCallback onTapNavigate;
  const WorkoutCard({
    Key? key,
    required this.workout,
    required this.index,
    required this.onTapDelete,
    required this.onTapNavigate,
  }) : super(key: key);

  String getWorkoutImage(Workout workout) {
    final exercise = workout.exercises[0].exercise;
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
              image: Image.asset(getWorkoutImage(workout)).image,
            ),
          ),
        ),
        title: Text(workout.name),
        subtitle: const Text('Tap to edit your workout'),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: onTapDelete,
        ),
      ),
    );
  }
}
