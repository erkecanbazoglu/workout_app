import 'package:workout_app/data/models/workout.dart';
import 'sample_exercises_test.dart' as sample_exercises;

///Sample Workouts for Test

List<Workout> workoutListTest = [
  Workout(
    id: 0,
    name: 'Workout 1',
    exercises: sample_exercises.exerciseListTest,
    difficulty: 80,
    duration: 100,
  ),
  Workout(
    id: 2,
    name: 'Workout 2',
    exercises: sample_exercises.exerciseListTest2,
    difficulty: 60,
    duration: 40,
  ),
];
