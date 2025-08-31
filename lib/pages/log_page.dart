import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:pr/theme/theme.dart';
import 'package:pr/models/database.dart';

class LogPage extends StatefulWidget {
  final String workoutName;
  final int workoutId;
  final int? highlightLogId;
  const LogPage(
      {super.key,
      required this.workoutName,
      required this.workoutId,
      this.highlightLogId});

  @override
  State<LogPage> createState() => _LogPageState();
}

class LogWithSets {
  final Log log;
  final List<LogSet> sets;

  LogWithSets(this.log, this.sets);
}

class _SetInput {
  final TextEditingController weightController = TextEditingController();
  final TextEditingController repsController = TextEditingController();
}

class _LogPageState extends State<LogPage> {
  List<Log> logs = [];
  List<LogWithSets> logWithSets = [];
  List<_SetInput> setInputs = [_SetInput()];
  final db = AppDatabase();
  int? selectedLogIndex;
  TextEditingController noteController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    fetchLogsandSets();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> fetchLogsandSets() async {
    logWithSets.clear();
    logs = await db.fetchLogs(widget.workoutId);
    for (Log log in logs) {
      List<LogSet> sets = await db.fetchLogSets(log.logID);
      logWithSets.add(LogWithSets(log, sets));
    }
    setState(() {});

    // Auto-scroll to highlighted log if specified
    if (widget.highlightLogId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToHighlightedLog();
      });
    }
  }

  void _scrollToHighlightedLog() {
    if (widget.highlightLogId == null || logWithSets.isEmpty) return;

    // Reverse the list to match the display order
    final reversedLogWithSets = logWithSets.reversed.toList();

    // Find the index of the highlighted log
    final highlightIndex = reversedLogWithSets.indexWhere(
      (logWithSet) => logWithSet.log.logID == widget.highlightLogId,
    );

    if (highlightIndex != -1 && _scrollController.hasClients) {
      // Add a small delay to ensure the list is fully rendered
      Future.delayed(const Duration(milliseconds: 50), () {
        if (_scrollController.hasClients) {
          // Calculate position - each item is approximately 120-150 pixels tall
          // We'll use a conservative estimate and scroll a bit above the target
          final double itemHeight = 160.0;
          final double targetPosition =
              ((highlightIndex + 1 + 20) * itemHeight).clamp(
            0.0,
            _scrollController.position.maxScrollExtent,
          );

          // Scroll to the highlighted log with animation
          _scrollController.animateTo(
            targetPosition,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      });
    }
  }

  Future<void> addLogs() async {
    final sets = setInputs
        .map((input) => LogSetsCompanion(
              weight: Value(double.tryParse(input.weightController.text) ?? 0),
              reps: Value(int.tryParse(input.repsController.text) ?? 0),
            ))
        .toList();
    await db.addLogWithSets(widget.workoutId, sets,
        note: noteController.text.isNotEmpty ? noteController.text : null);
    setInputs = [_SetInput()];
    noteController.clear();
    await fetchLogsandSets();
    Navigator.of(context).pop();
  }

  void createLogDialog() {
    noteController.clear();
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
            width: 300,
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
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove_circle,
                                color: Colors.red),
                            onPressed: setInputs.length > 1
                                ? () {
                                    setStateDialog(() {
                                      setInputs.removeAt(index);
                                    });
                                  }
                                : null,
                          ),
                          IconButton(
                            onPressed: () {
                              double weight = double.tryParse(
                                      setInputs[index].weightController.text) ??
                                  0;
                              int reps = int.tryParse(
                                      setInputs[index].repsController.text) ??
                                  0;
                              setStateDialog(
                                () {
                                  setInputs.add(_SetInput()
                                    ..weightController.text = weight.toString()
                                    ..repsController.text = reps.toString());
                                },
                              );
                            },
                            icon: Icon(
                              Icons.control_point_duplicate,
                              color: darkMode.colorScheme.inversePrimary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
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
                  ),
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Notes, if any:",
                    style: TextStyle(
                      color: darkMode.colorScheme.inversePrimary,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                TextField(
                  controller: noteController,
                  maxLines: 2,
                  style: TextStyle(color: darkMode.colorScheme.inversePrimary),
                  decoration: InputDecoration(
                    hintText: 'Any thoughts?',
                    hintStyle: TextStyle(color: darkMode.colorScheme.primary),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
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
    TextEditingController updateNoteController =
        TextEditingController(text: log.note ?? '');
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setStateDialog) => AlertDialog(
          backgroundColor: darkMode.colorScheme.secondary,
          title: Text('Update Sets',
              style: TextStyle(
                  fontSize: 22, color: darkMode.colorScheme.inversePrimary)),
          content: SizedBox(
            width: 300,
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
                      IconButton(
                        onPressed: () {
                          double weight = double.tryParse(
                                  updateInputs[index].weightController.text) ??
                              0;
                          int reps = int.tryParse(
                                  updateInputs[index].repsController.text) ??
                              0;
                          setStateDialog(
                            () {
                              updateInputs.add(_SetInput()
                                ..weightController.text = weight.toString()
                                ..repsController.text = reps.toString());
                            },
                          );
                        },
                        icon: Icon(
                          Icons.control_point_duplicate,
                          color: darkMode.colorScheme.inversePrimary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
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
                SizedBox(height: 5),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Your notes:",
                      style: TextStyle(
                          color: darkMode.colorScheme.inversePrimary,
                          fontSize: 16)),
                ),
                TextField(
                  controller: updateNoteController,
                  maxLines: 2,
                  style: TextStyle(color: darkMode.colorScheme.inversePrimary),
                  decoration: InputDecoration(
                    hintText: 'Notes, if any',
                    hintStyle: TextStyle(color: darkMode.colorScheme.primary),
                    border: OutlineInputBorder(),
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
                await db.updateLogWithSets(log.logID, updatedSets,
                    note: updateNoteController.text.isNotEmpty
                        ? updateNoteController.text
                        : null);
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

  void deleteLogDialog(int logIndex) {
    final log = logWithSets[logIndex].log;
    final sets = logWithSets[logIndex].sets;
    final dt = log.dt;
    final dateStr =
        '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}';
    final timeStr =
        '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: darkMode.colorScheme.primary,
        title: Text('Delete this log?',
            style: TextStyle(color: darkMode.colorScheme.inversePrimary)),
        content: SizedBox(
          width: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                color: Colors.grey[900],
                margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 2),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('$dateStr $timeStr',
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 14)),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...List.generate(sets.length, (setIndex) {
                            final set = sets[setIndex];
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 2.0),
                              child: Text(
                                'Set ${setIndex + 1}: Weight: ${set.weight}, Reps: ${set.reps}',
                                style: TextStyle(
                                  color: darkMode.colorScheme.inversePrimary,
                                  fontSize: 18,
                                ),
                              ),
                            );
                          }),
                          if (log.note != null && log.note!.isNotEmpty) ...[
                            const SizedBox(height: 8),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 10,
                                right: 10,
                              ),
                              child: Text(
                                'Note: ${log.note}',
                                style: TextStyle(
                                  color: Colors.amber[200],
                                  fontSize: 15,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text('Are you sure you want to delete this log?',
                  style: TextStyle(color: darkMode.colorScheme.inversePrimary)),
            ],
          ),
        ),
        actions: [
          Row(
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('CANCEL',
                    style:
                        TextStyle(color: darkMode.colorScheme.inversePrimary)),
              ),
              Spacer(),
              TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                  await db.deleteLogWithSets(log.logID);
                  selectedLogIndex = null;

                  await fetchLogsandSets();
                },
                child: Text('DELETE', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        ],
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
                  onPressed: () {
                    deleteLogDialog(selectedLogIndex!);
                  },
                  icon: const Icon(Icons.delete),
                ),
              ]
            : [],
      ),
      body: GestureDetector(
        onTap: () {
          if (selectedLogIndex != null) {
            setState(() {
              selectedLogIndex = null;
            });
          }
        },
        child: DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage("assets/images/personal_record.png"),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                const Color.fromARGB(255, 0, 0, 0).withOpacity(0.8),
                BlendMode.srcATop,
              ),
            ),
          ),
          child: Padding(
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
                      : Builder(builder: (context) {
                          logWithSets = logWithSets.reversed.toList();

                          return ListView.builder(
                            controller: _scrollController,
                            itemCount: logWithSets.length,
                            itemBuilder: (context, logIndex) {
                              final logWithSet = logWithSets[logIndex];
                              final log = logWithSet.log;
                              final sets = logWithSet.sets;
                              final dt = log.dt;
                              final dateStr =
                                  '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}';
                              final timeStr =
                                  '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
                              final isSelected = selectedLogIndex == logIndex;
                              return GestureDetector(
                                onLongPress: () {
                                  setState(() {
                                    selectedLogIndex = logIndex;
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
                                  child: Container(
                                    decoration: widget.highlightLogId != null &&
                                            log.logID == widget.highlightLogId
                                        ? BoxDecoration(
                                            border: Border.all(
                                              color: darkMode
                                                  .colorScheme.inversePrimary,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          )
                                        : null,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                '$dateStr $timeStr',
                                                style: const TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 14),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: List.generate(sets.length,
                                                (setIndex) {
                                              final set = sets[setIndex];
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 2.0),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      'Set ${setIndex + 1}:',
                                                      style: TextStyle(
                                                          color: darkMode
                                                              .colorScheme
                                                              .inversePrimary,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    Text(
                                                      ' Weight: ${set.weight}, Reps: ${set.reps}',
                                                      style: TextStyle(
                                                        color: darkMode
                                                            .colorScheme
                                                            .inversePrimary,
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }),
                                          ),
                                          if (log.note != null &&
                                              log.note!.isNotEmpty) ...[
                                            const SizedBox(height: 5),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10, right: 10),
                                              child: Text(
                                                'Note: ${log.note}',
                                                style: TextStyle(
                                                  color: Colors.amber[200],
                                                  fontSize: 15,
                                                  fontStyle: FontStyle.italic,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
