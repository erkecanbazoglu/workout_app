import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:workout_app/core/constants/sample_workouts.dart';
import 'package:workout_app/data/models/workout.dart';
import 'package:workout_app/data/repos/workout_repository.dart';
import '../../data/providers/workout_service.dart';

part 'workout_event.dart';
part 'workout_state.dart';

class WorkoutBloc extends HydratedBloc<WorkoutEvent, WorkoutState> {
  final WorkoutRepository? workoutRepo;
  WorkoutBloc(this.workoutRepo) : super(WorkoutInitial()) {
    on<GetWorkouts>(_onGetWorkouts);
    on<AddWorkout>(_onAddWorkout);
    on<UpdateWorkout>(_onUpdateWorkout);
    on<DeleteWorkout>(_onDeleteWorkout);
  }

  ///Get Workout Event

  Future<void> _onGetWorkouts(
      GetWorkouts event, Emitter<WorkoutState> emit) async {
    emit(const WorkoutLoading());
    try {
      final workoutList = await workoutRepo?.getWorkouts();
      emit(WorkoutLoaded(workoutList!));
    } on NetworkError catch (e) {
      emit(const WorkoutError("Error loading the workout!"));
    } catch (e) {
      emit(const WorkoutError("Error loading the workout!"));
    }
  }

  ///Add Workout Event

  Future<void> _onAddWorkout(
      AddWorkout event, Emitter<WorkoutState> emit) async {
    emit(const WorkoutLoading());
    List<Workout> workoutList = event.workoutList;
    workoutList.add(event.workout);
    emit(WorkoutLoaded(workoutList));
  }

  ///Update Workout Event

  Future<void> _onUpdateWorkout(
      UpdateWorkout event, Emitter<WorkoutState> emit) async {
    emit(const WorkoutLoading());
    List<Workout> workoutList = event.workoutList;
    workoutList[event.workoutIndex] = event.workout;
    emit(WorkoutLoaded(workoutList));
  }

  ///Delete Workout Event

  Future<void> _onDeleteWorkout(
      DeleteWorkout event, Emitter<WorkoutState> emit) async {
    emit(const WorkoutLoading());
    List<Workout> workoutList = event.workoutList;
    workoutList.remove(event.workout);
    emit(WorkoutLoaded(workoutList));
  }

  @override
  WorkoutState? fromJson(Map<String, dynamic> json) {
    try {
      dynamic workouts = Workouts.fromJson(json);
      //To make workouts null
      // final workouts = null;

      //To add another workout
      // List<Workout> workouts = [];
      // workouts.add(workoutList[0]);
      // workouts.add(workoutList[1]);
      // print(workouts);
      if (workouts == null) {
        final tempWorkoutList = workoutList;
        return WorkoutLoaded(tempWorkoutList);
        // print("workouts: null");
      } else {
        return WorkoutLoaded(workouts.workouts);
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(WorkoutState state) {
    if (state is WorkoutLoaded) {
      //Creating Workouts object to turn into json
      Workouts workouts = Workouts(workouts: state.workoutList);
      return workouts.toJson();
    } else {
      return null;
    }
  }
}
