import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:pr/theme/theme.dart';
import 'package:pr/models/database.dart';

class LogPage extends StatefulWidget {
  final String workoutName;
  final int workoutId;
  const LogPage(
      {super.key, required this.workoutName, required this.workoutId});

  @override
  State<LogPage> createState() => _LogPageState();
}

class LogWithSets {
  final Log log;
  final List<LogSet> sets;

  LogWithSets(this.log, this.sets);
}

class _LogPageState extends State<LogPage> {
  List<Log> logs = [];
  List<LogWithSets> logWithSets = [];
  List<_SetInput> setInputs = [_SetInput()];
  final db = AppDatabase();
  int? selectedLogIndex;

  @override
  void initState() {
    super.initState();
    fetchLogsandSets();
  }

  Future<void> fetchLogsandSets() async {
    logWithSets.clear();
    logs = await db.fetchLogs(widget.workoutId);
    for (Log log in logs) {
      List<LogSet> sets = await db.fetchLogSets(log.logID);
      logWithSets.add(LogWithSets(log, sets));
    }
    setState(() {});
  }

  Future<void> addLogs() async {
    final sets = setInputs
        .map((input) => LogSetsCompanion(
              weight: Value(double.tryParse(input.weightController.text) ?? 0),
              reps: Value(int.tryParse(input.repsController.text) ?? 0),
            ))
        .toList();
    await db.addLogWithSets(widget.workoutId, sets);
    setInputs = [_SetInput()];
    await fetchLogsandSets();
    Navigator.of(context).pop();
  }

  void createLogDialog() {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setStateDialog) => AlertDialog(
          backgroundColor: darkMode.colorScheme.secondary,
          title: Text(
            'Add Sets',
            style: TextStyle(
              fontSize: 22,
              color: darkMode.colorScheme.inversePrimary,
            ),
          ),
          content: SizedBox(
            width: 250,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ...List.generate(
                  setInputs.length,
                  (index) => Row(
                    children: [
                      Text('Set ${index + 1}:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: darkMode.colorScheme.inversePrimary,
                          )),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: setInputs[index].weightController,
                          style: TextStyle(
                            color: darkMode.colorScheme.inversePrimary,
                          ),
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          decoration: InputDecoration(
                            hintText: 'Weight',
                            hintStyle: TextStyle(
                              color: darkMode.colorScheme.primary,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: setInputs[index].repsController,
                          style: TextStyle(
                            color: darkMode.colorScheme.inversePrimary,
                          ),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Reps',
                            hintStyle: TextStyle(
                              color: darkMode.colorScheme.primary,
                            ),
                          ),
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
                SizedBox(height: 5),
                TextButton(
                    onPressed: () {
                      setStateDialog(() {
                        setInputs.add(_SetInput());
                      });
                    },
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: darkMode.colorScheme.inversePrimary,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Add set",
                                style: TextStyle(
                                  color: darkMode.colorScheme.inversePrimary,
                                )),
                            Icon(
                              Icons.add,
                              color: darkMode.colorScheme.inversePrimary,
                              size: 22,
                            ),
                          ],
                        ),
                      ),
                    )),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: addLogs,
              child: Text(
                'ADD',
                style: TextStyle(
                  fontSize: 16,
                  color: darkMode.colorScheme.inversePrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showUpdateLogDialog(int logIndex) {
    final log = logWithSets[logIndex].log;
    final sets = logWithSets[logIndex].sets;
    List<_SetInput> updateInputs = sets.map((set) {
      final input = _SetInput();
      input.weightController.text = set.weight.toString();
      input.repsController.text = set.reps.toString();
      return input;
    }).toList();
    if (updateInputs.isEmpty) updateInputs = [_SetInput()];
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setStateDialog) => AlertDialog(
          backgroundColor: darkMode.colorScheme.secondary,
          title: Text('Update Sets',
              style: TextStyle(
                  fontSize: 22, color: darkMode.colorScheme.inversePrimary)),
          content: SizedBox(
            width: 250,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ...List.generate(
                  updateInputs.length,
                  (index) => Row(
                    children: [
                      Text('Set ${index + 1}:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: darkMode.colorScheme.inversePrimary,
                          )),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: updateInputs[index].weightController,
                          style: TextStyle(
                            color: darkMode.colorScheme.inversePrimary,
                          ),
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          decoration: InputDecoration(
                            hintText: 'Weight',
                            hintStyle: TextStyle(
                              color: darkMode.colorScheme.primary,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: updateInputs[index].repsController,
                          style: TextStyle(
                            color: darkMode.colorScheme.inversePrimary,
                          ),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Reps',
                            hintStyle: TextStyle(
                              color: darkMode.colorScheme.primary,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon:
                            const Icon(Icons.remove_circle, color: Colors.red),
                        onPressed: updateInputs.length > 1
                            ? () {
                                setStateDialog(() {
                                  updateInputs.removeAt(index);
                                });
                              }
                            : null,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                TextButton(
                  onPressed: () {
                    setStateDialog(() {
                      updateInputs.add(_SetInput());
                    });
                  },
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: darkMode.colorScheme.inversePrimary, width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Add set",
                              style: TextStyle(
                                color: darkMode.colorScheme.inversePrimary,
                              )),
                          Icon(
                            Icons.add,
                            color: darkMode.colorScheme.inversePrimary,
                            size: 22,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                final updatedSets = updateInputs
                    .map((input) => LogSetsCompanion(
                          weight: Value(
                              double.tryParse(input.weightController.text) ??
                                  0),
                          reps: Value(
                              int.tryParse(input.repsController.text) ?? 0),
                        ))
                    .toList();
                await db.updateLogWithSets(log.logID, updatedSets);
                await fetchLogsandSets();
                selectedLogIndex = null;
                Navigator.of(context).pop();
              },
              child: Text('UPDATE',
                  style: TextStyle(
                      fontSize: 16,
                      color: darkMode.colorScheme.inversePrimary)),
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
        iconTheme: IconThemeData(
          color: darkMode.colorScheme.inversePrimary,
        ),
        actions: selectedLogIndex != null
            ? [
                IconButton(
                  onPressed: () {
                    showUpdateLogDialog(selectedLogIndex!);
                  },
                  icon: const Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: () async {
                    final log = logWithSets[selectedLogIndex!].log;
                    final sets = logWithSets[selectedLogIndex!].sets;
                    final dt = log.dt;
                    final dateStr =
                        '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}';
                    final timeStr =
                        '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
                    await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: darkMode.colorScheme.primary,
                        title: Text('Delete this log?',
                            style: TextStyle(
                                color: darkMode.colorScheme.inversePrimary)),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Card(
                              color: Colors.grey[900],
                              margin: const EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 2),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text('$dateStr $timeStr',
                                            style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14)),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: List.generate(sets.length,
                                          (setIndex) {
                                        final set = sets[setIndex];
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 2.0),
                                          child: Text(
                                            'Set ${setIndex + 1}: Weight: ${set.weight}, Reps: ${set.reps}',
                                            style: TextStyle(
                                              color: darkMode
                                                  .colorScheme.inversePrimary,
                                              fontSize: 18,
                                            ),
                                          ),
                                        );
                                      }),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text('Are you sure you want to delete this log?',
                                style: TextStyle(
                                    color:
                                        darkMode.colorScheme.inversePrimary)),
                          ],
                        ),
                        actions: [
                          Row(
                            children: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('CANCEL',
                                    style: TextStyle(
                                        color: darkMode
                                            .colorScheme.inversePrimary)),
                              ),
                              Spacer(),
                              TextButton(
                                onPressed: () async {
                                  Navigator.pop(context);
                                  await db.deleteLogWithSets(log.logID);
                                  await fetchLogsandSets();
                                  setState(() {
                                    selectedLogIndex = null;
                                  });
                                },
                                child: Text('DELETE',
                                    style: TextStyle(color: Colors.red)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  icon: const Icon(Icons.delete),
                ),
              ]
            : [],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: darkMode.colorScheme.inversePrimary,
                ),
                borderRadius: BorderRadius.circular(10),
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
            const SizedBox(height: 6),
            Expanded(
              child: logWithSets.isEmpty
                  ? Center(
                      child: Text(
                        'No logs yet.',
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: logWithSets.length,
                      itemBuilder: (context, logIndex) {
                        final displayIndex = logWithSets.length - 1 - logIndex;
                        final logWithSet = logWithSets[displayIndex];
                        final log = logWithSet.log;
                        final sets = logWithSet.sets;
                        final dt = log.dt;
                        final dateStr =
                            '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}';
                        final timeStr =
                            '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
                        final isSelected = selectedLogIndex == displayIndex;
                        return GestureDetector(
                          onLongPress: () {
                            setState(() {
                              selectedLogIndex = displayIndex;
                            });
                          },
                          onTap: () {
                            setState(() {
                              selectedLogIndex = null;
                            });
                          },
                          child: Card(
                            color: isSelected
                                ? Colors.grey[800]
                                : Colors.grey[900],
                            margin: const EdgeInsets.symmetric(
                                vertical: 6, horizontal: 2),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
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
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children:
                                        List.generate(sets.length, (setIndex) {
                                      final set = sets[setIndex];
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 2.0),
                                        child: Text(
                                          'Set ${setIndex + 1}: Weight: ${set.weight}, Reps: ${set.reps}',
                                          style: TextStyle(
                                            color: darkMode
                                                .colorScheme.inversePrimary,
                                            fontSize: 18,
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                ],
                              ),
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
