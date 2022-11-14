import 'package:workout_app/data/models/exercise.dart';
import 'package:json_annotation/json_annotation.dart';

part 'workout.g.dart';

///Workout MODEL

//Set "explicitToJson: true" for nested objects
@JsonSerializable(explicitToJson: true)
class Workout {
  final int id;
  String name;
  List<Exercise> exercises;
  int difficulty; //out of 1.0
  int duration; //in minutes

  Workout({
    required this.id,
    required this.name,
    required this.exercises,
    required this.difficulty,
    required this.duration,
  });

  /// Connect the generated [_$WorkoutFromJson] function to the `fromJson`
  /// factory.
  factory Workout.fromJson(Map<String, dynamic> json) =>
      _$WorkoutFromJson(json);

  /// Connect the generated [_$WorkoutToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$WorkoutToJson(this);

  @override
  Workout copyWith({required Workout workout}) => Workout(
        id: workout.id,
        name: workout.name,
        exercises: workout.exercises,
        difficulty: workout.difficulty,
        duration: workout.duration,
      );

  @override
  String toString() =>
      'Workout: {id: $id, name: $name, exercises: $exercises, difficulty: $difficulty, duration: $duration}';
}

///Workouts MODEL

@JsonSerializable(explicitToJson: true)
class Workouts {
  final List<Workout> workouts;

  Workouts({
    required this.workouts,
  });

  /// Connect the generated [_$WorkoutsFromJson] function to the `fromJson`
  /// factory.
  factory Workouts.fromJson(Map<String, dynamic> json) =>
      _$WorkoutsFromJson(json);

  /// Connect the generated [_$WorkoutsToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$WorkoutsToJson(this);

  @override
  String toString() => 'Workouts: {workouts: $workouts}';
}
