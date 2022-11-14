import 'package:workout_app/core/constants/sample_exercises.dart'
    as sample_exercises;
import 'package:workout_app/data/models/workout.dart';

///Sample Workouts

List<Workout> workoutList = [
  Workout(
    id: 0,
    name: 'Workout 1',
    exercises: sample_exercises.exerciseList,
    difficulty: 80,
    duration: 100,
  ),
  Workout(
    id: 2,
    name: 'Workout 2',
    exercises: sample_exercises.exerciseList2,
    difficulty: 60,
    duration: 40,
  ),
];
