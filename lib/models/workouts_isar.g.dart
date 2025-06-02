// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workouts_isar.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetWorkoutDetailCollection on Isar {
  IsarCollection<WorkoutDetail> get workoutDetails => this.collection();
}

const WorkoutDetailSchema = CollectionSchema(
  name: r'WorkoutDetail',
  id: 22631097489575581,
  properties: {
    r'workouts': PropertySchema(
      id: 0,
      name: r'workouts',
      type: IsarType.objectList,
      target: r'WorkoutEntry',
    )
  },
  estimateSize: _workoutDetailEstimateSize,
  serialize: _workoutDetailSerialize,
  deserialize: _workoutDetailDeserialize,
  deserializeProp: _workoutDetailDeserializeProp,
  idName: r'workoutID',
  indexes: {},
  links: {},
  embeddedSchemas: {
    r'WorkoutEntry': WorkoutEntrySchema,
    r'Session': SessionSchema,
    r'Sets': SetsSchema
  },
  getId: _workoutDetailGetId,
  getLinks: _workoutDetailGetLinks,
  attach: _workoutDetailAttach,
  version: '3.1.0+1',
);

int _workoutDetailEstimateSize(
  WorkoutDetail object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.workouts.length * 3;
  {
    final offsets = allOffsets[WorkoutEntry]!;
    for (var i = 0; i < object.workouts.length; i++) {
      final value = object.workouts[i];
      bytesCount += WorkoutEntrySchema.estimateSize(value, offsets, allOffsets);
    }
  }
  return bytesCount;
}

void _workoutDetailSerialize(
  WorkoutDetail object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObjectList<WorkoutEntry>(
    offsets[0],
    allOffsets,
    WorkoutEntrySchema.serialize,
    object.workouts,
  );
}

WorkoutDetail _workoutDetailDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = WorkoutDetail(
    workoutID: id,
    workouts: reader.readObjectList<WorkoutEntry>(
          offsets[0],
          WorkoutEntrySchema.deserialize,
          allOffsets,
          WorkoutEntry(),
        ) ??
        [],
  );
  return object;
}

P _workoutDetailDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectList<WorkoutEntry>(
            offset,
            WorkoutEntrySchema.deserialize,
            allOffsets,
            WorkoutEntry(),
          ) ??
          []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _workoutDetailGetId(WorkoutDetail object) {
  return object.workoutID;
}

List<IsarLinkBase<dynamic>> _workoutDetailGetLinks(WorkoutDetail object) {
  return [];
}

void _workoutDetailAttach(
    IsarCollection<dynamic> col, Id id, WorkoutDetail object) {
  object.workoutID = id;
}

extension WorkoutDetailQueryWhereSort
    on QueryBuilder<WorkoutDetail, WorkoutDetail, QWhere> {
  QueryBuilder<WorkoutDetail, WorkoutDetail, QAfterWhere> anyWorkoutID() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension WorkoutDetailQueryWhere
    on QueryBuilder<WorkoutDetail, WorkoutDetail, QWhereClause> {
  QueryBuilder<WorkoutDetail, WorkoutDetail, QAfterWhereClause>
      workoutIDEqualTo(Id workoutID) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: workoutID,
        upper: workoutID,
      ));
    });
  }

  QueryBuilder<WorkoutDetail, WorkoutDetail, QAfterWhereClause>
      workoutIDNotEqualTo(Id workoutID) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: workoutID, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: workoutID, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: workoutID, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: workoutID, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<WorkoutDetail, WorkoutDetail, QAfterWhereClause>
      workoutIDGreaterThan(Id workoutID, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: workoutID, includeLower: include),
      );
    });
  }

  QueryBuilder<WorkoutDetail, WorkoutDetail, QAfterWhereClause>
      workoutIDLessThan(Id workoutID, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: workoutID, includeUpper: include),
      );
    });
  }

  QueryBuilder<WorkoutDetail, WorkoutDetail, QAfterWhereClause>
      workoutIDBetween(
    Id lowerWorkoutID,
    Id upperWorkoutID, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerWorkoutID,
        includeLower: includeLower,
        upper: upperWorkoutID,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension WorkoutDetailQueryFilter
    on QueryBuilder<WorkoutDetail, WorkoutDetail, QFilterCondition> {
  QueryBuilder<WorkoutDetail, WorkoutDetail, QAfterFilterCondition>
      workoutIDEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'workoutID',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutDetail, WorkoutDetail, QAfterFilterCondition>
      workoutIDGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'workoutID',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutDetail, WorkoutDetail, QAfterFilterCondition>
      workoutIDLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'workoutID',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutDetail, WorkoutDetail, QAfterFilterCondition>
      workoutIDBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'workoutID',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<WorkoutDetail, WorkoutDetail, QAfterFilterCondition>
      workoutsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'workouts',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<WorkoutDetail, WorkoutDetail, QAfterFilterCondition>
      workoutsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'workouts',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<WorkoutDetail, WorkoutDetail, QAfterFilterCondition>
      workoutsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'workouts',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<WorkoutDetail, WorkoutDetail, QAfterFilterCondition>
      workoutsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'workouts',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<WorkoutDetail, WorkoutDetail, QAfterFilterCondition>
      workoutsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'workouts',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<WorkoutDetail, WorkoutDetail, QAfterFilterCondition>
      workoutsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'workouts',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension WorkoutDetailQueryObject
    on QueryBuilder<WorkoutDetail, WorkoutDetail, QFilterCondition> {
  QueryBuilder<WorkoutDetail, WorkoutDetail, QAfterFilterCondition>
      workoutsElement(FilterQuery<WorkoutEntry> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'workouts');
    });
  }
}

extension WorkoutDetailQueryLinks
    on QueryBuilder<WorkoutDetail, WorkoutDetail, QFilterCondition> {}

extension WorkoutDetailQuerySortBy
    on QueryBuilder<WorkoutDetail, WorkoutDetail, QSortBy> {}

extension WorkoutDetailQuerySortThenBy
    on QueryBuilder<WorkoutDetail, WorkoutDetail, QSortThenBy> {
  QueryBuilder<WorkoutDetail, WorkoutDetail, QAfterSortBy> thenByWorkoutID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workoutID', Sort.asc);
    });
  }

  QueryBuilder<WorkoutDetail, WorkoutDetail, QAfterSortBy>
      thenByWorkoutIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workoutID', Sort.desc);
    });
  }
}

extension WorkoutDetailQueryWhereDistinct
    on QueryBuilder<WorkoutDetail, WorkoutDetail, QDistinct> {}

extension WorkoutDetailQueryProperty
    on QueryBuilder<WorkoutDetail, WorkoutDetail, QQueryProperty> {
  QueryBuilder<WorkoutDetail, int, QQueryOperations> workoutIDProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'workoutID');
    });
  }

  QueryBuilder<WorkoutDetail, List<WorkoutEntry>, QQueryOperations>
      workoutsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'workouts');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const SetsSchema = Schema(
  name: r'Sets',
  id: -4945140658945075270,
  properties: {
    r'reps': PropertySchema(
      id: 0,
      name: r'reps',
      type: IsarType.long,
    ),
    r'weight': PropertySchema(
      id: 1,
      name: r'weight',
      type: IsarType.double,
    )
  },
  estimateSize: _setsEstimateSize,
  serialize: _setsSerialize,
  deserialize: _setsDeserialize,
  deserializeProp: _setsDeserializeProp,
);

int _setsEstimateSize(
  Sets object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _setsSerialize(
  Sets object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.reps);
  writer.writeDouble(offsets[1], object.weight);
}

Sets _setsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Sets(
    reps: reader.readLongOrNull(offsets[0]) ?? 0,
    weight: reader.readDoubleOrNull(offsets[1]) ?? 0.0,
  );
  return object;
}

P _setsDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 1:
      return (reader.readDoubleOrNull(offset) ?? 0.0) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension SetsQueryFilter on QueryBuilder<Sets, Sets, QFilterCondition> {
  QueryBuilder<Sets, Sets, QAfterFilterCondition> repsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'reps',
        value: value,
      ));
    });
  }

  QueryBuilder<Sets, Sets, QAfterFilterCondition> repsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'reps',
        value: value,
      ));
    });
  }

  QueryBuilder<Sets, Sets, QAfterFilterCondition> repsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'reps',
        value: value,
      ));
    });
  }

  QueryBuilder<Sets, Sets, QAfterFilterCondition> repsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'reps',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Sets, Sets, QAfterFilterCondition> weightEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'weight',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Sets, Sets, QAfterFilterCondition> weightGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'weight',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Sets, Sets, QAfterFilterCondition> weightLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'weight',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Sets, Sets, QAfterFilterCondition> weightBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'weight',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension SetsQueryObject on QueryBuilder<Sets, Sets, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const SessionSchema = Schema(
  name: r'Session',
  id: 4817823809690647594,
  properties: {
    r'dateTime': PropertySchema(
      id: 0,
      name: r'dateTime',
      type: IsarType.dateTime,
    ),
    r'sets': PropertySchema(
      id: 1,
      name: r'sets',
      type: IsarType.objectList,
      target: r'Sets',
    )
  },
  estimateSize: _sessionEstimateSize,
  serialize: _sessionSerialize,
  deserialize: _sessionDeserialize,
  deserializeProp: _sessionDeserializeProp,
);

int _sessionEstimateSize(
  Session object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.sets.length * 3;
  {
    final offsets = allOffsets[Sets]!;
    for (var i = 0; i < object.sets.length; i++) {
      final value = object.sets[i];
      bytesCount += SetsSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  return bytesCount;
}

void _sessionSerialize(
  Session object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.dateTime);
  writer.writeObjectList<Sets>(
    offsets[1],
    allOffsets,
    SetsSchema.serialize,
    object.sets,
  );
}

Session _sessionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Session();
  object.dateTime = reader.readDateTime(offsets[0]);
  object.sets = reader.readObjectList<Sets>(
        offsets[1],
        SetsSchema.deserialize,
        allOffsets,
        Sets(),
      ) ??
      [];
  return object;
}

P _sessionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readObjectList<Sets>(
            offset,
            SetsSchema.deserialize,
            allOffsets,
            Sets(),
          ) ??
          []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension SessionQueryFilter
    on QueryBuilder<Session, Session, QFilterCondition> {
  QueryBuilder<Session, Session, QAfterFilterCondition> dateTimeEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<Session, Session, QAfterFilterCondition> dateTimeGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<Session, Session, QAfterFilterCondition> dateTimeLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<Session, Session, QAfterFilterCondition> dateTimeBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dateTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Session, Session, QAfterFilterCondition> setsLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'sets',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Session, Session, QAfterFilterCondition> setsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'sets',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Session, Session, QAfterFilterCondition> setsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'sets',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Session, Session, QAfterFilterCondition> setsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'sets',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Session, Session, QAfterFilterCondition> setsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'sets',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Session, Session, QAfterFilterCondition> setsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'sets',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension SessionQueryObject
    on QueryBuilder<Session, Session, QFilterCondition> {
  QueryBuilder<Session, Session, QAfterFilterCondition> setsElement(
      FilterQuery<Sets> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'sets');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const WorkoutEntrySchema = Schema(
  name: r'WorkoutEntry',
  id: -2682324398368231174,
  properties: {
    r'logs': PropertySchema(
      id: 0,
      name: r'logs',
      type: IsarType.objectList,
      target: r'Session',
    ),
    r'name': PropertySchema(
      id: 1,
      name: r'name',
      type: IsarType.string,
    )
  },
  estimateSize: _workoutEntryEstimateSize,
  serialize: _workoutEntrySerialize,
  deserialize: _workoutEntryDeserialize,
  deserializeProp: _workoutEntryDeserializeProp,
);

int _workoutEntryEstimateSize(
  WorkoutEntry object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.logs.length * 3;
  {
    final offsets = allOffsets[Session]!;
    for (var i = 0; i < object.logs.length; i++) {
      final value = object.logs[i];
      bytesCount += SessionSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  bytesCount += 3 + object.name.length * 3;
  return bytesCount;
}

void _workoutEntrySerialize(
  WorkoutEntry object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObjectList<Session>(
    offsets[0],
    allOffsets,
    SessionSchema.serialize,
    object.logs,
  );
  writer.writeString(offsets[1], object.name);
}

WorkoutEntry _workoutEntryDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = WorkoutEntry();
  object.logs = reader.readObjectList<Session>(
        offsets[0],
        SessionSchema.deserialize,
        allOffsets,
        Session(),
      ) ??
      [];
  object.name = reader.readString(offsets[1]);
  return object;
}

P _workoutEntryDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectList<Session>(
            offset,
            SessionSchema.deserialize,
            allOffsets,
            Session(),
          ) ??
          []) as P;
    case 1:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension WorkoutEntryQueryFilter
    on QueryBuilder<WorkoutEntry, WorkoutEntry, QFilterCondition> {
  QueryBuilder<WorkoutEntry, WorkoutEntry, QAfterFilterCondition>
      logsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'logs',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<WorkoutEntry, WorkoutEntry, QAfterFilterCondition>
      logsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'logs',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<WorkoutEntry, WorkoutEntry, QAfterFilterCondition>
      logsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'logs',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<WorkoutEntry, WorkoutEntry, QAfterFilterCondition>
      logsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'logs',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<WorkoutEntry, WorkoutEntry, QAfterFilterCondition>
      logsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'logs',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<WorkoutEntry, WorkoutEntry, QAfterFilterCondition>
      logsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'logs',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<WorkoutEntry, WorkoutEntry, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutEntry, WorkoutEntry, QAfterFilterCondition>
      nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutEntry, WorkoutEntry, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutEntry, WorkoutEntry, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutEntry, WorkoutEntry, QAfterFilterCondition>
      nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutEntry, WorkoutEntry, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutEntry, WorkoutEntry, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutEntry, WorkoutEntry, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutEntry, WorkoutEntry, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<WorkoutEntry, WorkoutEntry, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }
}

extension WorkoutEntryQueryObject
    on QueryBuilder<WorkoutEntry, WorkoutEntry, QFilterCondition> {
  QueryBuilder<WorkoutEntry, WorkoutEntry, QAfterFilterCondition> logsElement(
      FilterQuery<Session> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'logs');
    });
  }
}
