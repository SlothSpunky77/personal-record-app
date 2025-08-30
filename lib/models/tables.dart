import 'package:drift/drift.dart';

class MuscleGroups extends Table {
  IntColumn get groupID => integer().autoIncrement()();
  TextColumn get groupName => text()();
  IntColumn get color => integer()();
}

class Workouts extends Table {
  IntColumn get workoutID => integer().autoIncrement()();
  IntColumn get groupID => integer().references(MuscleGroups, #groupID)();
  TextColumn get name => text()();
}

class Logs extends Table {
  IntColumn get logID => integer().autoIncrement()();
  IntColumn get workoutID => integer().references(Workouts, #workoutID)();
  DateTimeColumn get dt => dateTime()();
  TextColumn get note => text().nullable()();
}

class LogSets extends Table {
  IntColumn get setID => integer().autoIncrement()();
  IntColumn get logID => integer().references(Logs, #logID)();
  RealColumn get weight => real()();
  IntColumn get reps => integer()();
}

class PersonalRecords extends Table {
  IntColumn get prID => integer().autoIncrement()();
  IntColumn get workoutID => integer().references(Workouts, #workoutID)();
  RealColumn get maxWeight => real()(); // Highest weight for at least 1 rep
  IntColumn get maxWeightReps => integer()(); // Reps for the max weight
  RealColumn get maxVolumeWeight =>
      real()(); // Weight component of the highest volume set
  IntColumn get maxVolumeReps => integer()(); // Reps for the max volume set
  DateTimeColumn get maxWeightDate =>
      dateTime()(); // When max weight was achieved
  DateTimeColumn get maxVolumeDate =>
      dateTime()(); // When max volume was achieved
}
