import 'package:json_annotation/json_annotation.dart';

part 'exercise.g.dart';

///Exercise MODEL

enum ExerciseType {
  barbellRow,
  benchPress,
  shoulderPress,
  deadlift,
  squat,
}

@JsonSerializable()
class Exercise {
  final int id;
  ExerciseType exercise;
  int weight;
  List<List<int>> sets;

  Exercise({
    required this.id,
    required this.exercise,
    required this.weight,
    required this.sets,
  });

  /// Connect the generated [_$ExerciseFromJson] function to the `fromJson`
  /// factory.
  factory Exercise.fromJson(Map<String, dynamic> json) =>
      _$ExerciseFromJson(json);

  /// Connect the generated [_$ExerciseToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ExerciseToJson(this);

  @override
  Exercise copyWith({required Exercise exercise}) => Exercise(
        id: exercise.id,
        exercise: exercise.exercise,
        weight: exercise.weight,
        sets: exercise.sets,
      );

  @override
  String toString() =>
      'Exercise: {id: $id, exercise: $exercise, weight: $weight, sets: $sets}';
}
