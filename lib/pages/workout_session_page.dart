import 'package:flutter/material.dart';
import 'package:pr/models/database.dart';
import 'package:pr/theme/theme.dart';
import 'package:pr/main.dart';
import 'package:drift/drift.dart' show Value;

//TODO: if the user hits the back button on their phone, it should prompt to end the workout
//TODO: handle accidentally added workouts to the active workouts section
//TODO: have the option to add a new workout to a group on the fly

//TODO: MAJOR: there is an issue with the editing of the workout after it has been completed and exited because it edits the workout that was created earlier when starting a new one

class WorkoutSessionPage extends StatefulWidget {
  final List<int> selectedGroupIds;
  const WorkoutSessionPage({super.key, required this.selectedGroupIds});

  @override
  State<WorkoutSessionPage> createState() => _WorkoutSessionPageState();
}

class SetInput {
  final TextEditingController weightController = TextEditingController();
  final TextEditingController repsController = TextEditingController();
}

class WorkoutLog {
  final Workout workout;
  final List<SetInput> setInputs;
  final TextEditingController noteController;
  bool isFinished;
  bool isActive;
  //represents whether the workout has sets in it or not, or whether it is being displayed in the active workouts section or not
  //it will be used to display the 'edit' icon
  int? logID; // Track the log ID for updates

  WorkoutLog(this.workout)
      : setInputs = [SetInput()],
        noteController = TextEditingController(),
        isFinished = false,
        isActive = false,
        logID = null;
}

class WorkoutCard extends StatelessWidget {
  final WorkoutLog workoutLog;
  final VoidCallback onFinish; //TODO: investigate this more later
  final VoidCallback onUpdate;

  const WorkoutCard({
    super.key,
    required this.workoutLog,
    required this.onFinish,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: workoutLog.isFinished //TODO: is this even necessary
          ? Colors.green.withOpacity(0.3)
          : darkMode.colorScheme.secondary,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              workoutLog.workout.name,
              style: TextStyle(
                color: darkMode.colorScheme.inversePrimary,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 16),

            // Sets input (only if not finished)
            if (!workoutLog.isFinished) ...[
              // Sets list
              ...List.generate(
                workoutLog.setInputs.length,
                (setIndex) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      Text(
                        'Set ${setIndex + 1}:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: darkMode.colorScheme.inversePrimary,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller:
                              workoutLog.setInputs[setIndex].weightController,
                          style: TextStyle(
                              color: darkMode.colorScheme.inversePrimary),
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          decoration: InputDecoration(
                            hintText: 'Weight',
                            hintStyle:
                                TextStyle(color: darkMode.colorScheme.primary),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller:
                              workoutLog.setInputs[setIndex].repsController,
                          style: TextStyle(
                              color: darkMode.colorScheme.inversePrimary),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Reps',
                            hintStyle:
                                TextStyle(color: darkMode.colorScheme.primary),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon:
                            const Icon(Icons.remove_circle, color: Colors.red),
                        onPressed: workoutLog.setInputs.length > 1
                            ? () {
                                workoutLog.setInputs.removeAt(setIndex);
                                onUpdate();
                              }
                            : null,
                      ),
                      IconButton(
                        onPressed: () {
                          double weight = double.tryParse(workoutLog
                                  .setInputs[setIndex].weightController.text) ??
                              0;
                          int reps = int.tryParse(workoutLog
                                  .setInputs[setIndex].repsController.text) ??
                              0;
                          workoutLog.setInputs.add(SetInput()
                            ..weightController.text = weight.toString()
                            ..repsController.text = reps.toString());
                          onUpdate();
                        },
                        icon: Icon(
                          Icons.control_point_duplicate,
                          color: darkMode.colorScheme.inversePrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 5),

              // Add set button
              Center(
                child: TextButton(
                  onPressed: () {
                    workoutLog.setInputs.add(SetInput());
                    onUpdate();
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: darkMode.colorScheme.inversePrimary, width: 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.add,
                            color: darkMode.colorScheme.inversePrimary,
                            size: 18),
                        const SizedBox(width: 4),
                        Text(
                          "Add Set",
                          style: TextStyle(
                              color: darkMode.colorScheme.inversePrimary),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Notes field
              TextField(
                controller: workoutLog.noteController,
                maxLines: 2,
                style: TextStyle(color: darkMode.colorScheme.inversePrimary),
                decoration: InputDecoration(
                  hintText: 'Notes (optional)',
                  hintStyle: TextStyle(color: darkMode.colorScheme.primary),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  contentPadding: const EdgeInsets.all(10),
                ),
              ),

              const SizedBox(height: 15),
            ],

            // Status or finish button
            if (workoutLog.isFinished)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.check_circle, color: Colors.green),
                    const SizedBox(width: 8),
                    Text(
                      'Completed',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              )
            else
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onFinish,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _WorkoutSessionPageState extends State<WorkoutSessionPage> {
  final db = AppDatabase();
  List<MuscleGroup> selectedGroups = [];
  List<WorkoutLog> activeWorkouts = [];
  final TextEditingController _newWorkoutController = TextEditingController();
  bool _isAddingNewWorkout = false;
  List<int> finishedWorkoutIds = []; // Track workouts that have been finished

  @override
  void initState() {
    super.initState();
    loadSelectedGroups();
  }

  Future<void> loadSelectedGroups() async {
    final allGroups = await db.fetchGroups();
    selectedGroups = allGroups
        .where((group) => widget.selectedGroupIds.contains(group.groupID))
        .toList();
    setState(() {});
  }

  void showWorkoutSelector(MuscleGroup group) {
    // Reset dialog state when opening
    setState(() {
      _isAddingNewWorkout = false;
      _newWorkoutController.clear();
    });

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => FutureBuilder<List<Workout>>(
          future: db.fetchWorkouts(group.groupID),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return AlertDialog(
                backgroundColor: darkMode.colorScheme.secondary,
                content: const CircularProgressIndicator(),
              );
            }

            final workouts = snapshot.data!;
            return AlertDialog(
              backgroundColor: darkMode.colorScheme.secondary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: BorderSide(color: darkMode.colorScheme.primary, width: 2),
              ),
              title: Text(
                'Select Workout from ${group.groupName}',
                style: TextStyle(
                  color: darkMode.colorScheme.inversePrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              content: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.4,
                  minHeight: 0,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: workouts.asMap().entries.map((entry) {
                      final index = entry.key;
                      final workout = entry.value;
                      final isAlreadySelected = activeWorkouts.any(
                          (wl) => wl.workout.workoutID == workout.workoutID);
                      final isFinished =
                          finishedWorkoutIds.contains(workout.workoutID);

                      return Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: isFinished && !isAlreadySelected
                                    ? Colors.orange
                                    : isAlreadySelected
                                        ? Colors.grey
                                        : Colors.transparent,
                                width: isFinished || isAlreadySelected ? 2 : 0,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ListTile(
                              leading: isFinished && !isAlreadySelected
                                  ? Icon(
                                      Icons.check_circle,
                                      color: Colors.orange,
                                    )
                                  : null,
                              title: Text(
                                workout.name,
                                style: TextStyle(
                                  color: darkMode.colorScheme.inversePrimary,
                                  fontWeight: isAlreadySelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                              trailing: isFinished && !isAlreadySelected
                                  ? Icon(Icons.edit, color: Colors.orange)
                                  : isAlreadySelected
                                      ? Text(
                                          'Ongoing',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        )
                                      : Icon(Icons.add,
                                          color: darkMode
                                              .colorScheme.inversePrimary),
                              onTap: () async {
                                if (isFinished) {
                                  // Bring finished workout back to active list
                                  await addWorkoutToSession(workout);
                                } else if (!isAlreadySelected) {
                                  // Add new workout log
                                  await addWorkoutToSession(workout);
                                }
                                Navigator.pop(context);

                                // If already selected and ongoing, do nothing
                              },
                            ),
                          ),
                          if (index < workouts.length - 1)
                            Column(
                              children: [
                                SizedBox(
                                  height: 1,
                                ),
                                Divider(
                                  color: darkMode.colorScheme.primary,
                                  thickness: 2,
                                  height: 1,
                                ),
                                SizedBox(
                                  height: 1,
                                ),
                              ],
                            ),
                        ],
                      );
                    }).toList()
                      ..add(
                        // Add new workout section
                        Column(
                          children: [
                            if (workouts.isNotEmpty)
                              Divider(
                                color: darkMode.colorScheme.primary,
                                thickness: 2,
                                height: 1,
                              ),
                            if (!_isAddingNewWorkout)
                              ListTile(
                                leading: Icon(
                                  Icons.add_circle_outline,
                                  color: darkMode.colorScheme.inversePrimary,
                                ),
                                title: Text(
                                  'Add a new workout',
                                  style: TextStyle(
                                    color: darkMode.colorScheme.inversePrimary,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                                onTap: () {
                                  setDialogState(() {
                                    _isAddingNewWorkout = true;
                                  });
                                },
                              )
                            else
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    TextField(
                                      controller: _newWorkoutController,
                                      autofocus: true,
                                      style: TextStyle(
                                        color:
                                            darkMode.colorScheme.inversePrimary,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: 'Enter workout name...',
                                        hintStyle: TextStyle(
                                          color: darkMode.colorScheme.primary,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 8,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            setDialogState(() {
                                              _isAddingNewWorkout = false;
                                              _newWorkoutController.clear();
                                            });
                                          },
                                          child: Text(
                                            'Cancel',
                                            style: TextStyle(
                                              color:
                                                  darkMode.colorScheme.primary,
                                            ),
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () async {
                                            if (_newWorkoutController.text
                                                .trim()
                                                .isNotEmpty) {
                                              // Add new workout to database
                                              await db.newWorkout(
                                                group.groupID,
                                                _newWorkoutController.text
                                                    .trim(),
                                              );

                                              // Fetch the newly created workout
                                              final updatedWorkouts = await db
                                                  .fetchWorkouts(group.groupID);
                                              final newWorkout =
                                                  updatedWorkouts.firstWhere(
                                                (w) =>
                                                    w.name ==
                                                    _newWorkoutController.text
                                                        .trim(),
                                              );

                                              // Add to active workouts
                                              await addWorkoutToSession(
                                                  newWorkout);

                                              // Reset state and close dialog
                                              setDialogState(() {
                                                _isAddingNewWorkout = false;
                                                _newWorkoutController.clear();
                                              });

                                              Navigator.pop(context);
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.orange,
                                            foregroundColor: Colors.white,
                                          ),
                                          child: const Text('Add'),
                                        ),
                                      ],
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
            );
          },
        ),
      ),
    );
  }

  Future<void> addWorkoutToSession(Workout workout) async {
    final workoutLog = WorkoutLog(workout);
    workoutLog.isActive = true;

    // If this workout was finished, load the previous sets from the most recent log
    if (finishedWorkoutIds.contains(workout.workoutID)) {
      final logs = await db.fetchLogs(workout.workoutID);
      if (logs.isNotEmpty) {
        // Sort logs by date in descending order to ensure most recent is first
        // logs.sort((a, b) => b.dt.compareTo(a.dt));
        final latestLog = logs.last;
        final sets = await db.fetchLogSets(latestLog.logID);

        // Always set the log ID to the first (most recent) log for updates
        workoutLog.logID = latestLog.logID;

        // Clear the default single SetInput and add the previous sets
        workoutLog.setInputs.clear();

        for (final set in sets) {
          final setInput = SetInput();
          setInput.weightController.text = set.weight.toString();
          setInput.repsController.text = set.reps.toString();
          workoutLog.setInputs.add(setInput);
        }

        // Load the previous note from the most recent log
        if (latestLog.note != null && latestLog.note!.isNotEmpty) {
          workoutLog.noteController.text = latestLog.note!;
        }
      }
    }

    setState(() {
      activeWorkouts.add(workoutLog);
    });
  }

  Future<void> finishWorkout(WorkoutLog workoutLog) async {
    final sets = workoutLog.setInputs
        .where((input) =>
            input.weightController.text.isNotEmpty &&
            input.repsController.text.isNotEmpty)
        .map((input) => LogSetsCompanion(
              weight: Value(double.tryParse(input.weightController.text) ?? 0),
              reps: Value(int.tryParse(input.repsController.text) ?? 0),
            ))
        .toList();

    if (sets.isNotEmpty) {
      // Turn the card green and show completion state
      setState(() {
        workoutLog.isFinished = true;
      });

      // Save to database - update existing log if it exists, otherwise create new one
      if (workoutLog.logID != null) {
        // Update existing log
        await db.updateLogWithSets(
          workoutLog.logID!,
          sets,
          note: workoutLog.noteController.text.isNotEmpty
              ? workoutLog.noteController.text
              : null,
        );
      } else {
        // Create new log
        await db.addLogWithSets(
          workoutLog.workout.workoutID,
          sets,
          note: workoutLog.noteController.text.isNotEmpty
              ? workoutLog.noteController.text
              : null,
        );
      }

      // Wait for 1 second to show the green state
      await Future.delayed(const Duration(seconds: 1));

      // Then remove from active workouts and add to finished list
      setState(() {
        if (!finishedWorkoutIds.contains(workoutLog.workout.workoutID)) {
          finishedWorkoutIds.add(workoutLog.workout.workoutID);
        }
        activeWorkouts.remove(workoutLog);
      });
    }
  }

  void endWorkout() {
    // Clear all workout-related lists and data
    setState(() {
      activeWorkouts.clear();
      finishedWorkoutIds.clear();
      _newWorkoutController.clear();
      _isAddingNewWorkout = false;
    });

    // Navigate back to home page
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => RootPage()),
      (route) => false, // Remove all previous routes
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkMode.colorScheme.primary,
      appBar: AppBar(
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
        title: const Text('Timer Placeholder'),
        backgroundColor: darkMode.colorScheme.primary,
        foregroundColor: darkMode.colorScheme.inversePrimary,
        actions: [
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.red,
            ),
            child: TextButton(
              onPressed: endWorkout,
              child: Text(
                'End Workout',
                style: TextStyle(
                  color: darkMode.colorScheme.secondary,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: darkMode.colorScheme.surface,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: activeWorkouts.isEmpty
                  ? Center(
                      child: Text(
                        'Select muscle groups below to start logging workouts',
                        style: TextStyle(
                          color: darkMode.colorScheme.inversePrimary,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: activeWorkouts.length,
                      itemBuilder: (context, index) {
                        final workoutLog = activeWorkouts[index];
                        return WorkoutCard(
                          workoutLog: workoutLog,
                          onFinish: () => finishWorkout(workoutLog),
                          onUpdate: () => setState(() {}),
                        );
                      },
                    ),
            ),
          ),
          // Bottom muscle groups selector
          Container(
            height: 70,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(color: darkMode.colorScheme.primary),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: selectedGroups.length,
              itemBuilder: (context, index) {
                final group = selectedGroups[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: GestureDetector(
                    onTap: () => showWorkoutSelector(group),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Color(group.color),
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          group.groupName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
