import 'package:workout_app/data/models/exercise.dart';

///Sample Exercises

List<Exercise> exerciseList = [
  Exercise(
    id: 0,
    exercise: ExerciseType.barbellRow,
    weight: 24,
    sets: [
      [14, 12, 10],
      [12, 10, 8],
      [10, 8, 6]
    ],
  ),
  Exercise(
    id: 1,
    exercise: ExerciseType.benchPress,
    weight: 44,
    sets: [
      [12, 10, 8],
      [10, 8, 6]
    ],
  ),
  Exercise(
    id: 2,
    exercise: ExerciseType.shoulderPress,
    weight: 32,
    sets: [
      [16, 14, 12],
      [14, 12, 10],
      [12, 10, 8],
      [10, 8, 6]
    ],
  ),
  Exercise(
    id: 3,
    exercise: ExerciseType.deadlift,
    weight: 120,
    sets: [
      [14, 12, 10],
      [12, 10, 8],
    ],
  ),
  Exercise(
    id: 4,
    exercise: ExerciseType.squat,
    weight: 60,
    sets: [
      [14, 12, 10],
      [12, 10, 8],
      [10, 8, 6]
    ],
  ),
];

List<Exercise> exerciseList2 = [
  Exercise(
    id: 0,
    exercise: ExerciseType.benchPress,
    weight: 44,
    sets: [
      [12, 10, 8],
      [10, 8, 6]
    ],
  ),
  Exercise(
    id: 1,
    exercise: ExerciseType.shoulderPress,
    weight: 32,
    sets: [
      [16, 14, 12],
      [14, 12, 10],
      [12, 10, 8],
      [10, 8, 6]
    ],
  ),
  Exercise(
    id: 2,
    exercise: ExerciseType.deadlift,
    weight: 120,
    sets: [
      [14, 12, 10],
      [12, 10, 8],
    ],
  ),
];
