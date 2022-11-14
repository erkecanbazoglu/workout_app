part of 'workout_bloc.dart';

//States:
//WorkoutInitial
//WorkoutLoading
//WorkoutLoaded
//WorkoutError

abstract class WorkoutState extends Equatable {
  const WorkoutState();

  @override
  List<Object> get props => [];
}

class WorkoutInitial extends WorkoutState {}

class WorkoutLoading extends WorkoutState {
  const WorkoutLoading();

  @override
  List<Object> get props => [];
}

class WorkoutLoaded extends WorkoutState {
  final List<Workout> workoutList;
  const WorkoutLoaded(this.workoutList);

  @override
  List<Object> get props => [workoutList];
}

class WorkoutError extends WorkoutState {
  final String? message;
  const WorkoutError(this.message);

  @override
  List<Object> get props => [message!];
}
