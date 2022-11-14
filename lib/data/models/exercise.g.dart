// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Exercise _$ExerciseFromJson(Map<String, dynamic> json) => Exercise(
      id: json['id'] as int,
      exercise: $enumDecode(_$ExerciseTypeEnumMap, json['exercise']),
      weight: json['weight'] as int,
      sets: (json['sets'] as List<dynamic>)
          .map((e) => (e as List<dynamic>).map((e) => e as int).toList())
          .toList(),
    );

Map<String, dynamic> _$ExerciseToJson(Exercise instance) => <String, dynamic>{
      'id': instance.id,
      'exercise': _$ExerciseTypeEnumMap[instance.exercise]!,
      'weight': instance.weight,
      'sets': instance.sets,
    };

const _$ExerciseTypeEnumMap = {
  ExerciseType.barbellRow: 'barbellRow',
  ExerciseType.benchPress: 'benchPress',
  ExerciseType.shoulderPress: 'shoulderPress',
  ExerciseType.deadlift: 'deadlift',
  ExerciseType.squat: 'squat',
};
