import 'package:drift/drift.dart';

//the following is stitched together like as if its in a json format so you can modify it later to make it easier to access data
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
}

class LogSets extends Table {
  IntColumn get setID => integer().autoIncrement()();
  IntColumn get logID => integer().references(Logs, #logID)();
  RealColumn get weight => real()();
  IntColumn get reps => integer()();
}
