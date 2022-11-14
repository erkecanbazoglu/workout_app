import 'dart:math' as math;
import 'package:workout_app/data/models/workout.dart';
import 'package:workout_app/core/constants/sample_workouts.dart' as sample;

///Workout Service

class WorkoutService {
  ///Prepare the user workouts
  Future<List<Workout>> getWorkouts() async {
    ///Getting the workout

    await Future.delayed(const Duration(seconds: 2));

    List<Workout> tempWorkout = sample.workoutList;
    return tempWorkout;
  }

  ///Workout sent to the server
  Future<bool> _postWorkout({required Workout workout}) async {
    //Faking server delay
    await Future.delayed(const Duration(seconds: 2));

    // Simulate some network error
    final random = math.Random();
    if (random.nextBool()) {
      return false;
    }
    return true;
  }

  ///Post workouts to the server
  Future<bool> postWorkout({required Workout workout}) async {
    bool result = await _postWorkout(workout: workout);
    if (!result) {
      throw NetworkError();
    }
    return true;
  }
}

class NetworkError extends Error {}
