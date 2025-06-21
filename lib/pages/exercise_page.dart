import 'package:flutter/material.dart';
import 'package:pr/models/database.dart';
import 'package:pr/theme/theme.dart';
//import 'package:pr/models/number_widget.dart';
import 'package:pr/pages/log_page.dart';

class ExercisePage extends StatefulWidget {
  final int id;
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
  List<Workout> workoutsList = [];
  final db = AppDatabase();
  int? selectedWorkoutIndex;

  @override
  void initState() {
    super.initState();
    workoutFetch();
  }

  Future<void> workoutFetch() async {
    workoutsList = await db.fetchWorkouts(widget.id);
    setState(() {});
  }

  void createWorkout() {
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
              width: 220,
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
                      await db.newWorkout(widget.id, nameController.text);
                      await workoutFetch();

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

  void editWorkout(Workout workout) {
    nameController.text = workout.name;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: darkMode.colorScheme.primary,
        title: Text(
          'Edit Workout',
          style: TextStyle(color: darkMode.colorScheme.inversePrimary),
        ),
        content: TextField(
          style: TextStyle(color: darkMode.colorScheme.inversePrimary),
          controller: nameController,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Edit workout name...',
            hintStyle: TextStyle(color: Color.fromARGB(255, 127, 127, 127)),
          ),
        ),
        actions: [
          MaterialButton(
            onPressed: () async {
              Navigator.pop(context);
              await db.updateWorkout(workout.workoutID, nameController.text);
              await workoutFetch();
              nameController.clear();
              selectedWorkoutIndex = null;
            },
            child: Text(
              'UPDATE',
              style: TextStyle(color: darkMode.colorScheme.inversePrimary),
            ),
          ),
        ],
      ),
    );
  }

  void deleteWorkout(int id, String name) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: darkMode.colorScheme.primary,
        title: Text(
          'Delete workout \'$name\'?',
          style: TextStyle(color: darkMode.colorScheme.inversePrimary),
        ),
        actions: [
          MaterialButton(
            onPressed: () async {
              Navigator.pop(context);
              await db.deleteWorkout(id);
              await workoutFetch();
              selectedWorkoutIndex = null;
            },
            child: Text(
              'DELETE',
              style: TextStyle(color: darkMode.colorScheme.inversePrimary),
            ),
          ),
        ],
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
        actions: selectedWorkoutIndex != null
            ? [
                IconButton(
                  onPressed: () {
                    editWorkout(workoutsList[selectedWorkoutIndex!]);
                  },
                  icon: const Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: () {
                    deleteWorkout(workoutsList[selectedWorkoutIndex!].workoutID,
                        workoutsList[selectedWorkoutIndex!].name);
                  },
                  icon: const Icon(Icons.delete),
                ),
              ]
            : [],
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          if (selectedWorkoutIndex != null) {
            setState(() {
              selectedWorkoutIndex = null;
            });
          }
        },
        child: DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage("assets/images/personal_record.png"),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Color(widget.color).withOpacity(0.25),
                BlendMode.srcATop,
              ),
            ),
          ),
          child: workoutsList.isEmpty
              ? Center(
                  child: Container(
                    padding: const EdgeInsets.all(30.0),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(
                        width: 2,
                        color: darkMode.colorScheme.inversePrimary,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.fitness_center,
                          size: 70,
                          color: darkMode.colorScheme.inversePrimary
                              .withOpacity(0.8),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "No workouts added yet",
                          style: TextStyle(
                            color: darkMode.colorScheme.inversePrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "Tap the + button below to add your first workout",
                          style: TextStyle(
                            color: darkMode.colorScheme.inversePrimary,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                )
              : SizedBox.expand(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Column(
                          children: List.generate(
                            workoutsList.length,
                            (index) {
                              final workout = workoutsList[index];
                              final bool isSelected =
                                  selectedWorkoutIndex == index;
                              return Container(
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Color.lerp(
                                          darkMode.colorScheme.secondary,
                                          Colors.grey,
                                          0.18)
                                      : darkMode.colorScheme.secondary,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15)),
                                ),
                                margin: const EdgeInsets.only(
                                    top: 10, left: 15, right: 15),
                                child: ListTile(
                                  title: Text(
                                    workout.name,
                                    style: TextStyle(
                                      color:
                                          darkMode.colorScheme.inversePrimary,
                                    ),
                                  ),
                                  onTap: () {
                                    if (selectedWorkoutIndex != null) {
                                      setState(() {
                                        selectedWorkoutIndex = null;
                                      });
                                    } else {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => LogPage(
                                            workoutName: workout.name,
                                            workoutId: workout.workoutID,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  onLongPress: () {
                                    setState(() {
                                      selectedWorkoutIndex = index;
                                    });
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

//EDIT: the following is bullshit
//this page is for adding workouts only. If a workout has been used in a workout session by
//the user, then clicking on the workout tile gives you a graph of progress, else it
//gives you a blank page with a message
