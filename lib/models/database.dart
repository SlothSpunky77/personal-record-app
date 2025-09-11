import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pr/models/tables.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

@DriftDatabase(
  tables: [MuscleGroups, Workouts, Logs, LogSets, PersonalRecords],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 11;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onUpgrade: (m, from, to) async {
          if (from == 1) {
            await m.addColumn(logs, logs.note);
          } else if (from == 2) {
            await m.addColumn(logs, logs.note);
            await customStatement('UPDATE logs SET note = notes');
          } else if (from == 3) {
            await m.createTable(personalRecords);
          } else if (from == 4) {
            // Calculate PRs for all existing workouts
            await _calculateExistingPRs();
          } else if (from == 5) {
            // Drop and recreate PersonalRecords table with new schema
            await m.deleteTable('personal_records');
            await m.createTable(personalRecords);
            // Recalculate all PRs with the new schema
            await _calculateExistingPRs();
          } else if (from == 6 || from == 7 || from == 8 || from == 9) {
            await _calculateExistingPRs();
          } else if (from == 10) {}
          // Clear ALL PR records and recalculate from scratch
          await customStatement('DELETE FROM personal_records');
          await _calculateExistingPRs();
        },
      );

  // Calculate PRs for existing workouts during migration
  Future<void> _calculateExistingPRs() async {
    // Get all workouts from all muscle groups
    final allGroups = await select(muscleGroups).get();

    for (final group in allGroups) {
      final workouts = await (select(this.workouts)
            ..where((table) => table.groupID.equals(group.groupID)))
          .get();

      for (final workout in workouts) {
        // Get all logs for this workout
        final logs = await (select(this.logs)
              ..where((table) => table.workoutID.equals(workout.workoutID)))
            .get();

        if (logs.isEmpty) continue;

        double maxWeight = -1;
        double maxVolumeTotal = -1;
        double maxVolumeWeight = -1;
        int maxWeightReps = -1;
        int maxVolumeReps = -1;
        DateTime? maxWeightDate;
        DateTime? maxVolumeDate;

        // Check all logs for this workout
        for (final log in logs) {
          final sets = await (select(logSets)
                ..where((table) => table.logID.equals(log.logID)))
              .get();

          // Check all sets in this log
          for (final set in sets) {
            final weight = set.weight;
            final reps = set.reps;
            final volume = weight * reps;

            // Check for new weight PR
            if (weight > maxWeight) {
              maxWeight = weight;
              maxWeightReps = reps;
              maxWeightDate = log.dt;
            } else if (weight == maxWeight) {
              if (reps > maxWeightReps) {
                maxWeightReps = reps;
                maxWeightDate = log.dt;
              }
            }

            // Check for new volume PR
            if (volume > maxVolumeTotal) {
              maxVolumeTotal = volume;
              maxVolumeWeight = weight;
              maxVolumeReps = reps;
              maxVolumeDate = log.dt;
            }
          }
        }

        // Only create PR record if we found valid data
        if (maxWeight >= 0 &&
            maxVolumeTotal >= 0 &&
            maxWeightDate != null &&
            maxVolumeDate != null) {
          await into(personalRecords).insert(
            PersonalRecordsCompanion(
              workoutID: Value(workout.workoutID),
              maxWeight: Value(maxWeight),
              maxWeightReps: Value(maxWeightReps),
              maxVolumeWeight: Value(maxVolumeWeight),
              maxVolumeReps: Value(maxVolumeReps),
              maxWeightDate: Value(maxWeightDate),
              maxVolumeDate: Value(maxVolumeDate),
            ),
          );
        }
      }
    }
  }

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
      // Delete PR records for this workout first
      await deletePersonalRecord(workout.workoutID);

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
    // Delete PR records for this workout first
    await deletePersonalRecord(id);

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

    // Update personal records after adding the sets
    await updatePersonalRecords(workoutId, sets);
  }

  Future<void> deleteLogWithSets(int logId) async {
    await (delete(logSets)..where((table) => table.logID.equals(logId))).go();
    await (delete(logs)..where((table) => table.logID.equals(logId))).go();
  }

  Future<void> updateLogWithSets(int logId, List<LogSetsCompanion> updatedSets,
      {String? note}) async {
    // Get the workoutID for this log to update PRs
    final log = await (select(logs)
          ..where((table) => table.logID.equals(logId)))
        .getSingle();

    // Update the notes for the log
    await (update(logs)..where((table) => table.logID.equals(logId))).write(
      LogsCompanion(note: Value(note)),
    );
    // Replace sets
    await (delete(logSets)..where((table) => table.logID.equals(logId))).go();
    for (final set in updatedSets) {
      await into(logSets).insert(set.copyWith(logID: Value(logId)));
    }

    // Update personal records after updating the sets
    await updatePersonalRecords(log.workoutID, updatedSets);
  }

  // Personal Records Methods
  Future<PersonalRecord?> fetchPersonalRecord(int workoutId) async {
    final query = select(personalRecords)
      ..where((table) => table.workoutID.equals(workoutId));
    final results = await query.get();
    return results.isNotEmpty ? results.first : null;
  }

  Future<List<PersonalRecord>> fetchAllPersonalRecords() async {
    return await select(personalRecords).get();
  }

  Future<void> updatePersonalRecords(
      int workoutId, List<LogSetsCompanion> sets) async {
    // Calculate max weight and max volume from the current sets
    double maxWeight = -1;
    double maxVolumeTotal = -1;
    double maxVolumeWeight = -1;
    int maxWeightReps = -1;
    int maxVolumeReps = -1;

    for (final set in sets) {
      final weight = set.weight.value;
      final reps = set.reps.value;
      final volume = weight * reps;

      if (weight > maxWeight) {
        maxWeight = weight;
        maxWeightReps = reps;
      } else if (weight == maxWeight) {
        if (reps > maxWeightReps) {
          maxWeightReps = reps;
        }
      }
      if (volume > maxVolumeTotal) {
        maxVolumeTotal = volume;
        maxVolumeWeight = weight;
        maxVolumeReps = reps;
      }
    }

    // Get existing PR record
    final existingPR = await fetchPersonalRecord(workoutId);
    final now = DateTime.now();

    if (existingPR == null) {
      // Create new PR record
      await into(personalRecords).insert(
        PersonalRecordsCompanion(
          workoutID: Value(workoutId),
          maxWeight: Value(maxWeight),
          maxWeightReps: Value(maxWeightReps),
          maxVolumeWeight: Value(maxVolumeWeight),
          maxVolumeReps: Value(maxVolumeReps),
          maxWeightDate: Value(now),
          maxVolumeDate: Value(now),
        ),
      );
    } else {
      // Update existing PR record if new records are achieved
      bool weightPRBroken = maxWeight > existingPR.maxWeight ||
          (maxWeight == existingPR.maxWeight &&
              maxWeightReps > existingPR.maxWeightReps);
      bool volumePRBroken = maxVolumeTotal >
          (existingPR.maxVolumeWeight * existingPR.maxVolumeReps);

      if (weightPRBroken || volumePRBroken) {
        await (update(personalRecords)
              ..where((table) => table.workoutID.equals(workoutId)))
            .write(
          PersonalRecordsCompanion(
            maxWeight: Value(weightPRBroken ? maxWeight : existingPR.maxWeight),
            maxWeightReps: Value(
                weightPRBroken ? maxWeightReps : existingPR.maxWeightReps),
            maxVolumeWeight: Value(
                volumePRBroken ? maxVolumeWeight : existingPR.maxVolumeWeight),
            maxVolumeReps: Value(
                volumePRBroken ? maxVolumeReps : existingPR.maxVolumeReps),
            maxWeightDate:
                Value(weightPRBroken ? now : existingPR.maxWeightDate),
            maxVolumeDate:
                Value(volumePRBroken ? now : existingPR.maxVolumeDate),
          ),
        );
      }
    }
  }

  Future<void> deletePersonalRecord(int workoutId) async {
    await (delete(personalRecords)
          ..where((table) => table.workoutID.equals(workoutId)))
        .go();
  }

  //debug, TODO: remove it later
// Add to AppDatabase class
  Future<void> debugPrintAllPRRecords() async {
    print('=== ALL PERSONAL RECORDS ===');
    final records = await select(personalRecords).get();

    if (records.isEmpty) {
      print('No PR records found');
      return;
    }

    for (final pr in records) {
      print('PR ID: ${pr.prID}');
      print('  Workout ID: ${pr.workoutID}');
      print('  Max Weight: ${pr.maxWeight} kg (${pr.maxWeightReps} reps)');
      print(
          '  Max Volume: ${pr.maxVolumeWeight} kg × ${pr.maxVolumeReps} reps = ${pr.maxVolumeWeight * pr.maxVolumeReps}');
      print('  Max Weight Date: ${pr.maxWeightDate}');
      print('  Max Volume Date: ${pr.maxVolumeDate}');
      print('---');
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
