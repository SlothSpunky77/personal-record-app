import 'package:isar/isar.dart';
part 'workouts_isar.g.dart';

@collection
class WorkoutDetail {
  late Id workoutID;
  late List<WorkoutEntry> workouts;

  WorkoutDetail({
    required this.workoutID,
    required this.workouts,
  });
}

@embedded
class Sets {
  late double weight;
  late int reps;

  Sets({
    this.weight = 0.0,
    this.reps = 0,
  });
}

@embedded
class Session {
  late DateTime dateTime;
  late List<Sets> sets;

  // Session({
  //   required this.dateTime,
  //   required this.sets,
  // });
}

@embedded
class WorkoutEntry {
  late String name;
  late List<Session> logs;
}
