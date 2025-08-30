// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $MuscleGroupsTable extends MuscleGroups
    with TableInfo<$MuscleGroupsTable, MuscleGroup> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MuscleGroupsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _groupIDMeta =
      const VerificationMeta('groupID');
  @override
  late final GeneratedColumn<int> groupID = GeneratedColumn<int>(
      'group_i_d', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _groupNameMeta =
      const VerificationMeta('groupName');
  @override
  late final GeneratedColumn<String> groupName = GeneratedColumn<String>(
      'group_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<int> color = GeneratedColumn<int>(
      'color', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [groupID, groupName, color];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'muscle_groups';
  @override
  VerificationContext validateIntegrity(Insertable<MuscleGroup> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('group_i_d')) {
      context.handle(_groupIDMeta,
          groupID.isAcceptableOrUnknown(data['group_i_d']!, _groupIDMeta));
    }
    if (data.containsKey('group_name')) {
      context.handle(_groupNameMeta,
          groupName.isAcceptableOrUnknown(data['group_name']!, _groupNameMeta));
    } else if (isInserting) {
      context.missing(_groupNameMeta);
    }
    if (data.containsKey('color')) {
      context.handle(
          _colorMeta, color.isAcceptableOrUnknown(data['color']!, _colorMeta));
    } else if (isInserting) {
      context.missing(_colorMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {groupID};
  @override
  MuscleGroup map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MuscleGroup(
      groupID: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}group_i_d'])!,
      groupName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}group_name'])!,
      color: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}color'])!,
    );
  }

  @override
  $MuscleGroupsTable createAlias(String alias) {
    return $MuscleGroupsTable(attachedDatabase, alias);
  }
}

class MuscleGroup extends DataClass implements Insertable<MuscleGroup> {
  final int groupID;
  final String groupName;
  final int color;
  const MuscleGroup(
      {required this.groupID, required this.groupName, required this.color});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['group_i_d'] = Variable<int>(groupID);
    map['group_name'] = Variable<String>(groupName);
    map['color'] = Variable<int>(color);
    return map;
  }

  MuscleGroupsCompanion toCompanion(bool nullToAbsent) {
    return MuscleGroupsCompanion(
      groupID: Value(groupID),
      groupName: Value(groupName),
      color: Value(color),
    );
  }

  factory MuscleGroup.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MuscleGroup(
      groupID: serializer.fromJson<int>(json['groupID']),
      groupName: serializer.fromJson<String>(json['groupName']),
      color: serializer.fromJson<int>(json['color']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'groupID': serializer.toJson<int>(groupID),
      'groupName': serializer.toJson<String>(groupName),
      'color': serializer.toJson<int>(color),
    };
  }

  MuscleGroup copyWith({int? groupID, String? groupName, int? color}) =>
      MuscleGroup(
        groupID: groupID ?? this.groupID,
        groupName: groupName ?? this.groupName,
        color: color ?? this.color,
      );
  MuscleGroup copyWithCompanion(MuscleGroupsCompanion data) {
    return MuscleGroup(
      groupID: data.groupID.present ? data.groupID.value : this.groupID,
      groupName: data.groupName.present ? data.groupName.value : this.groupName,
      color: data.color.present ? data.color.value : this.color,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MuscleGroup(')
          ..write('groupID: $groupID, ')
          ..write('groupName: $groupName, ')
          ..write('color: $color')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(groupID, groupName, color);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MuscleGroup &&
          other.groupID == this.groupID &&
          other.groupName == this.groupName &&
          other.color == this.color);
}

class MuscleGroupsCompanion extends UpdateCompanion<MuscleGroup> {
  final Value<int> groupID;
  final Value<String> groupName;
  final Value<int> color;
  const MuscleGroupsCompanion({
    this.groupID = const Value.absent(),
    this.groupName = const Value.absent(),
    this.color = const Value.absent(),
  });
  MuscleGroupsCompanion.insert({
    this.groupID = const Value.absent(),
    required String groupName,
    required int color,
  })  : groupName = Value(groupName),
        color = Value(color);
  static Insertable<MuscleGroup> custom({
    Expression<int>? groupID,
    Expression<String>? groupName,
    Expression<int>? color,
  }) {
    return RawValuesInsertable({
      if (groupID != null) 'group_i_d': groupID,
      if (groupName != null) 'group_name': groupName,
      if (color != null) 'color': color,
    });
  }

  MuscleGroupsCompanion copyWith(
      {Value<int>? groupID, Value<String>? groupName, Value<int>? color}) {
    return MuscleGroupsCompanion(
      groupID: groupID ?? this.groupID,
      groupName: groupName ?? this.groupName,
      color: color ?? this.color,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (groupID.present) {
      map['group_i_d'] = Variable<int>(groupID.value);
    }
    if (groupName.present) {
      map['group_name'] = Variable<String>(groupName.value);
    }
    if (color.present) {
      map['color'] = Variable<int>(color.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MuscleGroupsCompanion(')
          ..write('groupID: $groupID, ')
          ..write('groupName: $groupName, ')
          ..write('color: $color')
          ..write(')'))
        .toString();
  }
}

class $WorkoutsTable extends Workouts with TableInfo<$WorkoutsTable, Workout> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkoutsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _workoutIDMeta =
      const VerificationMeta('workoutID');
  @override
  late final GeneratedColumn<int> workoutID = GeneratedColumn<int>(
      'workout_i_d', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _groupIDMeta =
      const VerificationMeta('groupID');
  @override
  late final GeneratedColumn<int> groupID = GeneratedColumn<int>(
      'group_i_d', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES muscle_groups (group_i_d)'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [workoutID, groupID, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workouts';
  @override
  VerificationContext validateIntegrity(Insertable<Workout> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('workout_i_d')) {
      context.handle(
          _workoutIDMeta,
          workoutID.isAcceptableOrUnknown(
              data['workout_i_d']!, _workoutIDMeta));
    }
    if (data.containsKey('group_i_d')) {
      context.handle(_groupIDMeta,
          groupID.isAcceptableOrUnknown(data['group_i_d']!, _groupIDMeta));
    } else if (isInserting) {
      context.missing(_groupIDMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {workoutID};
  @override
  Workout map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Workout(
      workoutID: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}workout_i_d'])!,
      groupID: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}group_i_d'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $WorkoutsTable createAlias(String alias) {
    return $WorkoutsTable(attachedDatabase, alias);
  }
}

class Workout extends DataClass implements Insertable<Workout> {
  final int workoutID;
  final int groupID;
  final String name;
  const Workout(
      {required this.workoutID, required this.groupID, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['workout_i_d'] = Variable<int>(workoutID);
    map['group_i_d'] = Variable<int>(groupID);
    map['name'] = Variable<String>(name);
    return map;
  }

  WorkoutsCompanion toCompanion(bool nullToAbsent) {
    return WorkoutsCompanion(
      workoutID: Value(workoutID),
      groupID: Value(groupID),
      name: Value(name),
    );
  }

  factory Workout.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Workout(
      workoutID: serializer.fromJson<int>(json['workoutID']),
      groupID: serializer.fromJson<int>(json['groupID']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'workoutID': serializer.toJson<int>(workoutID),
      'groupID': serializer.toJson<int>(groupID),
      'name': serializer.toJson<String>(name),
    };
  }

  Workout copyWith({int? workoutID, int? groupID, String? name}) => Workout(
        workoutID: workoutID ?? this.workoutID,
        groupID: groupID ?? this.groupID,
        name: name ?? this.name,
      );
  Workout copyWithCompanion(WorkoutsCompanion data) {
    return Workout(
      workoutID: data.workoutID.present ? data.workoutID.value : this.workoutID,
      groupID: data.groupID.present ? data.groupID.value : this.groupID,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Workout(')
          ..write('workoutID: $workoutID, ')
          ..write('groupID: $groupID, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(workoutID, groupID, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Workout &&
          other.workoutID == this.workoutID &&
          other.groupID == this.groupID &&
          other.name == this.name);
}

class WorkoutsCompanion extends UpdateCompanion<Workout> {
  final Value<int> workoutID;
  final Value<int> groupID;
  final Value<String> name;
  const WorkoutsCompanion({
    this.workoutID = const Value.absent(),
    this.groupID = const Value.absent(),
    this.name = const Value.absent(),
  });
  WorkoutsCompanion.insert({
    this.workoutID = const Value.absent(),
    required int groupID,
    required String name,
  })  : groupID = Value(groupID),
        name = Value(name);
  static Insertable<Workout> custom({
    Expression<int>? workoutID,
    Expression<int>? groupID,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (workoutID != null) 'workout_i_d': workoutID,
      if (groupID != null) 'group_i_d': groupID,
      if (name != null) 'name': name,
    });
  }

  WorkoutsCompanion copyWith(
      {Value<int>? workoutID, Value<int>? groupID, Value<String>? name}) {
    return WorkoutsCompanion(
      workoutID: workoutID ?? this.workoutID,
      groupID: groupID ?? this.groupID,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (workoutID.present) {
      map['workout_i_d'] = Variable<int>(workoutID.value);
    }
    if (groupID.present) {
      map['group_i_d'] = Variable<int>(groupID.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutsCompanion(')
          ..write('workoutID: $workoutID, ')
          ..write('groupID: $groupID, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $LogsTable extends Logs with TableInfo<$LogsTable, Log> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _logIDMeta = const VerificationMeta('logID');
  @override
  late final GeneratedColumn<int> logID = GeneratedColumn<int>(
      'log_i_d', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _workoutIDMeta =
      const VerificationMeta('workoutID');
  @override
  late final GeneratedColumn<int> workoutID = GeneratedColumn<int>(
      'workout_i_d', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES workouts (workout_i_d)'));
  static const VerificationMeta _dtMeta = const VerificationMeta('dt');
  @override
  late final GeneratedColumn<DateTime> dt = GeneratedColumn<DateTime>(
      'dt', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [logID, workoutID, dt, note];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'logs';
  @override
  VerificationContext validateIntegrity(Insertable<Log> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('log_i_d')) {
      context.handle(_logIDMeta,
          logID.isAcceptableOrUnknown(data['log_i_d']!, _logIDMeta));
    }
    if (data.containsKey('workout_i_d')) {
      context.handle(
          _workoutIDMeta,
          workoutID.isAcceptableOrUnknown(
              data['workout_i_d']!, _workoutIDMeta));
    } else if (isInserting) {
      context.missing(_workoutIDMeta);
    }
    if (data.containsKey('dt')) {
      context.handle(_dtMeta, dt.isAcceptableOrUnknown(data['dt']!, _dtMeta));
    } else if (isInserting) {
      context.missing(_dtMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {logID};
  @override
  Log map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Log(
      logID: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}log_i_d'])!,
      workoutID: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}workout_i_d'])!,
      dt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}dt'])!,
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note']),
    );
  }

  @override
  $LogsTable createAlias(String alias) {
    return $LogsTable(attachedDatabase, alias);
  }
}

class Log extends DataClass implements Insertable<Log> {
  final int logID;
  final int workoutID;
  final DateTime dt;
  final String? note;
  const Log(
      {required this.logID,
      required this.workoutID,
      required this.dt,
      this.note});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['log_i_d'] = Variable<int>(logID);
    map['workout_i_d'] = Variable<int>(workoutID);
    map['dt'] = Variable<DateTime>(dt);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  LogsCompanion toCompanion(bool nullToAbsent) {
    return LogsCompanion(
      logID: Value(logID),
      workoutID: Value(workoutID),
      dt: Value(dt),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory Log.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Log(
      logID: serializer.fromJson<int>(json['logID']),
      workoutID: serializer.fromJson<int>(json['workoutID']),
      dt: serializer.fromJson<DateTime>(json['dt']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'logID': serializer.toJson<int>(logID),
      'workoutID': serializer.toJson<int>(workoutID),
      'dt': serializer.toJson<DateTime>(dt),
      'note': serializer.toJson<String?>(note),
    };
  }

  Log copyWith(
          {int? logID,
          int? workoutID,
          DateTime? dt,
          Value<String?> note = const Value.absent()}) =>
      Log(
        logID: logID ?? this.logID,
        workoutID: workoutID ?? this.workoutID,
        dt: dt ?? this.dt,
        note: note.present ? note.value : this.note,
      );
  Log copyWithCompanion(LogsCompanion data) {
    return Log(
      logID: data.logID.present ? data.logID.value : this.logID,
      workoutID: data.workoutID.present ? data.workoutID.value : this.workoutID,
      dt: data.dt.present ? data.dt.value : this.dt,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Log(')
          ..write('logID: $logID, ')
          ..write('workoutID: $workoutID, ')
          ..write('dt: $dt, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(logID, workoutID, dt, note);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Log &&
          other.logID == this.logID &&
          other.workoutID == this.workoutID &&
          other.dt == this.dt &&
          other.note == this.note);
}

class LogsCompanion extends UpdateCompanion<Log> {
  final Value<int> logID;
  final Value<int> workoutID;
  final Value<DateTime> dt;
  final Value<String?> note;
  const LogsCompanion({
    this.logID = const Value.absent(),
    this.workoutID = const Value.absent(),
    this.dt = const Value.absent(),
    this.note = const Value.absent(),
  });
  LogsCompanion.insert({
    this.logID = const Value.absent(),
    required int workoutID,
    required DateTime dt,
    this.note = const Value.absent(),
  })  : workoutID = Value(workoutID),
        dt = Value(dt);
  static Insertable<Log> custom({
    Expression<int>? logID,
    Expression<int>? workoutID,
    Expression<DateTime>? dt,
    Expression<String>? note,
  }) {
    return RawValuesInsertable({
      if (logID != null) 'log_i_d': logID,
      if (workoutID != null) 'workout_i_d': workoutID,
      if (dt != null) 'dt': dt,
      if (note != null) 'note': note,
    });
  }

  LogsCompanion copyWith(
      {Value<int>? logID,
      Value<int>? workoutID,
      Value<DateTime>? dt,
      Value<String?>? note}) {
    return LogsCompanion(
      logID: logID ?? this.logID,
      workoutID: workoutID ?? this.workoutID,
      dt: dt ?? this.dt,
      note: note ?? this.note,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (logID.present) {
      map['log_i_d'] = Variable<int>(logID.value);
    }
    if (workoutID.present) {
      map['workout_i_d'] = Variable<int>(workoutID.value);
    }
    if (dt.present) {
      map['dt'] = Variable<DateTime>(dt.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LogsCompanion(')
          ..write('logID: $logID, ')
          ..write('workoutID: $workoutID, ')
          ..write('dt: $dt, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }
}

class $LogSetsTable extends LogSets with TableInfo<$LogSetsTable, LogSet> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LogSetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _setIDMeta = const VerificationMeta('setID');
  @override
  late final GeneratedColumn<int> setID = GeneratedColumn<int>(
      'set_i_d', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _logIDMeta = const VerificationMeta('logID');
  @override
  late final GeneratedColumn<int> logID = GeneratedColumn<int>(
      'log_i_d', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES logs (log_i_d)'));
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<double> weight = GeneratedColumn<double>(
      'weight', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _repsMeta = const VerificationMeta('reps');
  @override
  late final GeneratedColumn<int> reps = GeneratedColumn<int>(
      'reps', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [setID, logID, weight, reps];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'log_sets';
  @override
  VerificationContext validateIntegrity(Insertable<LogSet> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('set_i_d')) {
      context.handle(_setIDMeta,
          setID.isAcceptableOrUnknown(data['set_i_d']!, _setIDMeta));
    }
    if (data.containsKey('log_i_d')) {
      context.handle(_logIDMeta,
          logID.isAcceptableOrUnknown(data['log_i_d']!, _logIDMeta));
    } else if (isInserting) {
      context.missing(_logIDMeta);
    }
    if (data.containsKey('weight')) {
      context.handle(_weightMeta,
          weight.isAcceptableOrUnknown(data['weight']!, _weightMeta));
    } else if (isInserting) {
      context.missing(_weightMeta);
    }
    if (data.containsKey('reps')) {
      context.handle(
          _repsMeta, reps.isAcceptableOrUnknown(data['reps']!, _repsMeta));
    } else if (isInserting) {
      context.missing(_repsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {setID};
  @override
  LogSet map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LogSet(
      setID: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}set_i_d'])!,
      logID: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}log_i_d'])!,
      weight: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}weight'])!,
      reps: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}reps'])!,
    );
  }

  @override
  $LogSetsTable createAlias(String alias) {
    return $LogSetsTable(attachedDatabase, alias);
  }
}

class LogSet extends DataClass implements Insertable<LogSet> {
  final int setID;
  final int logID;
  final double weight;
  final int reps;
  const LogSet(
      {required this.setID,
      required this.logID,
      required this.weight,
      required this.reps});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['set_i_d'] = Variable<int>(setID);
    map['log_i_d'] = Variable<int>(logID);
    map['weight'] = Variable<double>(weight);
    map['reps'] = Variable<int>(reps);
    return map;
  }

  LogSetsCompanion toCompanion(bool nullToAbsent) {
    return LogSetsCompanion(
      setID: Value(setID),
      logID: Value(logID),
      weight: Value(weight),
      reps: Value(reps),
    );
  }

  factory LogSet.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LogSet(
      setID: serializer.fromJson<int>(json['setID']),
      logID: serializer.fromJson<int>(json['logID']),
      weight: serializer.fromJson<double>(json['weight']),
      reps: serializer.fromJson<int>(json['reps']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'setID': serializer.toJson<int>(setID),
      'logID': serializer.toJson<int>(logID),
      'weight': serializer.toJson<double>(weight),
      'reps': serializer.toJson<int>(reps),
    };
  }

  LogSet copyWith({int? setID, int? logID, double? weight, int? reps}) =>
      LogSet(
        setID: setID ?? this.setID,
        logID: logID ?? this.logID,
        weight: weight ?? this.weight,
        reps: reps ?? this.reps,
      );
  LogSet copyWithCompanion(LogSetsCompanion data) {
    return LogSet(
      setID: data.setID.present ? data.setID.value : this.setID,
      logID: data.logID.present ? data.logID.value : this.logID,
      weight: data.weight.present ? data.weight.value : this.weight,
      reps: data.reps.present ? data.reps.value : this.reps,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LogSet(')
          ..write('setID: $setID, ')
          ..write('logID: $logID, ')
          ..write('weight: $weight, ')
          ..write('reps: $reps')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(setID, logID, weight, reps);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LogSet &&
          other.setID == this.setID &&
          other.logID == this.logID &&
          other.weight == this.weight &&
          other.reps == this.reps);
}

class LogSetsCompanion extends UpdateCompanion<LogSet> {
  final Value<int> setID;
  final Value<int> logID;
  final Value<double> weight;
  final Value<int> reps;
  const LogSetsCompanion({
    this.setID = const Value.absent(),
    this.logID = const Value.absent(),
    this.weight = const Value.absent(),
    this.reps = const Value.absent(),
  });
  LogSetsCompanion.insert({
    this.setID = const Value.absent(),
    required int logID,
    required double weight,
    required int reps,
  })  : logID = Value(logID),
        weight = Value(weight),
        reps = Value(reps);
  static Insertable<LogSet> custom({
    Expression<int>? setID,
    Expression<int>? logID,
    Expression<double>? weight,
    Expression<int>? reps,
  }) {
    return RawValuesInsertable({
      if (setID != null) 'set_i_d': setID,
      if (logID != null) 'log_i_d': logID,
      if (weight != null) 'weight': weight,
      if (reps != null) 'reps': reps,
    });
  }

  LogSetsCompanion copyWith(
      {Value<int>? setID,
      Value<int>? logID,
      Value<double>? weight,
      Value<int>? reps}) {
    return LogSetsCompanion(
      setID: setID ?? this.setID,
      logID: logID ?? this.logID,
      weight: weight ?? this.weight,
      reps: reps ?? this.reps,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (setID.present) {
      map['set_i_d'] = Variable<int>(setID.value);
    }
    if (logID.present) {
      map['log_i_d'] = Variable<int>(logID.value);
    }
    if (weight.present) {
      map['weight'] = Variable<double>(weight.value);
    }
    if (reps.present) {
      map['reps'] = Variable<int>(reps.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LogSetsCompanion(')
          ..write('setID: $setID, ')
          ..write('logID: $logID, ')
          ..write('weight: $weight, ')
          ..write('reps: $reps')
          ..write(')'))
        .toString();
  }
}

class $PersonalRecordsTable extends PersonalRecords
    with TableInfo<$PersonalRecordsTable, PersonalRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PersonalRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _prIDMeta = const VerificationMeta('prID');
  @override
  late final GeneratedColumn<int> prID = GeneratedColumn<int>(
      'pr_i_d', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _workoutIDMeta =
      const VerificationMeta('workoutID');
  @override
  late final GeneratedColumn<int> workoutID = GeneratedColumn<int>(
      'workout_i_d', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES workouts (workout_i_d)'));
  static const VerificationMeta _maxWeightMeta =
      const VerificationMeta('maxWeight');
  @override
  late final GeneratedColumn<double> maxWeight = GeneratedColumn<double>(
      'max_weight', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _maxWeightRepsMeta =
      const VerificationMeta('maxWeightReps');
  @override
  late final GeneratedColumn<int> maxWeightReps = GeneratedColumn<int>(
      'max_weight_reps', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _maxVolumeWeightMeta =
      const VerificationMeta('maxVolumeWeight');
  @override
  late final GeneratedColumn<double> maxVolumeWeight = GeneratedColumn<double>(
      'max_volume_weight', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _maxVolumeRepsMeta =
      const VerificationMeta('maxVolumeReps');
  @override
  late final GeneratedColumn<int> maxVolumeReps = GeneratedColumn<int>(
      'max_volume_reps', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _maxWeightDateMeta =
      const VerificationMeta('maxWeightDate');
  @override
  late final GeneratedColumn<DateTime> maxWeightDate =
      GeneratedColumn<DateTime>('max_weight_date', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _maxVolumeDateMeta =
      const VerificationMeta('maxVolumeDate');
  @override
  late final GeneratedColumn<DateTime> maxVolumeDate =
      GeneratedColumn<DateTime>('max_volume_date', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        prID,
        workoutID,
        maxWeight,
        maxWeightReps,
        maxVolumeWeight,
        maxVolumeReps,
        maxWeightDate,
        maxVolumeDate
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'personal_records';
  @override
  VerificationContext validateIntegrity(Insertable<PersonalRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('pr_i_d')) {
      context.handle(
          _prIDMeta, prID.isAcceptableOrUnknown(data['pr_i_d']!, _prIDMeta));
    }
    if (data.containsKey('workout_i_d')) {
      context.handle(
          _workoutIDMeta,
          workoutID.isAcceptableOrUnknown(
              data['workout_i_d']!, _workoutIDMeta));
    } else if (isInserting) {
      context.missing(_workoutIDMeta);
    }
    if (data.containsKey('max_weight')) {
      context.handle(_maxWeightMeta,
          maxWeight.isAcceptableOrUnknown(data['max_weight']!, _maxWeightMeta));
    } else if (isInserting) {
      context.missing(_maxWeightMeta);
    }
    if (data.containsKey('max_weight_reps')) {
      context.handle(
          _maxWeightRepsMeta,
          maxWeightReps.isAcceptableOrUnknown(
              data['max_weight_reps']!, _maxWeightRepsMeta));
    } else if (isInserting) {
      context.missing(_maxWeightRepsMeta);
    }
    if (data.containsKey('max_volume_weight')) {
      context.handle(
          _maxVolumeWeightMeta,
          maxVolumeWeight.isAcceptableOrUnknown(
              data['max_volume_weight']!, _maxVolumeWeightMeta));
    } else if (isInserting) {
      context.missing(_maxVolumeWeightMeta);
    }
    if (data.containsKey('max_volume_reps')) {
      context.handle(
          _maxVolumeRepsMeta,
          maxVolumeReps.isAcceptableOrUnknown(
              data['max_volume_reps']!, _maxVolumeRepsMeta));
    } else if (isInserting) {
      context.missing(_maxVolumeRepsMeta);
    }
    if (data.containsKey('max_weight_date')) {
      context.handle(
          _maxWeightDateMeta,
          maxWeightDate.isAcceptableOrUnknown(
              data['max_weight_date']!, _maxWeightDateMeta));
    } else if (isInserting) {
      context.missing(_maxWeightDateMeta);
    }
    if (data.containsKey('max_volume_date')) {
      context.handle(
          _maxVolumeDateMeta,
          maxVolumeDate.isAcceptableOrUnknown(
              data['max_volume_date']!, _maxVolumeDateMeta));
    } else if (isInserting) {
      context.missing(_maxVolumeDateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {prID};
  @override
  PersonalRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PersonalRecord(
      prID: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}pr_i_d'])!,
      workoutID: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}workout_i_d'])!,
      maxWeight: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}max_weight'])!,
      maxWeightReps: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}max_weight_reps'])!,
      maxVolumeWeight: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}max_volume_weight'])!,
      maxVolumeReps: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}max_volume_reps'])!,
      maxWeightDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}max_weight_date'])!,
      maxVolumeDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}max_volume_date'])!,
    );
  }

  @override
  $PersonalRecordsTable createAlias(String alias) {
    return $PersonalRecordsTable(attachedDatabase, alias);
  }
}

class PersonalRecord extends DataClass implements Insertable<PersonalRecord> {
  final int prID;
  final int workoutID;
  final double maxWeight;
  final int maxWeightReps;
  final double maxVolumeWeight;
  final int maxVolumeReps;
  final DateTime maxWeightDate;
  final DateTime maxVolumeDate;
  const PersonalRecord(
      {required this.prID,
      required this.workoutID,
      required this.maxWeight,
      required this.maxWeightReps,
      required this.maxVolumeWeight,
      required this.maxVolumeReps,
      required this.maxWeightDate,
      required this.maxVolumeDate});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['pr_i_d'] = Variable<int>(prID);
    map['workout_i_d'] = Variable<int>(workoutID);
    map['max_weight'] = Variable<double>(maxWeight);
    map['max_weight_reps'] = Variable<int>(maxWeightReps);
    map['max_volume_weight'] = Variable<double>(maxVolumeWeight);
    map['max_volume_reps'] = Variable<int>(maxVolumeReps);
    map['max_weight_date'] = Variable<DateTime>(maxWeightDate);
    map['max_volume_date'] = Variable<DateTime>(maxVolumeDate);
    return map;
  }

  PersonalRecordsCompanion toCompanion(bool nullToAbsent) {
    return PersonalRecordsCompanion(
      prID: Value(prID),
      workoutID: Value(workoutID),
      maxWeight: Value(maxWeight),
      maxWeightReps: Value(maxWeightReps),
      maxVolumeWeight: Value(maxVolumeWeight),
      maxVolumeReps: Value(maxVolumeReps),
      maxWeightDate: Value(maxWeightDate),
      maxVolumeDate: Value(maxVolumeDate),
    );
  }

  factory PersonalRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PersonalRecord(
      prID: serializer.fromJson<int>(json['prID']),
      workoutID: serializer.fromJson<int>(json['workoutID']),
      maxWeight: serializer.fromJson<double>(json['maxWeight']),
      maxWeightReps: serializer.fromJson<int>(json['maxWeightReps']),
      maxVolumeWeight: serializer.fromJson<double>(json['maxVolumeWeight']),
      maxVolumeReps: serializer.fromJson<int>(json['maxVolumeReps']),
      maxWeightDate: serializer.fromJson<DateTime>(json['maxWeightDate']),
      maxVolumeDate: serializer.fromJson<DateTime>(json['maxVolumeDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'prID': serializer.toJson<int>(prID),
      'workoutID': serializer.toJson<int>(workoutID),
      'maxWeight': serializer.toJson<double>(maxWeight),
      'maxWeightReps': serializer.toJson<int>(maxWeightReps),
      'maxVolumeWeight': serializer.toJson<double>(maxVolumeWeight),
      'maxVolumeReps': serializer.toJson<int>(maxVolumeReps),
      'maxWeightDate': serializer.toJson<DateTime>(maxWeightDate),
      'maxVolumeDate': serializer.toJson<DateTime>(maxVolumeDate),
    };
  }

  PersonalRecord copyWith(
          {int? prID,
          int? workoutID,
          double? maxWeight,
          int? maxWeightReps,
          double? maxVolumeWeight,
          int? maxVolumeReps,
          DateTime? maxWeightDate,
          DateTime? maxVolumeDate}) =>
      PersonalRecord(
        prID: prID ?? this.prID,
        workoutID: workoutID ?? this.workoutID,
        maxWeight: maxWeight ?? this.maxWeight,
        maxWeightReps: maxWeightReps ?? this.maxWeightReps,
        maxVolumeWeight: maxVolumeWeight ?? this.maxVolumeWeight,
        maxVolumeReps: maxVolumeReps ?? this.maxVolumeReps,
        maxWeightDate: maxWeightDate ?? this.maxWeightDate,
        maxVolumeDate: maxVolumeDate ?? this.maxVolumeDate,
      );
  PersonalRecord copyWithCompanion(PersonalRecordsCompanion data) {
    return PersonalRecord(
      prID: data.prID.present ? data.prID.value : this.prID,
      workoutID: data.workoutID.present ? data.workoutID.value : this.workoutID,
      maxWeight: data.maxWeight.present ? data.maxWeight.value : this.maxWeight,
      maxWeightReps: data.maxWeightReps.present
          ? data.maxWeightReps.value
          : this.maxWeightReps,
      maxVolumeWeight: data.maxVolumeWeight.present
          ? data.maxVolumeWeight.value
          : this.maxVolumeWeight,
      maxVolumeReps: data.maxVolumeReps.present
          ? data.maxVolumeReps.value
          : this.maxVolumeReps,
      maxWeightDate: data.maxWeightDate.present
          ? data.maxWeightDate.value
          : this.maxWeightDate,
      maxVolumeDate: data.maxVolumeDate.present
          ? data.maxVolumeDate.value
          : this.maxVolumeDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PersonalRecord(')
          ..write('prID: $prID, ')
          ..write('workoutID: $workoutID, ')
          ..write('maxWeight: $maxWeight, ')
          ..write('maxWeightReps: $maxWeightReps, ')
          ..write('maxVolumeWeight: $maxVolumeWeight, ')
          ..write('maxVolumeReps: $maxVolumeReps, ')
          ..write('maxWeightDate: $maxWeightDate, ')
          ..write('maxVolumeDate: $maxVolumeDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(prID, workoutID, maxWeight, maxWeightReps,
      maxVolumeWeight, maxVolumeReps, maxWeightDate, maxVolumeDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PersonalRecord &&
          other.prID == this.prID &&
          other.workoutID == this.workoutID &&
          other.maxWeight == this.maxWeight &&
          other.maxWeightReps == this.maxWeightReps &&
          other.maxVolumeWeight == this.maxVolumeWeight &&
          other.maxVolumeReps == this.maxVolumeReps &&
          other.maxWeightDate == this.maxWeightDate &&
          other.maxVolumeDate == this.maxVolumeDate);
}

class PersonalRecordsCompanion extends UpdateCompanion<PersonalRecord> {
  final Value<int> prID;
  final Value<int> workoutID;
  final Value<double> maxWeight;
  final Value<int> maxWeightReps;
  final Value<double> maxVolumeWeight;
  final Value<int> maxVolumeReps;
  final Value<DateTime> maxWeightDate;
  final Value<DateTime> maxVolumeDate;
  const PersonalRecordsCompanion({
    this.prID = const Value.absent(),
    this.workoutID = const Value.absent(),
    this.maxWeight = const Value.absent(),
    this.maxWeightReps = const Value.absent(),
    this.maxVolumeWeight = const Value.absent(),
    this.maxVolumeReps = const Value.absent(),
    this.maxWeightDate = const Value.absent(),
    this.maxVolumeDate = const Value.absent(),
  });
  PersonalRecordsCompanion.insert({
    this.prID = const Value.absent(),
    required int workoutID,
    required double maxWeight,
    required int maxWeightReps,
    required double maxVolumeWeight,
    required int maxVolumeReps,
    required DateTime maxWeightDate,
    required DateTime maxVolumeDate,
  })  : workoutID = Value(workoutID),
        maxWeight = Value(maxWeight),
        maxWeightReps = Value(maxWeightReps),
        maxVolumeWeight = Value(maxVolumeWeight),
        maxVolumeReps = Value(maxVolumeReps),
        maxWeightDate = Value(maxWeightDate),
        maxVolumeDate = Value(maxVolumeDate);
  static Insertable<PersonalRecord> custom({
    Expression<int>? prID,
    Expression<int>? workoutID,
    Expression<double>? maxWeight,
    Expression<int>? maxWeightReps,
    Expression<double>? maxVolumeWeight,
    Expression<int>? maxVolumeReps,
    Expression<DateTime>? maxWeightDate,
    Expression<DateTime>? maxVolumeDate,
  }) {
    return RawValuesInsertable({
      if (prID != null) 'pr_i_d': prID,
      if (workoutID != null) 'workout_i_d': workoutID,
      if (maxWeight != null) 'max_weight': maxWeight,
      if (maxWeightReps != null) 'max_weight_reps': maxWeightReps,
      if (maxVolumeWeight != null) 'max_volume_weight': maxVolumeWeight,
      if (maxVolumeReps != null) 'max_volume_reps': maxVolumeReps,
      if (maxWeightDate != null) 'max_weight_date': maxWeightDate,
      if (maxVolumeDate != null) 'max_volume_date': maxVolumeDate,
    });
  }

  PersonalRecordsCompanion copyWith(
      {Value<int>? prID,
      Value<int>? workoutID,
      Value<double>? maxWeight,
      Value<int>? maxWeightReps,
      Value<double>? maxVolumeWeight,
      Value<int>? maxVolumeReps,
      Value<DateTime>? maxWeightDate,
      Value<DateTime>? maxVolumeDate}) {
    return PersonalRecordsCompanion(
      prID: prID ?? this.prID,
      workoutID: workoutID ?? this.workoutID,
      maxWeight: maxWeight ?? this.maxWeight,
      maxWeightReps: maxWeightReps ?? this.maxWeightReps,
      maxVolumeWeight: maxVolumeWeight ?? this.maxVolumeWeight,
      maxVolumeReps: maxVolumeReps ?? this.maxVolumeReps,
      maxWeightDate: maxWeightDate ?? this.maxWeightDate,
      maxVolumeDate: maxVolumeDate ?? this.maxVolumeDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (prID.present) {
      map['pr_i_d'] = Variable<int>(prID.value);
    }
    if (workoutID.present) {
      map['workout_i_d'] = Variable<int>(workoutID.value);
    }
    if (maxWeight.present) {
      map['max_weight'] = Variable<double>(maxWeight.value);
    }
    if (maxWeightReps.present) {
      map['max_weight_reps'] = Variable<int>(maxWeightReps.value);
    }
    if (maxVolumeWeight.present) {
      map['max_volume_weight'] = Variable<double>(maxVolumeWeight.value);
    }
    if (maxVolumeReps.present) {
      map['max_volume_reps'] = Variable<int>(maxVolumeReps.value);
    }
    if (maxWeightDate.present) {
      map['max_weight_date'] = Variable<DateTime>(maxWeightDate.value);
    }
    if (maxVolumeDate.present) {
      map['max_volume_date'] = Variable<DateTime>(maxVolumeDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PersonalRecordsCompanion(')
          ..write('prID: $prID, ')
          ..write('workoutID: $workoutID, ')
          ..write('maxWeight: $maxWeight, ')
          ..write('maxWeightReps: $maxWeightReps, ')
          ..write('maxVolumeWeight: $maxVolumeWeight, ')
          ..write('maxVolumeReps: $maxVolumeReps, ')
          ..write('maxWeightDate: $maxWeightDate, ')
          ..write('maxVolumeDate: $maxVolumeDate')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $MuscleGroupsTable muscleGroups = $MuscleGroupsTable(this);
  late final $WorkoutsTable workouts = $WorkoutsTable(this);
  late final $LogsTable logs = $LogsTable(this);
  late final $LogSetsTable logSets = $LogSetsTable(this);
  late final $PersonalRecordsTable personalRecords =
      $PersonalRecordsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [muscleGroups, workouts, logs, logSets, personalRecords];
}

typedef $$MuscleGroupsTableCreateCompanionBuilder = MuscleGroupsCompanion
    Function({
  Value<int> groupID,
  required String groupName,
  required int color,
});
typedef $$MuscleGroupsTableUpdateCompanionBuilder = MuscleGroupsCompanion
    Function({
  Value<int> groupID,
  Value<String> groupName,
  Value<int> color,
});

final class $$MuscleGroupsTableReferences
    extends BaseReferences<_$AppDatabase, $MuscleGroupsTable, MuscleGroup> {
  $$MuscleGroupsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$WorkoutsTable, List<Workout>> _workoutsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.workouts,
          aliasName: $_aliasNameGenerator(
              db.muscleGroups.groupID, db.workouts.groupID));

  $$WorkoutsTableProcessedTableManager get workoutsRefs {
    final manager = $$WorkoutsTableTableManager($_db, $_db.workouts).filter(
        (f) => f.groupID.groupID.sqlEquals($_itemColumn<int>('group_i_d')!));

    final cache = $_typedResult.readTableOrNull(_workoutsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$MuscleGroupsTableFilterComposer
    extends Composer<_$AppDatabase, $MuscleGroupsTable> {
  $$MuscleGroupsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get groupID => $composableBuilder(
      column: $table.groupID, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get groupName => $composableBuilder(
      column: $table.groupName, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get color => $composableBuilder(
      column: $table.color, builder: (column) => ColumnFilters(column));

  Expression<bool> workoutsRefs(
      Expression<bool> Function($$WorkoutsTableFilterComposer f) f) {
    final $$WorkoutsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.groupID,
        referencedTable: $db.workouts,
        getReferencedColumn: (t) => t.groupID,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorkoutsTableFilterComposer(
              $db: $db,
              $table: $db.workouts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$MuscleGroupsTableOrderingComposer
    extends Composer<_$AppDatabase, $MuscleGroupsTable> {
  $$MuscleGroupsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get groupID => $composableBuilder(
      column: $table.groupID, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get groupName => $composableBuilder(
      column: $table.groupName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get color => $composableBuilder(
      column: $table.color, builder: (column) => ColumnOrderings(column));
}

class $$MuscleGroupsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MuscleGroupsTable> {
  $$MuscleGroupsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get groupID =>
      $composableBuilder(column: $table.groupID, builder: (column) => column);

  GeneratedColumn<String> get groupName =>
      $composableBuilder(column: $table.groupName, builder: (column) => column);

  GeneratedColumn<int> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  Expression<T> workoutsRefs<T extends Object>(
      Expression<T> Function($$WorkoutsTableAnnotationComposer a) f) {
    final $$WorkoutsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.groupID,
        referencedTable: $db.workouts,
        getReferencedColumn: (t) => t.groupID,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorkoutsTableAnnotationComposer(
              $db: $db,
              $table: $db.workouts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$MuscleGroupsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MuscleGroupsTable,
    MuscleGroup,
    $$MuscleGroupsTableFilterComposer,
    $$MuscleGroupsTableOrderingComposer,
    $$MuscleGroupsTableAnnotationComposer,
    $$MuscleGroupsTableCreateCompanionBuilder,
    $$MuscleGroupsTableUpdateCompanionBuilder,
    (MuscleGroup, $$MuscleGroupsTableReferences),
    MuscleGroup,
    PrefetchHooks Function({bool workoutsRefs})> {
  $$MuscleGroupsTableTableManager(_$AppDatabase db, $MuscleGroupsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MuscleGroupsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MuscleGroupsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MuscleGroupsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> groupID = const Value.absent(),
            Value<String> groupName = const Value.absent(),
            Value<int> color = const Value.absent(),
          }) =>
              MuscleGroupsCompanion(
            groupID: groupID,
            groupName: groupName,
            color: color,
          ),
          createCompanionCallback: ({
            Value<int> groupID = const Value.absent(),
            required String groupName,
            required int color,
          }) =>
              MuscleGroupsCompanion.insert(
            groupID: groupID,
            groupName: groupName,
            color: color,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$MuscleGroupsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({workoutsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (workoutsRefs) db.workouts],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (workoutsRefs)
                    await $_getPrefetchedData<MuscleGroup, $MuscleGroupsTable,
                            Workout>(
                        currentTable: table,
                        referencedTable: $$MuscleGroupsTableReferences
                            ._workoutsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$MuscleGroupsTableReferences(db, table, p0)
                                .workoutsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.groupID == item.groupID),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$MuscleGroupsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $MuscleGroupsTable,
    MuscleGroup,
    $$MuscleGroupsTableFilterComposer,
    $$MuscleGroupsTableOrderingComposer,
    $$MuscleGroupsTableAnnotationComposer,
    $$MuscleGroupsTableCreateCompanionBuilder,
    $$MuscleGroupsTableUpdateCompanionBuilder,
    (MuscleGroup, $$MuscleGroupsTableReferences),
    MuscleGroup,
    PrefetchHooks Function({bool workoutsRefs})>;
typedef $$WorkoutsTableCreateCompanionBuilder = WorkoutsCompanion Function({
  Value<int> workoutID,
  required int groupID,
  required String name,
});
typedef $$WorkoutsTableUpdateCompanionBuilder = WorkoutsCompanion Function({
  Value<int> workoutID,
  Value<int> groupID,
  Value<String> name,
});

final class $$WorkoutsTableReferences
    extends BaseReferences<_$AppDatabase, $WorkoutsTable, Workout> {
  $$WorkoutsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $MuscleGroupsTable _groupIDTable(_$AppDatabase db) =>
      db.muscleGroups.createAlias(
          $_aliasNameGenerator(db.workouts.groupID, db.muscleGroups.groupID));

  $$MuscleGroupsTableProcessedTableManager get groupID {
    final $_column = $_itemColumn<int>('group_i_d')!;

    final manager = $$MuscleGroupsTableTableManager($_db, $_db.muscleGroups)
        .filter((f) => f.groupID.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_groupIDTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$LogsTable, List<Log>> _logsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.logs,
          aliasName:
              $_aliasNameGenerator(db.workouts.workoutID, db.logs.workoutID));

  $$LogsTableProcessedTableManager get logsRefs {
    final manager = $$LogsTableTableManager($_db, $_db.logs).filter((f) =>
        f.workoutID.workoutID.sqlEquals($_itemColumn<int>('workout_i_d')!));

    final cache = $_typedResult.readTableOrNull(_logsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$PersonalRecordsTable, List<PersonalRecord>>
      _personalRecordsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.personalRecords,
              aliasName: $_aliasNameGenerator(
                  db.workouts.workoutID, db.personalRecords.workoutID));

  $$PersonalRecordsTableProcessedTableManager get personalRecordsRefs {
    final manager = $$PersonalRecordsTableTableManager(
            $_db, $_db.personalRecords)
        .filter((f) =>
            f.workoutID.workoutID.sqlEquals($_itemColumn<int>('workout_i_d')!));

    final cache =
        $_typedResult.readTableOrNull(_personalRecordsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$WorkoutsTableFilterComposer
    extends Composer<_$AppDatabase, $WorkoutsTable> {
  $$WorkoutsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get workoutID => $composableBuilder(
      column: $table.workoutID, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  $$MuscleGroupsTableFilterComposer get groupID {
    final $$MuscleGroupsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.groupID,
        referencedTable: $db.muscleGroups,
        getReferencedColumn: (t) => t.groupID,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MuscleGroupsTableFilterComposer(
              $db: $db,
              $table: $db.muscleGroups,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> logsRefs(
      Expression<bool> Function($$LogsTableFilterComposer f) f) {
    final $$LogsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.workoutID,
        referencedTable: $db.logs,
        getReferencedColumn: (t) => t.workoutID,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LogsTableFilterComposer(
              $db: $db,
              $table: $db.logs,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> personalRecordsRefs(
      Expression<bool> Function($$PersonalRecordsTableFilterComposer f) f) {
    final $$PersonalRecordsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.workoutID,
        referencedTable: $db.personalRecords,
        getReferencedColumn: (t) => t.workoutID,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PersonalRecordsTableFilterComposer(
              $db: $db,
              $table: $db.personalRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$WorkoutsTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkoutsTable> {
  $$WorkoutsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get workoutID => $composableBuilder(
      column: $table.workoutID, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  $$MuscleGroupsTableOrderingComposer get groupID {
    final $$MuscleGroupsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.groupID,
        referencedTable: $db.muscleGroups,
        getReferencedColumn: (t) => t.groupID,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MuscleGroupsTableOrderingComposer(
              $db: $db,
              $table: $db.muscleGroups,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$WorkoutsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkoutsTable> {
  $$WorkoutsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get workoutID =>
      $composableBuilder(column: $table.workoutID, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  $$MuscleGroupsTableAnnotationComposer get groupID {
    final $$MuscleGroupsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.groupID,
        referencedTable: $db.muscleGroups,
        getReferencedColumn: (t) => t.groupID,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MuscleGroupsTableAnnotationComposer(
              $db: $db,
              $table: $db.muscleGroups,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> logsRefs<T extends Object>(
      Expression<T> Function($$LogsTableAnnotationComposer a) f) {
    final $$LogsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.workoutID,
        referencedTable: $db.logs,
        getReferencedColumn: (t) => t.workoutID,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LogsTableAnnotationComposer(
              $db: $db,
              $table: $db.logs,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> personalRecordsRefs<T extends Object>(
      Expression<T> Function($$PersonalRecordsTableAnnotationComposer a) f) {
    final $$PersonalRecordsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.workoutID,
        referencedTable: $db.personalRecords,
        getReferencedColumn: (t) => t.workoutID,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PersonalRecordsTableAnnotationComposer(
              $db: $db,
              $table: $db.personalRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$WorkoutsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WorkoutsTable,
    Workout,
    $$WorkoutsTableFilterComposer,
    $$WorkoutsTableOrderingComposer,
    $$WorkoutsTableAnnotationComposer,
    $$WorkoutsTableCreateCompanionBuilder,
    $$WorkoutsTableUpdateCompanionBuilder,
    (Workout, $$WorkoutsTableReferences),
    Workout,
    PrefetchHooks Function(
        {bool groupID, bool logsRefs, bool personalRecordsRefs})> {
  $$WorkoutsTableTableManager(_$AppDatabase db, $WorkoutsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkoutsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkoutsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorkoutsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> workoutID = const Value.absent(),
            Value<int> groupID = const Value.absent(),
            Value<String> name = const Value.absent(),
          }) =>
              WorkoutsCompanion(
            workoutID: workoutID,
            groupID: groupID,
            name: name,
          ),
          createCompanionCallback: ({
            Value<int> workoutID = const Value.absent(),
            required int groupID,
            required String name,
          }) =>
              WorkoutsCompanion.insert(
            workoutID: workoutID,
            groupID: groupID,
            name: name,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$WorkoutsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {groupID = false,
              logsRefs = false,
              personalRecordsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (logsRefs) db.logs,
                if (personalRecordsRefs) db.personalRecords
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (groupID) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.groupID,
                    referencedTable:
                        $$WorkoutsTableReferences._groupIDTable(db),
                    referencedColumn:
                        $$WorkoutsTableReferences._groupIDTable(db).groupID,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (logsRefs)
                    await $_getPrefetchedData<Workout, $WorkoutsTable, Log>(
                        currentTable: table,
                        referencedTable:
                            $$WorkoutsTableReferences._logsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$WorkoutsTableReferences(db, table, p0).logsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.workoutID == item.workoutID),
                        typedResults: items),
                  if (personalRecordsRefs)
                    await $_getPrefetchedData<Workout, $WorkoutsTable,
                            PersonalRecord>(
                        currentTable: table,
                        referencedTable: $$WorkoutsTableReferences
                            ._personalRecordsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$WorkoutsTableReferences(db, table, p0)
                                .personalRecordsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.workoutID == item.workoutID),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$WorkoutsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WorkoutsTable,
    Workout,
    $$WorkoutsTableFilterComposer,
    $$WorkoutsTableOrderingComposer,
    $$WorkoutsTableAnnotationComposer,
    $$WorkoutsTableCreateCompanionBuilder,
    $$WorkoutsTableUpdateCompanionBuilder,
    (Workout, $$WorkoutsTableReferences),
    Workout,
    PrefetchHooks Function(
        {bool groupID, bool logsRefs, bool personalRecordsRefs})>;
typedef $$LogsTableCreateCompanionBuilder = LogsCompanion Function({
  Value<int> logID,
  required int workoutID,
  required DateTime dt,
  Value<String?> note,
});
typedef $$LogsTableUpdateCompanionBuilder = LogsCompanion Function({
  Value<int> logID,
  Value<int> workoutID,
  Value<DateTime> dt,
  Value<String?> note,
});

final class $$LogsTableReferences
    extends BaseReferences<_$AppDatabase, $LogsTable, Log> {
  $$LogsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $WorkoutsTable _workoutIDTable(_$AppDatabase db) =>
      db.workouts.createAlias(
          $_aliasNameGenerator(db.logs.workoutID, db.workouts.workoutID));

  $$WorkoutsTableProcessedTableManager get workoutID {
    final $_column = $_itemColumn<int>('workout_i_d')!;

    final manager = $$WorkoutsTableTableManager($_db, $_db.workouts)
        .filter((f) => f.workoutID.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_workoutIDTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$LogSetsTable, List<LogSet>> _logSetsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.logSets,
          aliasName: $_aliasNameGenerator(db.logs.logID, db.logSets.logID));

  $$LogSetsTableProcessedTableManager get logSetsRefs {
    final manager = $$LogSetsTableTableManager($_db, $_db.logSets)
        .filter((f) => f.logID.logID.sqlEquals($_itemColumn<int>('log_i_d')!));

    final cache = $_typedResult.readTableOrNull(_logSetsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$LogsTableFilterComposer extends Composer<_$AppDatabase, $LogsTable> {
  $$LogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get logID => $composableBuilder(
      column: $table.logID, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dt => $composableBuilder(
      column: $table.dt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnFilters(column));

  $$WorkoutsTableFilterComposer get workoutID {
    final $$WorkoutsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.workoutID,
        referencedTable: $db.workouts,
        getReferencedColumn: (t) => t.workoutID,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorkoutsTableFilterComposer(
              $db: $db,
              $table: $db.workouts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> logSetsRefs(
      Expression<bool> Function($$LogSetsTableFilterComposer f) f) {
    final $$LogSetsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.logID,
        referencedTable: $db.logSets,
        getReferencedColumn: (t) => t.logID,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LogSetsTableFilterComposer(
              $db: $db,
              $table: $db.logSets,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$LogsTableOrderingComposer extends Composer<_$AppDatabase, $LogsTable> {
  $$LogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get logID => $composableBuilder(
      column: $table.logID, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dt => $composableBuilder(
      column: $table.dt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnOrderings(column));

  $$WorkoutsTableOrderingComposer get workoutID {
    final $$WorkoutsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.workoutID,
        referencedTable: $db.workouts,
        getReferencedColumn: (t) => t.workoutID,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorkoutsTableOrderingComposer(
              $db: $db,
              $table: $db.workouts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$LogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LogsTable> {
  $$LogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get logID =>
      $composableBuilder(column: $table.logID, builder: (column) => column);

  GeneratedColumn<DateTime> get dt =>
      $composableBuilder(column: $table.dt, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  $$WorkoutsTableAnnotationComposer get workoutID {
    final $$WorkoutsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.workoutID,
        referencedTable: $db.workouts,
        getReferencedColumn: (t) => t.workoutID,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorkoutsTableAnnotationComposer(
              $db: $db,
              $table: $db.workouts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> logSetsRefs<T extends Object>(
      Expression<T> Function($$LogSetsTableAnnotationComposer a) f) {
    final $$LogSetsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.logID,
        referencedTable: $db.logSets,
        getReferencedColumn: (t) => t.logID,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LogSetsTableAnnotationComposer(
              $db: $db,
              $table: $db.logSets,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$LogsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LogsTable,
    Log,
    $$LogsTableFilterComposer,
    $$LogsTableOrderingComposer,
    $$LogsTableAnnotationComposer,
    $$LogsTableCreateCompanionBuilder,
    $$LogsTableUpdateCompanionBuilder,
    (Log, $$LogsTableReferences),
    Log,
    PrefetchHooks Function({bool workoutID, bool logSetsRefs})> {
  $$LogsTableTableManager(_$AppDatabase db, $LogsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> logID = const Value.absent(),
            Value<int> workoutID = const Value.absent(),
            Value<DateTime> dt = const Value.absent(),
            Value<String?> note = const Value.absent(),
          }) =>
              LogsCompanion(
            logID: logID,
            workoutID: workoutID,
            dt: dt,
            note: note,
          ),
          createCompanionCallback: ({
            Value<int> logID = const Value.absent(),
            required int workoutID,
            required DateTime dt,
            Value<String?> note = const Value.absent(),
          }) =>
              LogsCompanion.insert(
            logID: logID,
            workoutID: workoutID,
            dt: dt,
            note: note,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$LogsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({workoutID = false, logSetsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (logSetsRefs) db.logSets],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (workoutID) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.workoutID,
                    referencedTable: $$LogsTableReferences._workoutIDTable(db),
                    referencedColumn:
                        $$LogsTableReferences._workoutIDTable(db).workoutID,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (logSetsRefs)
                    await $_getPrefetchedData<Log, $LogsTable, LogSet>(
                        currentTable: table,
                        referencedTable:
                            $$LogsTableReferences._logSetsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$LogsTableReferences(db, table, p0).logSetsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.logID == item.logID),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$LogsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $LogsTable,
    Log,
    $$LogsTableFilterComposer,
    $$LogsTableOrderingComposer,
    $$LogsTableAnnotationComposer,
    $$LogsTableCreateCompanionBuilder,
    $$LogsTableUpdateCompanionBuilder,
    (Log, $$LogsTableReferences),
    Log,
    PrefetchHooks Function({bool workoutID, bool logSetsRefs})>;
typedef $$LogSetsTableCreateCompanionBuilder = LogSetsCompanion Function({
  Value<int> setID,
  required int logID,
  required double weight,
  required int reps,
});
typedef $$LogSetsTableUpdateCompanionBuilder = LogSetsCompanion Function({
  Value<int> setID,
  Value<int> logID,
  Value<double> weight,
  Value<int> reps,
});

final class $$LogSetsTableReferences
    extends BaseReferences<_$AppDatabase, $LogSetsTable, LogSet> {
  $$LogSetsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $LogsTable _logIDTable(_$AppDatabase db) => db.logs
      .createAlias($_aliasNameGenerator(db.logSets.logID, db.logs.logID));

  $$LogsTableProcessedTableManager get logID {
    final $_column = $_itemColumn<int>('log_i_d')!;

    final manager = $$LogsTableTableManager($_db, $_db.logs)
        .filter((f) => f.logID.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_logIDTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$LogSetsTableFilterComposer
    extends Composer<_$AppDatabase, $LogSetsTable> {
  $$LogSetsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get setID => $composableBuilder(
      column: $table.setID, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get weight => $composableBuilder(
      column: $table.weight, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get reps => $composableBuilder(
      column: $table.reps, builder: (column) => ColumnFilters(column));

  $$LogsTableFilterComposer get logID {
    final $$LogsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.logID,
        referencedTable: $db.logs,
        getReferencedColumn: (t) => t.logID,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LogsTableFilterComposer(
              $db: $db,
              $table: $db.logs,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$LogSetsTableOrderingComposer
    extends Composer<_$AppDatabase, $LogSetsTable> {
  $$LogSetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get setID => $composableBuilder(
      column: $table.setID, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get weight => $composableBuilder(
      column: $table.weight, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get reps => $composableBuilder(
      column: $table.reps, builder: (column) => ColumnOrderings(column));

  $$LogsTableOrderingComposer get logID {
    final $$LogsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.logID,
        referencedTable: $db.logs,
        getReferencedColumn: (t) => t.logID,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LogsTableOrderingComposer(
              $db: $db,
              $table: $db.logs,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$LogSetsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LogSetsTable> {
  $$LogSetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get setID =>
      $composableBuilder(column: $table.setID, builder: (column) => column);

  GeneratedColumn<double> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);

  GeneratedColumn<int> get reps =>
      $composableBuilder(column: $table.reps, builder: (column) => column);

  $$LogsTableAnnotationComposer get logID {
    final $$LogsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.logID,
        referencedTable: $db.logs,
        getReferencedColumn: (t) => t.logID,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LogsTableAnnotationComposer(
              $db: $db,
              $table: $db.logs,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$LogSetsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LogSetsTable,
    LogSet,
    $$LogSetsTableFilterComposer,
    $$LogSetsTableOrderingComposer,
    $$LogSetsTableAnnotationComposer,
    $$LogSetsTableCreateCompanionBuilder,
    $$LogSetsTableUpdateCompanionBuilder,
    (LogSet, $$LogSetsTableReferences),
    LogSet,
    PrefetchHooks Function({bool logID})> {
  $$LogSetsTableTableManager(_$AppDatabase db, $LogSetsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LogSetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LogSetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LogSetsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> setID = const Value.absent(),
            Value<int> logID = const Value.absent(),
            Value<double> weight = const Value.absent(),
            Value<int> reps = const Value.absent(),
          }) =>
              LogSetsCompanion(
            setID: setID,
            logID: logID,
            weight: weight,
            reps: reps,
          ),
          createCompanionCallback: ({
            Value<int> setID = const Value.absent(),
            required int logID,
            required double weight,
            required int reps,
          }) =>
              LogSetsCompanion.insert(
            setID: setID,
            logID: logID,
            weight: weight,
            reps: reps,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$LogSetsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({logID = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (logID) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.logID,
                    referencedTable: $$LogSetsTableReferences._logIDTable(db),
                    referencedColumn:
                        $$LogSetsTableReferences._logIDTable(db).logID,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$LogSetsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $LogSetsTable,
    LogSet,
    $$LogSetsTableFilterComposer,
    $$LogSetsTableOrderingComposer,
    $$LogSetsTableAnnotationComposer,
    $$LogSetsTableCreateCompanionBuilder,
    $$LogSetsTableUpdateCompanionBuilder,
    (LogSet, $$LogSetsTableReferences),
    LogSet,
    PrefetchHooks Function({bool logID})>;
typedef $$PersonalRecordsTableCreateCompanionBuilder = PersonalRecordsCompanion
    Function({
  Value<int> prID,
  required int workoutID,
  required double maxWeight,
  required int maxWeightReps,
  required double maxVolumeWeight,
  required int maxVolumeReps,
  required DateTime maxWeightDate,
  required DateTime maxVolumeDate,
});
typedef $$PersonalRecordsTableUpdateCompanionBuilder = PersonalRecordsCompanion
    Function({
  Value<int> prID,
  Value<int> workoutID,
  Value<double> maxWeight,
  Value<int> maxWeightReps,
  Value<double> maxVolumeWeight,
  Value<int> maxVolumeReps,
  Value<DateTime> maxWeightDate,
  Value<DateTime> maxVolumeDate,
});

final class $$PersonalRecordsTableReferences extends BaseReferences<
    _$AppDatabase, $PersonalRecordsTable, PersonalRecord> {
  $$PersonalRecordsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $WorkoutsTable _workoutIDTable(_$AppDatabase db) =>
      db.workouts.createAlias($_aliasNameGenerator(
          db.personalRecords.workoutID, db.workouts.workoutID));

  $$WorkoutsTableProcessedTableManager get workoutID {
    final $_column = $_itemColumn<int>('workout_i_d')!;

    final manager = $$WorkoutsTableTableManager($_db, $_db.workouts)
        .filter((f) => f.workoutID.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_workoutIDTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$PersonalRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $PersonalRecordsTable> {
  $$PersonalRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get prID => $composableBuilder(
      column: $table.prID, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get maxWeight => $composableBuilder(
      column: $table.maxWeight, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get maxWeightReps => $composableBuilder(
      column: $table.maxWeightReps, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get maxVolumeWeight => $composableBuilder(
      column: $table.maxVolumeWeight,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get maxVolumeReps => $composableBuilder(
      column: $table.maxVolumeReps, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get maxWeightDate => $composableBuilder(
      column: $table.maxWeightDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get maxVolumeDate => $composableBuilder(
      column: $table.maxVolumeDate, builder: (column) => ColumnFilters(column));

  $$WorkoutsTableFilterComposer get workoutID {
    final $$WorkoutsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.workoutID,
        referencedTable: $db.workouts,
        getReferencedColumn: (t) => t.workoutID,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorkoutsTableFilterComposer(
              $db: $db,
              $table: $db.workouts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PersonalRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $PersonalRecordsTable> {
  $$PersonalRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get prID => $composableBuilder(
      column: $table.prID, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get maxWeight => $composableBuilder(
      column: $table.maxWeight, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get maxWeightReps => $composableBuilder(
      column: $table.maxWeightReps,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get maxVolumeWeight => $composableBuilder(
      column: $table.maxVolumeWeight,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get maxVolumeReps => $composableBuilder(
      column: $table.maxVolumeReps,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get maxWeightDate => $composableBuilder(
      column: $table.maxWeightDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get maxVolumeDate => $composableBuilder(
      column: $table.maxVolumeDate,
      builder: (column) => ColumnOrderings(column));

  $$WorkoutsTableOrderingComposer get workoutID {
    final $$WorkoutsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.workoutID,
        referencedTable: $db.workouts,
        getReferencedColumn: (t) => t.workoutID,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorkoutsTableOrderingComposer(
              $db: $db,
              $table: $db.workouts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PersonalRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PersonalRecordsTable> {
  $$PersonalRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get prID =>
      $composableBuilder(column: $table.prID, builder: (column) => column);

  GeneratedColumn<double> get maxWeight =>
      $composableBuilder(column: $table.maxWeight, builder: (column) => column);

  GeneratedColumn<int> get maxWeightReps => $composableBuilder(
      column: $table.maxWeightReps, builder: (column) => column);

  GeneratedColumn<double> get maxVolumeWeight => $composableBuilder(
      column: $table.maxVolumeWeight, builder: (column) => column);

  GeneratedColumn<int> get maxVolumeReps => $composableBuilder(
      column: $table.maxVolumeReps, builder: (column) => column);

  GeneratedColumn<DateTime> get maxWeightDate => $composableBuilder(
      column: $table.maxWeightDate, builder: (column) => column);

  GeneratedColumn<DateTime> get maxVolumeDate => $composableBuilder(
      column: $table.maxVolumeDate, builder: (column) => column);

  $$WorkoutsTableAnnotationComposer get workoutID {
    final $$WorkoutsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.workoutID,
        referencedTable: $db.workouts,
        getReferencedColumn: (t) => t.workoutID,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorkoutsTableAnnotationComposer(
              $db: $db,
              $table: $db.workouts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PersonalRecordsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PersonalRecordsTable,
    PersonalRecord,
    $$PersonalRecordsTableFilterComposer,
    $$PersonalRecordsTableOrderingComposer,
    $$PersonalRecordsTableAnnotationComposer,
    $$PersonalRecordsTableCreateCompanionBuilder,
    $$PersonalRecordsTableUpdateCompanionBuilder,
    (PersonalRecord, $$PersonalRecordsTableReferences),
    PersonalRecord,
    PrefetchHooks Function({bool workoutID})> {
  $$PersonalRecordsTableTableManager(
      _$AppDatabase db, $PersonalRecordsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PersonalRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PersonalRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PersonalRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> prID = const Value.absent(),
            Value<int> workoutID = const Value.absent(),
            Value<double> maxWeight = const Value.absent(),
            Value<int> maxWeightReps = const Value.absent(),
            Value<double> maxVolumeWeight = const Value.absent(),
            Value<int> maxVolumeReps = const Value.absent(),
            Value<DateTime> maxWeightDate = const Value.absent(),
            Value<DateTime> maxVolumeDate = const Value.absent(),
          }) =>
              PersonalRecordsCompanion(
            prID: prID,
            workoutID: workoutID,
            maxWeight: maxWeight,
            maxWeightReps: maxWeightReps,
            maxVolumeWeight: maxVolumeWeight,
            maxVolumeReps: maxVolumeReps,
            maxWeightDate: maxWeightDate,
            maxVolumeDate: maxVolumeDate,
          ),
          createCompanionCallback: ({
            Value<int> prID = const Value.absent(),
            required int workoutID,
            required double maxWeight,
            required int maxWeightReps,
            required double maxVolumeWeight,
            required int maxVolumeReps,
            required DateTime maxWeightDate,
            required DateTime maxVolumeDate,
          }) =>
              PersonalRecordsCompanion.insert(
            prID: prID,
            workoutID: workoutID,
            maxWeight: maxWeight,
            maxWeightReps: maxWeightReps,
            maxVolumeWeight: maxVolumeWeight,
            maxVolumeReps: maxVolumeReps,
            maxWeightDate: maxWeightDate,
            maxVolumeDate: maxVolumeDate,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$PersonalRecordsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({workoutID = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (workoutID) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.workoutID,
                    referencedTable:
                        $$PersonalRecordsTableReferences._workoutIDTable(db),
                    referencedColumn: $$PersonalRecordsTableReferences
                        ._workoutIDTable(db)
                        .workoutID,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$PersonalRecordsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PersonalRecordsTable,
    PersonalRecord,
    $$PersonalRecordsTableFilterComposer,
    $$PersonalRecordsTableOrderingComposer,
    $$PersonalRecordsTableAnnotationComposer,
    $$PersonalRecordsTableCreateCompanionBuilder,
    $$PersonalRecordsTableUpdateCompanionBuilder,
    (PersonalRecord, $$PersonalRecordsTableReferences),
    PersonalRecord,
    PrefetchHooks Function({bool workoutID})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$MuscleGroupsTableTableManager get muscleGroups =>
      $$MuscleGroupsTableTableManager(_db, _db.muscleGroups);
  $$WorkoutsTableTableManager get workouts =>
      $$WorkoutsTableTableManager(_db, _db.workouts);
  $$LogsTableTableManager get logs => $$LogsTableTableManager(_db, _db.logs);
  $$LogSetsTableTableManager get logSets =>
      $$LogSetsTableTableManager(_db, _db.logSets);
  $$PersonalRecordsTableTableManager get personalRecords =>
      $$PersonalRecordsTableTableManager(_db, _db.personalRecords);
}
