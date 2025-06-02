import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:pr/theme/theme.dart';
import 'package:pr/models/database.dart';
import 'package:pr/models/workouts_isar.dart';

class WorkoutLogPage extends StatefulWidget {
  final Id groupId;
  final String workoutName;
  const WorkoutLogPage(
      {super.key, required this.groupId, required this.workoutName});

  @override
  State<WorkoutLogPage> createState() => _WorkoutLogPageState();
}

class _WorkoutLogPageState extends State<WorkoutLogPage> {
  List<Session> logs = [];
  List<_SetInput> setInputs = [_SetInput()];

  @override
  void initState() {
    super.initState();
    fetchLogs();
  }

  void fetchLogs() async {
    final fetched =
        await Database().fetchWorkoutLogs(widget.groupId, widget.workoutName);
    setState(() {
      logs = fetched.reversed.toList();
    });
  }

  void addLogs() async {
    List<Sets> newSets = [];
    for (final input in setInputs) {
      final weight = double.tryParse(input.weightController.text);
      final reps = int.tryParse(input.repsController.text);
      if (weight != null && reps != null) {
        newSets.add(Sets(weight: weight, reps: reps));
      }
    }
    if (newSets.isNotEmpty) {
      await Database()
          .addWorkoutLog(widget.groupId, widget.workoutName, newSets);
    }
    Navigator.of(context).pop();
    setInputs = [_SetInput()];
    fetchLogs();
  }

  void createLogDialog() {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setStateDialog) => AlertDialog(
          title: const Text('Add Multiple Sets'),
          content: SizedBox(
            width: 350,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ...List.generate(
                  setInputs.length,
                  (index) => Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: setInputs[index].weightController,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          decoration:
                              const InputDecoration(labelText: 'Weight'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: setInputs[index].repsController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(labelText: 'Reps'),
                        ),
                      ),
                      IconButton(
                        icon:
                            const Icon(Icons.remove_circle, color: Colors.red),
                        onPressed: setInputs.length > 1
                            ? () {
                                setStateDialog(() {
                                  setInputs.removeAt(index);
                                });
                              }
                            : null,
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                    icon: const Icon(Icons.add),
                    label: const Text('Add Set'),
                    onPressed: () {
                      setStateDialog(() {
                        setInputs.add(_SetInput());
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: addLogs,
              child: const Text('ADD'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          widget.workoutName,
          style: TextStyle(
            color: darkMode.colorScheme.inversePrimary,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: darkMode.colorScheme.inversePrimary,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextButton(
                onPressed: createLogDialog,
                child: Row(
                  children: [
                    Text(
                      "Add fresh log",
                      style: TextStyle(
                        fontSize: 18,
                        color: darkMode.colorScheme.inversePrimary,
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.add,
                      color: darkMode.colorScheme.inversePrimary,
                      size: 28,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: logs.isEmpty
                  ? Center(
                      child: Text(
                        'No logs yet.',
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: logs.length,
                      itemBuilder: (context, sessionIndex) {
                        final session = logs[sessionIndex];
                        final dt = session.dateTime;
                        final dateStr =
                            '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}';
                        final timeStr =
                            '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
                        return Card(
                          color: Colors.grey[900],
                          margin: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 2),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '$dateStr $timeStr',
                                      style: const TextStyle(
                                          color: Colors.grey, fontSize: 14),
                                    ),
                                  ],
                                ),
                                ...session.sets.map((set) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 2.0),
                                      child: Text(
                                        'Weight: ${set.weight}, Reps: ${set.reps}',
                                        style: TextStyle(
                                          color: darkMode
                                              .colorScheme.inversePrimary,
                                          fontSize: 18,
                                        ),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SetInput {
  final TextEditingController weightController = TextEditingController();
  final TextEditingController repsController = TextEditingController();
}
