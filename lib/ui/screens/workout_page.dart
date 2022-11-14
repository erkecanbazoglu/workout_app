import 'package:flutter/material.dart';
import 'package:workout_app/data/models/exercise.dart';
import 'package:workout_app/data/models/workout.dart';
import 'package:workout_app/ui/screens/exercise_page.dart';
import 'package:workout_app/ui/widgets/exercise_card.dart';

class WorkoutPage extends StatefulWidget {
  final Workout workout;
  final int? index;
  final bool isNewWorkout;
  WorkoutPage({
    Key? key,
    required this.workout,
    this.index,
    required this.isNewWorkout,
  }) : super(key: key);

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  final ScrollController _customScrollViewController = ScrollController();
  late TextEditingController _workoutController;
  final _formKey = GlobalKey<FormState>();
  List<Exercise> exercises = [];
  late Workout workout;

  Future<void> openWorkoutDialog() => showDialog(
      context: context,
      builder: (context) {
        _workoutController.text = workout.name;
        return AlertDialog(
          title: const Text("Enter a name:"),
          content: Form(
            key: _formKey,
            child: TextFormField(
              controller: _workoutController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Workout 1',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                } else if (value.length > 20) {
                  return 'Too long: max 20 characters';
                }
                return null;
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    workout.name = _workoutController.text;
                  });
                  Navigator.of(context).pop();
                }
              },
              child: const Text("Save"),
            ),
          ],
        );
      });

  Future<void> popAlert() => showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Are you sure you want to quit?"),
          content: const Text("Your changes will not be saved!"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pop(context, null);
              },
              child: const Text("Leave"),
            ),
          ],
        );
      });

  @override
  void initState() {
    super.initState();
    _workoutController = TextEditingController();
    //Creating a complete copy of original workout object
    workout = widget.workout.copyWith(workout: widget.workout);
    for (var exercise in workout.exercises) {
      exercises.add(exercise);
    }
    if (widget.isNewWorkout) {
      setState(() {
        _workoutController.text = "Workout";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            popAlert();
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
        ),
        title: TextButton(
          onPressed: openWorkoutDialog,
          child: Padding(
            padding: const EdgeInsets.only(right: 32.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  workout.name,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(width: 10),
                const Icon(
                  Icons.border_color,
                  color: Colors.black,
                  size: 18,
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        children: [
          CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: _customScrollViewController,
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final exercise = exercises[index];
                    return ExerciseCard(
                      exercise: exercise,
                      index: index,
                      onTapDelete: () {
                        setState(() {
                          exercises.removeAt(index);
                        });
                      },
                      onTapNavigate: () async {
                        dynamic result = await Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (_) => ExercisePage(
                                    exercise: exercise,
                                    isNewExercise: false,
                                  )),
                        );
                        if (result != null) {
                          setState(() {
                            exercises[index] = result;
                          });
                        }
                      },
                    );
                  },
                  childCount: exercises.length,
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(width: 0.5),
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        "Difficulty: " +
                                            workout.difficulty.toString(),
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              if (workout.difficulty > 0) {
                                                setState(() {
                                                  workout.difficulty -= 10;
                                                });
                                              } else {
                                                const snackBar = SnackBar(
                                                  backgroundColor: Colors.blue,
                                                  content: Text(
                                                    'The minimum is 0, don\'t you think it\'s easy enough?',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                );
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(snackBar);
                                              }
                                            },
                                            icon: const Icon(Icons.remove),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              if (workout.difficulty < 100) {
                                                setState(() {
                                                  workout.difficulty += 10;
                                                });
                                              } else {
                                                const snackBar = SnackBar(
                                                  backgroundColor: Colors.blue,
                                                  content: Text(
                                                    'The maximum is 100, you pushed yourself quite enough:)',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                );
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(snackBar);
                                              }
                                            },
                                            icon: const Icon(Icons.add),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(width: 0.5),
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        "Duration: " +
                                            workout.duration.toString() +
                                            " mins",
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              if (workout.duration > 0) {
                                                setState(() {
                                                  workout.duration -= 1;
                                                });
                                              } else {
                                                const snackBar = SnackBar(
                                                  backgroundColor: Colors.blue,
                                                  content: Text(
                                                    'The minimum is 0, don\'t you think it\'s short enough?',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                );
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(snackBar);
                                              }
                                            },
                                            icon: const Icon(Icons.remove),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              if (workout.duration < 120) {
                                                setState(() {
                                                  workout.duration += 1;
                                                });
                                              } else {
                                                const snackBar = SnackBar(
                                                  backgroundColor: Colors.blue,
                                                  content: Text(
                                                    'The maximum is 120, you pushed yourself quite enough:)',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                );
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(snackBar);
                                              }
                                            },
                                            icon: const Icon(Icons.add),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Card(
                      child: ListTile(
                        onTap: () async {
                          Exercise tempExercise = Exercise(
                            id: 0,
                            exercise: ExerciseType.squat,
                            weight: 40,
                            sets: [],
                          );
                          dynamic result = await Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (_) => ExercisePage(
                                      exercise: tempExercise,
                                      isNewExercise: true,
                                    )),
                          );
                          if (result != null) {
                            setState(() {
                              exercises.add(result);
                            });
                          }
                        },
                        title: const Text(
                          'Add Exercise',
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
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: TextButton(
                  onPressed: () {
                    if (_workoutController.text == "Workout") {
                      const snackBar = SnackBar(
                        backgroundColor: Colors.brown,
                        content: Text(
                          'Please give a name!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else if (exercises.isEmpty) {
                      const snackBar = SnackBar(
                        backgroundColor: Colors.brown,
                        content: Text(
                          'Please add an exercise!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      workout.exercises = exercises;
                      Navigator.pop(context, workout);
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blueAccent,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FittedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Save",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                      fontSize:
                                          MediaQuery.of(context).size.width /
                                              24),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _workoutController.dispose();
    super.dispose();
  }
}
