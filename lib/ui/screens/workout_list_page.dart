import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_app/data/models/workout.dart';
import 'package:workout_app/logic/bloc/workout_bloc.dart';
import 'package:workout_app/ui/screens/workout_page.dart';
import 'package:workout_app/ui/widgets/custom_progress_indicator.dart';
import 'package:workout_app/ui/widgets/workout_card.dart';

class WorkoutListPage extends StatefulWidget {
  const WorkoutListPage({Key? key}) : super(key: key);

  @override
  State<WorkoutListPage> createState() => _WorkoutListPageState();
}

class _WorkoutListPageState extends State<WorkoutListPage> {
  final ScrollController _customScrollViewController = ScrollController();
  List<Workout> theWorkoutList = [];
  late final _workoutBloc;

  @override
  void initState() {
    super.initState();
    _workoutBloc = BlocProvider.of<WorkoutBloc>(context);
    // _workoutBloc.add(const GetWorkouts());
    if (_workoutBloc.state is WorkoutLoaded) {
      theWorkoutList = _workoutBloc.state.workoutList;
    } else if (_workoutBloc.state is WorkoutInitial) {
      _workoutBloc.add(const GetWorkouts());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Workout List",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        controller: _customScrollViewController,
        slivers: <Widget>[
          //BlocBuilder-SliverBuilderDelegate Problem
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 5,
            ),
          ),
          BlocConsumer<WorkoutBloc, WorkoutState>(
            listener: (context, state) {
              if (state is WorkoutLoaded) {
                setState(() {
                  theWorkoutList = state.workoutList;
                });
              }
            },
            builder: (context, state) {
              if (state is WorkoutLoaded) {
                return SliverList(
                  key: const Key("workout-list-key"),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final workout = state.workoutList[index];
                      return WorkoutCard(
                        workout: workout,
                        index: index,
                        onTapDelete: () => _workoutBloc.add(DeleteWorkout(
                            state.workoutList[index], state.workoutList)),
                        onTapNavigate: () async {
                          dynamic result = await Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (_) => WorkoutPage(
                                      workout: workout,
                                      index: index,
                                      isNewWorkout: false,
                                    )),
                          );
                          if (result != null) {
                            _workoutBloc.add(UpdateWorkout(
                                result, index, state.workoutList));
                          }
                        },
                      );
                    },
                    childCount: state.workoutList.length,
                  ),
                );
                //The Error State
              } else if (state is WorkoutError) {
                return SliverToBoxAdapter(
                  child: Text(
                    state.message!,
                  ),
                );
              } else {
                //The Loading State
                return const SliverToBoxAdapter(
                  child: Center(
                      child: CustomProgressIndicator(
                    key: Key("progress-indicator"),
                  )),
                );
              }
            },
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Card(
                  child: ListTile(
                    onTap: () async {
                      Workout tempWorkout = Workout(
                        id: 0,
                        name: 'Workout',
                        exercises: [],
                        difficulty: 60,
                        duration: 30,
                      );
                      dynamic result = await Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (_) => WorkoutPage(
                                  workout: tempWorkout,
                                  isNewWorkout: true,
                                )),
                      );
                      if (result != null) {
                        _workoutBloc.add(AddWorkout(result, theWorkoutList));
                      }
                    },
                    title: const Text(
                      'Add Workout',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward),
                  ),
                ),
                const SizedBox(height: 90),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
