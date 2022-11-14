import 'package:flutter_test/flutter_test.dart';
import 'package:workout_app/data/providers/workout_service.dart';
import 'package:mocktail/mocktail.dart';
import 'package:workout_app/data/repos/workout_repository.dart';
import '../../core/constants/sample_workouts_test.dart';

class MockWorkoutService extends Mock implements WorkoutService {}

void main() {
  late WorkoutRepository sut;
  late MockWorkoutService mockWorkoutService;

  setUp(() {
    mockWorkoutService = MockWorkoutService();
    sut = WorkoutRepository(mockWorkoutService);
  });

  test(
    "initial values are correct",
    () {
      expect(sut.workouts, []);
    },
  );

  group(
    "getWorkouts \n",
    () {
      final workoutList = workoutListTest;

      //Arranging the result with 2 workouts returned
      void arrangeWorkoutServiceReturns2Workouts() {
        when(() => mockWorkoutService.getWorkouts()).thenAnswer(
          (_) async => workoutList,
        );
      }

      test(
        "gets workouts using the workout service",
        () async {
          arrangeWorkoutServiceReturns2Workouts();
          await sut.getWorkouts();
          verify(() => mockWorkoutService.getWorkouts()).called(1);
        },
      );

      test(
        """indicates loading of data,
        sets workouts to the ones from the service,
        indicates that data is not being loaded anymore""",
        () async {
          arrangeWorkoutServiceReturns2Workouts();
          final future = sut.getWorkouts();
          expect(sut.isLoading, true);
          await future;
          expect(sut.workouts, workoutList);
          expect(sut.isLoading, false);
        },
      );
    },
  );
}
