import 'package:workout_app/core/constants/sample_workouts.dart' as sample;
import 'package:workout_app/data/models/workout.dart';
import 'package:workout_app/data/providers/workout_service.dart';

///Workout Repo

class WorkoutRepository {
  WorkoutService _workoutService;
  WorkoutRepository(this._workoutService);

  List<Workout> _workouts = [];

  List<Workout> get workouts => _workouts;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  ///Prepare the user workouts
  Future<List<Workout>> getWorkouts() async {
    ///Getting the workout
    _isLoading = true;

    _workouts = await _workoutService.getWorkouts();

    _isLoading = false;

    return _workouts;
  }
}
