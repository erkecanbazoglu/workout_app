import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:workout_app/core/constants/sample_workouts.dart';
import 'package:workout_app/data/providers/workout_service.dart';
import 'package:mocktail/mocktail.dart';
import 'package:workout_app/data/repos/workout_repository.dart';
import 'package:workout_app/logic/bloc/workout_bloc.dart';
import 'package:workout_app/ui/screens/welcome_page.dart';
import 'package:workout_app/ui/screens/workout_list_page.dart';
import 'package:workout_app/ui/screens/workout_page.dart';
import 'package:bloc_test/bloc_test.dart';

class MockWorkoutService extends Mock implements WorkoutService {}

class MockWorkoutBloc extends MockBloc<WorkoutEvent, WorkoutState>
    implements WorkoutBloc {}

void main() {
  late WorkoutRepository sut;
  late MockWorkoutService mockWorkoutService;
  late WorkoutBloc workoutBloc;

  setUp(() {
    mockWorkoutService = MockWorkoutService();
    sut = WorkoutRepository(mockWorkoutService);
    workoutBloc = WorkoutBloc(sut);
  });

  //Arranging the result with 2 workouts returned
  void arrangeWorkoutServiceReturns2Workouts() {
    when(() => mockWorkoutService.getWorkouts()).thenAnswer(
      (_) async => workoutList,
    );
  }

  //Don't forget to provide mocked Launch Repository !!!
  Widget createWidgetUnderTest() {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WorkoutBloc>(
          create: (context) => WorkoutBloc(sut),
        ),
      ],
      child: MaterialApp(
        title: 'Workout App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: const WelcomePage(),
      ),
    );
  }

  group(
    "widget display in workout list page",
    () {
      testWidgets(
        "Workout List widget display",
        (WidgetTester tester) async {
          arrangeWorkoutServiceReturns2Workouts();

          await tester.pumpWidget(createWidgetUnderTest());

          await tester.pump(const Duration(milliseconds: 500));

          expect(find.text("Workout List"), findsOneWidget);
        },
      );
    },
  );
}
