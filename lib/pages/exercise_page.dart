import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:pr/models/database.dart';
import 'package:pr/models/workouts_isar.dart';
import 'package:pr/theme/theme.dart';
//import 'package:pr/models/number_widget.dart';
import 'package:pr/pages/workout_log_page.dart';

class ExercisePage extends StatefulWidget {
  final Id id;
  final String groupName;
  final int color;
  const ExercisePage({
    super.key,
    required this.id,
    required this.groupName,
    required this.color,
  });

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  final nameController = TextEditingController();
  List<WorkoutEntry> workoutsList = [];

  // final bwController = TextEditingController();
  // final weightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    workoutFetch();
  }

  workoutFetch() async {
    WorkoutDetail workoutDeet = await Database().fetchWorkouts(widget.id);
    setState(() {
      workoutsList = workoutDeet.workouts;
    });
  }

  void createWorkout() {
    // int setsCount = 0;
    // int repsCount = 10;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        //insetPadding: const EdgeInsets.all(10),
        backgroundColor: darkMode.colorScheme.secondary,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          side: BorderSide(
            color: darkMode.colorScheme.primary,
            width: 5,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'New Workout',
              style: TextStyle(
                color: darkMode.colorScheme.inversePrimary,
                fontSize: 21,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Icon(Icons.info_outline_rounded,
                    color: darkMode.colorScheme.inversePrimary),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "Add workouts for the chosen muscle group within which you can track your progress.",
                    style: TextStyle(
                      color: darkMode.colorScheme.inversePrimary,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 5),

            SizedBox(
              width: 180,
              child: TextField(
                style: TextStyle(
                  color: darkMode.colorScheme.inversePrimary,
                ),
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: 'Enter workout name...',
                  hintStyle: TextStyle(
                    color: Color.fromARGB(255, 127, 127, 127),
                  ),
                ),
              ),
            ),
            // Row(
            //   children: [
            //     Expanded(
            //       child: Text(
            //         'Sets: ',
            //         style:
            //             TextStyle(color: darkMode.colorScheme.inversePrimary),
            //       ),
            //     ),
            //     NumberStep(
            //         initialValue: setsCount,
            //         onValueChanged: (newValue) => setsCount = newValue),
            //   ],
            // ),
            // Row(
            //   children: [
            //     Expanded(
            //       child: Text(
            //         'Reps: ',
            //         style:
            //             TextStyle(color: darkMode.colorScheme.inversePrimary),
            //       ),
            //     ),
            //     NumberStep(
            //         initialValue: repsCount,
            //         onValueChanged: (newValue) => repsCount = newValue),
            //   ],
            // ),
            // Row(
            //   children: [
            //     Expanded(
            //       child: Text(
            //         'Bodyweight: ',
            //         style:
            //             TextStyle(color: darkMode.colorScheme.inversePrimary),
            //       ),
            //     ),
            //     SizedBox(
            //       width: 130,
            //       child: TextField(
            //         controller: bwController,
            //         style: TextStyle(
            //           color: darkMode.colorScheme.inversePrimary,
            //         ),
            //         keyboardType: TextInputType.number,
            //         // inputFormatters: [
            //         //   FilteringTextInputFormatter.digitsOnly,
            //         // ],
            //       ),
            //     ),
            //   ],
            // ),
            // Row(
            //   children: [
            //     Expanded(
            //       child: Text(
            //         'Weight: ',
            //         style:
            //             TextStyle(color: darkMode.colorScheme.inversePrimary),
            //       ),
            //     ),
            //     SizedBox(
            //       width: 130,
            //       child: TextField(
            //         controller: weightController,
            //         style: TextStyle(
            //           color: darkMode.colorScheme.inversePrimary,
            //         ),
            //         keyboardType: TextInputType.number,
            //       ),
            //     ),
            //   ],
            // ),
            //find out how to return a value from NumberStep so that you can pass it into the database
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 50, 0),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'CLOSE',
                      style:
                          TextStyle(color: darkMode.colorScheme.inversePrimary),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 10, 10, 0),
                  child: MaterialButton(
                    onPressed: () async {
                      //add date parameter later

                      await Database().newWorkout(
                        widget.id,
                        nameController.text,
                        // setsCount,
                        // repsCount,
                        // double.parse(bwController.text),
                        // double.parse(weightController.text),
                        //account for blank entries
                      );
                      // bwController.clear();
                      // weightController.clear();
                      Navigator.pop(context);
                      workoutFetch();
                      nameController.clear();
                    },
                    child: Text(
                      'SAVE',
                      style:
                          TextStyle(color: darkMode.colorScheme.inversePrimary),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkMode.colorScheme.surface,
      appBar: AppBar(
        toolbarHeight: 60,
        title: Text(widget.groupName),
        backgroundColor: darkMode.colorScheme.primary,
        foregroundColor: darkMode.colorScheme.inversePrimary,
      ),
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage("assets/images/personal_record.png"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Color(widget.color).withOpacity(0.3),
              BlendMode.srcATop,
            ),
          ),
        ),
        child: SizedBox.expand(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: List.generate(
                    workoutsList.length,
                    (index) {
                      final workout = workoutsList[index];
                      return Container(
                        decoration: BoxDecoration(
                          color: darkMode.colorScheme.secondary,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        margin:
                            const EdgeInsets.only(top: 10, left: 10, right: 10),
                        child: ListTile(
                          title: Text(
                            workout.name,
                            style: TextStyle(
                              color: darkMode.colorScheme.inversePrimary,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WorkoutLogPage(
                                  groupId: widget.id,
                                  workoutName: workout.name,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createWorkout,
        backgroundColor: darkMode.colorScheme.primary,
        child: Icon(
          Icons.add,
          color: darkMode.colorScheme.inversePrimary,
        ),
      ),
    );
  }
}

//this page is for adding workouts only. If a workout has been used in a workout session by
//the user, then clicking on the workout tile gives you a graph of progress, else it
//gives you a blank page with a message
