part of 'workout_bloc.dart';

//Events:
//GetWorkouts
//AddWorkout
//UpdateWorkout
//DeleteWorkout

abstract class WorkoutEvent extends Equatable {
  const WorkoutEvent();

  @override
  List<Object> get props => [];
}

class GetWorkouts extends WorkoutEvent {
  const GetWorkouts();

  @override
  List<Object> get props => [];
}

class AddWorkout extends WorkoutEvent {
  final List<Workout> workoutList;
  final Workout workout;
  const AddWorkout(this.workout, this.workoutList);

  @override
  List<Object> get props => [workout, workoutList];
}

class UpdateWorkout extends WorkoutEvent {
  final List<Workout> workoutList;
  final Workout workout;
  final int workoutIndex;
  const UpdateWorkout(this.workout, this.workoutIndex, this.workoutList);

  @override
  List<Object> get props => [workout, workoutIndex, workoutList];
}

class DeleteWorkout extends WorkoutEvent {
  final List<Workout> workoutList;
  final Workout workout;
  const DeleteWorkout(this.workout, this.workoutList);

  @override
  List<Object> get props => [workout, workoutList];
}
