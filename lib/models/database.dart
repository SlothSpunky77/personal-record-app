import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pr/models/tables.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

@DriftDatabase(
  tables: [MuscleGroups, Workouts, Logs, LogSets],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  newGroup(String textInput, int colorInput) async {
    final groupID = await into(muscleGroups).insert(MuscleGroupsCompanion(
        groupName: Value(textInput), color: Value(colorInput)));
  }

  Future<List<MuscleGroup>> fetchGroups() async {
    //fetch all groups
    return await select(muscleGroups).get();
  }

  // fetchGroup(int id) {
  //   //fetch a single group by id
  //   return select(muscleGroups)..where((table) => table.groupID.equals(id));
  // }

  updateGroup(int id, String newTextInput) async {
    await (update(muscleGroups)..where((table) => table.groupID.equals(id)))
        .write(
      MuscleGroupsCompanion(groupName: Value(newTextInput)),
    );
  }

  deleteGroup(int id) async {
    await (delete(muscleGroups)..where((table) => table.groupID.equals(id)))
        .go();
    await (delete(workouts)..where((table) => table.groupID.equals(id))).go();
    //delete everything else from other tables also
  }

  newWorkout(int groupID, String name) async {
    return await into(workouts).insert(
      WorkoutsCompanion(
        groupID: Value(groupID),
        name: Value(name),
      ),
    );
  }

  Future<List<Workout>> fetchWorkouts(int groupId) async {
    return await (select(workouts)
          ..where((table) => table.groupID.equals(groupId)))
        .get();
  }

  updateWorkout(int entryID, String newName) async {
    await (update(workouts)..where((table) => table.workoutID.equals(entryID)))
        .write(
      WorkoutsCompanion(name: Value(newName)),
    );
  }

  deleteWorkoutItem(int id) async {
    await (delete(workouts)..where((table) => table.workoutID.equals(id))).go();
  }

  Future<List<Log>> fetchLogs(int workoutId) async {
    return await (select(logs)
          ..where((table) => table.workoutID.equals(workoutId)))
        .get();
  }

  Future<List<LogSet>> fetchLogSets(int logId) async {
    return await (select(logSets)..where((table) => table.logID.equals(logId)))
        .get();
  }

  Future<void> addLogWithSets(
      int workoutId, List<LogSetsCompanion> sets) async {
    final logId = await into(logs).insert(
      LogsCompanion(
        workoutID: Value(workoutId),
        dt: Value(DateTime.now()),
      ),
    );
    for (final set in sets) {
      await into(logSets).insert(
        set.copyWith(logID: Value(logId)),
      );
    }
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'pr.db'));
    return NativeDatabase(file);
  });
}
