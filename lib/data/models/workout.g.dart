// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Workout _$WorkoutFromJson(Map<String, dynamic> json) => Workout(
      id: json['id'] as int,
      name: json['name'] as String,
      exercises: (json['exercises'] as List<dynamic>)
          .map((e) => Exercise.fromJson(e as Map<String, dynamic>))
          .toList(),
      difficulty: json['difficulty'] as int,
      duration: json['duration'] as int,
    );

Map<String, dynamic> _$WorkoutToJson(Workout instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'exercises': instance.exercises.map((e) => e.toJson()).toList(),
      'difficulty': instance.difficulty,
      'duration': instance.duration,
    };

Workouts _$WorkoutsFromJson(Map<String, dynamic> json) => Workouts(
      workouts: (json['workouts'] as List<dynamic>)
          .map((e) => Workout.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WorkoutsToJson(Workouts instance) => <String, dynamic>{
      'workouts': instance.workouts.map((e) => e.toJson()).toList(),
    };
