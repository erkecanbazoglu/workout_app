import 'package:flutter/material.dart';
import 'package:workout_app/core/constants/styles.dart';
import 'package:workout_app/data/models/exercise.dart';
import 'package:workout_app/ui/widgets/exercise_image.dart';
import 'package:workout_app/ui/widgets/sets_card.dart';
import 'dart:math' as math;

class ExercisePage extends StatefulWidget {
  final Exercise exercise;
  final bool isNewExercise;
  const ExercisePage({
    Key? key,
    required this.exercise,
    required this.isNewExercise,
  }) : super(key: key);

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  final ScrollController _customScrollViewController = ScrollController();
  int selectedExercise = -1;
  late Exercise exercise;
  List<List<int>> sets = [];

  int getExerciseImage(ExerciseType exercise) {
    switch (exercise) {
      case ExerciseType.barbellRow:
        return 0;
      case ExerciseType.benchPress:
        return 1;
      case ExerciseType.shoulderPress:
        return 2;
      case ExerciseType.deadlift:
        return 3;
      case ExerciseType.squat:
        return 4;
      default:
        return 0;
    }
  }

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
    //Creating a complete copy of original exercise object
    exercise = widget.exercise.copyWith(exercise: widget.exercise);
    for (var set in exercise.sets) {
      sets.add(set);
    }
    if (!widget.isNewExercise) {
      setState(() {
        selectedExercise = getExerciseImage(exercise.exercise);
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
        title: const Text(
          "Exercise",
          style: TextStyle(color: Colors.black),
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
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Exercise choice
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 24, bottom: 12),
                            child: Text(
                              "Select an exercise:",
                              style: kSubHeadingTextStyle,
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: ExerciseImage(
                                  selectedExercise: selectedExercise,
                                  onTap: () {
                                    setState(() {
                                      selectedExercise = 0;
                                      exercise.exercise =
                                          ExerciseType.barbellRow;
                                    });
                                  },
                                  index: 0,
                                ),
                              ),
                              Expanded(
                                child: ExerciseImage(
                                  selectedExercise: selectedExercise,
                                  onTap: () {
                                    setState(() {
                                      selectedExercise = 1;
                                      exercise.exercise =
                                          ExerciseType.benchPress;
                                    });
                                  },
                                  index: 1,
                                ),
                              ),
                              Expanded(
                                child: ExerciseImage(
                                  selectedExercise: selectedExercise,
                                  onTap: () {
                                    setState(() {
                                      selectedExercise = 2;
                                      exercise.exercise =
                                          ExerciseType.shoulderPress;
                                    });
                                  },
                                  index: 2,
                                ),
                              ),
                              Expanded(
                                child: ExerciseImage(
                                  selectedExercise: selectedExercise,
                                  onTap: () {
                                    setState(() {
                                      selectedExercise = 3;
                                      exercise.exercise = ExerciseType.deadlift;
                                    });
                                  },
                                  index: 3,
                                ),
                              ),
                              Expanded(
                                child: ExerciseImage(
                                  selectedExercise: selectedExercise,
                                  onTap: () {
                                    setState(() {
                                      selectedExercise = 4;
                                      exercise.exercise = ExerciseType.squat;
                                    });
                                  },
                                  index: 4,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      //Weight
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 24, bottom: 12),
                            child: Text(
                              "Select your weight:",
                              style: kSubHeadingTextStyle,
                            ),
                          ),
                          Padding(
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
                                      "Weight: " + exercise.weight.toString(),
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
                                            if (exercise.weight > 0) {
                                              setState(() {
                                                exercise.weight -= 2;
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
                                            if (exercise.weight < 200) {
                                              setState(() {
                                                exercise.weight += 2;
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
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 24, bottom: 12),
                        child: Text(
                          "Type your sets:",
                          style: kSubHeadingTextStyle,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final set = sets[index];
                    return SetsCard(
                        set: set,
                        index: index,
                        onTap: () {
                          setState(() {
                            sets.removeAt(index);
                          });
                        });
                  },
                  childCount: sets.length,
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(),
                    Card(
                      child: ListTile(
                        onTap: () {
                          //Adding randomly right now
                          int random = math.Random().nextInt(3);
                          List<List<int>> list = [
                            [14, 12, 10],
                            [12, 10, 8],
                            [10, 8, 6]
                          ];
                          setState(() {
                            sets.add(list[random]);
                          });
                        },
                        title: const Text(
                          'Add Set',
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
                    if (selectedExercise < 0 || selectedExercise > 4) {
                      const snackBar = SnackBar(
                        backgroundColor: Colors.brown,
                        content: Text(
                          'Please select and exercise!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else if (sets.isEmpty) {
                      const snackBar = SnackBar(
                        backgroundColor: Colors.brown,
                        content: Text(
                          'Please add a set!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      exercise.sets = sets;
                      Navigator.pop(context, exercise);
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
}
