// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_isar.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetMuscleGroupCollection on Isar {
  IsarCollection<MuscleGroup> get muscleGroups => this.collection();
}

const MuscleGroupSchema = CollectionSchema(
  name: r'MuscleGroup',
  id: -4041869078048828678,
  properties: {
    r'color': PropertySchema(
      id: 0,
      name: r'color',
      type: IsarType.long,
    ),
    r'text': PropertySchema(
      id: 1,
      name: r'text',
      type: IsarType.string,
    )
  },
  estimateSize: _muscleGroupEstimateSize,
  serialize: _muscleGroupSerialize,
  deserialize: _muscleGroupDeserialize,
  deserializeProp: _muscleGroupDeserializeProp,
  idName: r'groupID',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _muscleGroupGetId,
  getLinks: _muscleGroupGetLinks,
  attach: _muscleGroupAttach,
  version: '3.1.0+1',
);

int _muscleGroupEstimateSize(
  MuscleGroup object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.text.length * 3;
  return bytesCount;
}

void _muscleGroupSerialize(
  MuscleGroup object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.color);
  writer.writeString(offsets[1], object.text);
}

MuscleGroup _muscleGroupDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MuscleGroup(
    color: reader.readLong(offsets[0]),
    text: reader.readString(offsets[1]),
  );
  object.groupID = id;
  return object;
}

P _muscleGroupDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _muscleGroupGetId(MuscleGroup object) {
  return object.groupID;
}

List<IsarLinkBase<dynamic>> _muscleGroupGetLinks(MuscleGroup object) {
  return [];
}

void _muscleGroupAttach(
    IsarCollection<dynamic> col, Id id, MuscleGroup object) {
  object.groupID = id;
}

extension MuscleGroupQueryWhereSort
    on QueryBuilder<MuscleGroup, MuscleGroup, QWhere> {
  QueryBuilder<MuscleGroup, MuscleGroup, QAfterWhere> anyGroupID() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension MuscleGroupQueryWhere
    on QueryBuilder<MuscleGroup, MuscleGroup, QWhereClause> {
  QueryBuilder<MuscleGroup, MuscleGroup, QAfterWhereClause> groupIDEqualTo(
      Id groupID) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: groupID,
        upper: groupID,
      ));
    });
  }

  QueryBuilder<MuscleGroup, MuscleGroup, QAfterWhereClause> groupIDNotEqualTo(
      Id groupID) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: groupID, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: groupID, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: groupID, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: groupID, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<MuscleGroup, MuscleGroup, QAfterWhereClause> groupIDGreaterThan(
      Id groupID,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: groupID, includeLower: include),
      );
    });
  }

  QueryBuilder<MuscleGroup, MuscleGroup, QAfterWhereClause> groupIDLessThan(
      Id groupID,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: groupID, includeUpper: include),
      );
    });
  }

  QueryBuilder<MuscleGroup, MuscleGroup, QAfterWhereClause> groupIDBetween(
    Id lowerGroupID,
    Id upperGroupID, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerGroupID,
        includeLower: includeLower,
        upper: upperGroupID,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension MuscleGroupQueryFilter
    on QueryBuilder<MuscleGroup, MuscleGroup, QFilterCondition> {
  QueryBuilder<MuscleGroup, MuscleGroup, QAfterFilterCondition> colorEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'color',
        value: value,
      ));
    });
  }

  QueryBuilder<MuscleGroup, MuscleGroup, QAfterFilterCondition>
      colorGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'color',
        value: value,
      ));
    });
  }

  QueryBuilder<MuscleGroup, MuscleGroup, QAfterFilterCondition> colorLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'color',
        value: value,
      ));
    });
  }

  QueryBuilder<MuscleGroup, MuscleGroup, QAfterFilterCondition> colorBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'color',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MuscleGroup, MuscleGroup, QAfterFilterCondition> groupIDEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'groupID',
        value: value,
      ));
    });
  }

  QueryBuilder<MuscleGroup, MuscleGroup, QAfterFilterCondition>
      groupIDGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'groupID',
        value: value,
      ));
    });
  }

  QueryBuilder<MuscleGroup, MuscleGroup, QAfterFilterCondition> groupIDLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'groupID',
        value: value,
      ));
    });
  }

  QueryBuilder<MuscleGroup, MuscleGroup, QAfterFilterCondition> groupIDBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'groupID',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MuscleGroup, MuscleGroup, QAfterFilterCondition> textEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MuscleGroup, MuscleGroup, QAfterFilterCondition> textGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MuscleGroup, MuscleGroup, QAfterFilterCondition> textLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MuscleGroup, MuscleGroup, QAfterFilterCondition> textBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'text',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MuscleGroup, MuscleGroup, QAfterFilterCondition> textStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MuscleGroup, MuscleGroup, QAfterFilterCondition> textEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MuscleGroup, MuscleGroup, QAfterFilterCondition> textContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MuscleGroup, MuscleGroup, QAfterFilterCondition> textMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'text',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MuscleGroup, MuscleGroup, QAfterFilterCondition> textIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'text',
        value: '',
      ));
    });
  }

  QueryBuilder<MuscleGroup, MuscleGroup, QAfterFilterCondition>
      textIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'text',
        value: '',
      ));
    });
  }
}

extension MuscleGroupQueryObject
    on QueryBuilder<MuscleGroup, MuscleGroup, QFilterCondition> {}

extension MuscleGroupQueryLinks
    on QueryBuilder<MuscleGroup, MuscleGroup, QFilterCondition> {}

extension MuscleGroupQuerySortBy
    on QueryBuilder<MuscleGroup, MuscleGroup, QSortBy> {
  QueryBuilder<MuscleGroup, MuscleGroup, QAfterSortBy> sortByColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.asc);
    });
  }

  QueryBuilder<MuscleGroup, MuscleGroup, QAfterSortBy> sortByColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.desc);
    });
  }

  QueryBuilder<MuscleGroup, MuscleGroup, QAfterSortBy> sortByText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'text', Sort.asc);
    });
  }

  QueryBuilder<MuscleGroup, MuscleGroup, QAfterSortBy> sortByTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'text', Sort.desc);
    });
  }
}

extension MuscleGroupQuerySortThenBy
    on QueryBuilder<MuscleGroup, MuscleGroup, QSortThenBy> {
  QueryBuilder<MuscleGroup, MuscleGroup, QAfterSortBy> thenByColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.asc);
    });
  }

  QueryBuilder<MuscleGroup, MuscleGroup, QAfterSortBy> thenByColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.desc);
    });
  }

  QueryBuilder<MuscleGroup, MuscleGroup, QAfterSortBy> thenByGroupID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupID', Sort.asc);
    });
  }

  QueryBuilder<MuscleGroup, MuscleGroup, QAfterSortBy> thenByGroupIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupID', Sort.desc);
    });
  }

  QueryBuilder<MuscleGroup, MuscleGroup, QAfterSortBy> thenByText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'text', Sort.asc);
    });
  }

  QueryBuilder<MuscleGroup, MuscleGroup, QAfterSortBy> thenByTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'text', Sort.desc);
    });
  }
}

extension MuscleGroupQueryWhereDistinct
    on QueryBuilder<MuscleGroup, MuscleGroup, QDistinct> {
  QueryBuilder<MuscleGroup, MuscleGroup, QDistinct> distinctByColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'color');
    });
  }

  QueryBuilder<MuscleGroup, MuscleGroup, QDistinct> distinctByText(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'text', caseSensitive: caseSensitive);
    });
  }
}

extension MuscleGroupQueryProperty
    on QueryBuilder<MuscleGroup, MuscleGroup, QQueryProperty> {
  QueryBuilder<MuscleGroup, int, QQueryOperations> groupIDProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'groupID');
    });
  }

  QueryBuilder<MuscleGroup, int, QQueryOperations> colorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'color');
    });
  }

  QueryBuilder<MuscleGroup, String, QQueryOperations> textProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'text');
    });
  }
}
