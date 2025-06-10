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
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onUpgrade: (m, from, to) async {
          if (from == 1) {
            await m.addColumn(logs, logs.note);
          } else if (from == 2) {
            await m.addColumn(logs, logs.note);
            await customStatement('UPDATE logs SET note = notes');
          }
        },
      );

  newGroup(String textInput, int colorInput) async {
    await into(muscleGroups).insert(MuscleGroupsCompanion(
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
    final groupWorkouts = await (select(workouts)
          ..where((table) => table.groupID.equals(id)))
        .get();
    for (final workout in groupWorkouts) {
      final workoutLogs = await (select(logs)
            ..where((table) => table.workoutID.equals(workout.workoutID)))
          .get();
      for (final log in workoutLogs) {
        await (delete(logSets)..where((table) => table.logID.equals(log.logID)))
            .go();
        await (delete(logs)..where((table) => table.logID.equals(log.logID)))
            .go();
      }
      await (delete(workouts)
            ..where((table) => table.workoutID.equals(workout.workoutID)))
          .go();
    }
    await (delete(muscleGroups)..where((table) => table.groupID.equals(id)))
        .go();
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

  deleteWorkout(int id) async {
    final workoutLogs = await (select(logs)
          ..where((table) => table.workoutID.equals(id)))
        .get();
    for (final log in workoutLogs) {
      await (delete(logSets)..where((table) => table.logID.equals(log.logID)))
          .go();
      await (delete(logs)..where((table) => table.logID.equals(log.logID)))
          .go();
    }
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

  Future<void> addLogWithSets(int workoutId, List<LogSetsCompanion> sets,
      {String? note}) async {
    final logId = await into(logs).insert(
      LogsCompanion(
        workoutID: Value(workoutId),
        dt: Value(DateTime.now()),
        note: Value(note),
      ),
    );
    for (final set in sets) {
      await into(logSets).insert(
        set.copyWith(logID: Value(logId)),
      );
    }
  }

  Future<void> deleteLogWithSets(int logId) async {
    await (delete(logSets)..where((table) => table.logID.equals(logId))).go();
    await (delete(logs)..where((table) => table.logID.equals(logId))).go();
  }

  Future<void> updateLogWithSets(int logId, List<LogSetsCompanion> updatedSets,
      {String? note}) async {
    // Update the notes for the log
    await (update(logs)..where((table) => table.logID.equals(logId))).write(
      LogsCompanion(note: Value(note)),
    );
    // Replace sets
    await (delete(logSets)..where((table) => table.logID.equals(logId))).go();
    for (final set in updatedSets) {
      await into(logSets).insert(set.copyWith(logID: Value(logId)));
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
