// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetGoalCollectionCollection on Isar {
  IsarCollection<GoalCollection> get goalCollections => this.collection();
}

const GoalCollectionSchema = CollectionSchema(
  name: r'GoalCollection',
  id: 6130276113898411035,
  properties: {
    r'aiLastCoachMessage': PropertySchema(
      id: 0,
      name: r'aiLastCoachMessage',
      type: IsarType.string,
    ),
    r'category': PropertySchema(
      id: 1,
      name: r'category',
      type: IsarType.string,
    ),
    r'completedAt': PropertySchema(
      id: 2,
      name: r'completedAt',
      type: IsarType.dateTime,
    ),
    r'createdAt': PropertySchema(
      id: 3,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'currentProgress': PropertySchema(
      id: 4,
      name: r'currentProgress',
      type: IsarType.double,
    ),
    r'goalId': PropertySchema(
      id: 5,
      name: r'goalId',
      type: IsarType.string,
    ),
    r'isCompleted': PropertySchema(
      id: 6,
      name: r'isCompleted',
      type: IsarType.bool,
    ),
    r'isPrimary': PropertySchema(
      id: 7,
      name: r'isPrimary',
      type: IsarType.bool,
    ),
    r'milestonePercentages': PropertySchema(
      id: 8,
      name: r'milestonePercentages',
      type: IsarType.longList,
    ),
    r'milestonesReached': PropertySchema(
      id: 9,
      name: r'milestonesReached',
      type: IsarType.longList,
    ),
    r'name': PropertySchema(
      id: 10,
      name: r'name',
      type: IsarType.string,
    ),
    r'targetAmount': PropertySchema(
      id: 11,
      name: r'targetAmount',
      type: IsarType.double,
    )
  },
  estimateSize: _goalCollectionEstimateSize,
  serialize: _goalCollectionSerialize,
  deserialize: _goalCollectionDeserialize,
  deserializeProp: _goalCollectionDeserializeProp,
  idName: r'id',
  indexes: {
    r'goalId': IndexSchema(
      id: 2738626632585230611,
      name: r'goalId',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'goalId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _goalCollectionGetId,
  getLinks: _goalCollectionGetLinks,
  attach: _goalCollectionAttach,
  version: '3.1.0+1',
);

int _goalCollectionEstimateSize(
  GoalCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.aiLastCoachMessage;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.category.length * 3;
  bytesCount += 3 + object.goalId.length * 3;
  bytesCount += 3 + object.milestonePercentages.length * 8;
  bytesCount += 3 + object.milestonesReached.length * 8;
  bytesCount += 3 + object.name.length * 3;
  return bytesCount;
}

void _goalCollectionSerialize(
  GoalCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.aiLastCoachMessage);
  writer.writeString(offsets[1], object.category);
  writer.writeDateTime(offsets[2], object.completedAt);
  writer.writeDateTime(offsets[3], object.createdAt);
  writer.writeDouble(offsets[4], object.currentProgress);
  writer.writeString(offsets[5], object.goalId);
  writer.writeBool(offsets[6], object.isCompleted);
  writer.writeBool(offsets[7], object.isPrimary);
  writer.writeLongList(offsets[8], object.milestonePercentages);
  writer.writeLongList(offsets[9], object.milestonesReached);
  writer.writeString(offsets[10], object.name);
  writer.writeDouble(offsets[11], object.targetAmount);
}

GoalCollection _goalCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = GoalCollection();
  object.aiLastCoachMessage = reader.readStringOrNull(offsets[0]);
  object.category = reader.readString(offsets[1]);
  object.completedAt = reader.readDateTimeOrNull(offsets[2]);
  object.createdAt = reader.readDateTime(offsets[3]);
  object.currentProgress = reader.readDouble(offsets[4]);
  object.goalId = reader.readString(offsets[5]);
  object.id = id;
  object.isCompleted = reader.readBool(offsets[6]);
  object.isPrimary = reader.readBool(offsets[7]);
  object.milestonePercentages = reader.readLongList(offsets[8]) ?? [];
  object.milestonesReached = reader.readLongList(offsets[9]) ?? [];
  object.name = reader.readString(offsets[10]);
  object.targetAmount = reader.readDouble(offsets[11]);
  return object;
}

P _goalCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readDouble(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readBool(offset)) as P;
    case 7:
      return (reader.readBool(offset)) as P;
    case 8:
      return (reader.readLongList(offset) ?? []) as P;
    case 9:
      return (reader.readLongList(offset) ?? []) as P;
    case 10:
      return (reader.readString(offset)) as P;
    case 11:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _goalCollectionGetId(GoalCollection object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _goalCollectionGetLinks(GoalCollection object) {
  return [];
}

void _goalCollectionAttach(
    IsarCollection<dynamic> col, Id id, GoalCollection object) {
  object.id = id;
}

extension GoalCollectionByIndex on IsarCollection<GoalCollection> {
  Future<GoalCollection?> getByGoalId(String goalId) {
    return getByIndex(r'goalId', [goalId]);
  }

  GoalCollection? getByGoalIdSync(String goalId) {
    return getByIndexSync(r'goalId', [goalId]);
  }

  Future<bool> deleteByGoalId(String goalId) {
    return deleteByIndex(r'goalId', [goalId]);
  }

  bool deleteByGoalIdSync(String goalId) {
    return deleteByIndexSync(r'goalId', [goalId]);
  }

  Future<List<GoalCollection?>> getAllByGoalId(List<String> goalIdValues) {
    final values = goalIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'goalId', values);
  }

  List<GoalCollection?> getAllByGoalIdSync(List<String> goalIdValues) {
    final values = goalIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'goalId', values);
  }

  Future<int> deleteAllByGoalId(List<String> goalIdValues) {
    final values = goalIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'goalId', values);
  }

  int deleteAllByGoalIdSync(List<String> goalIdValues) {
    final values = goalIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'goalId', values);
  }

  Future<Id> putByGoalId(GoalCollection object) {
    return putByIndex(r'goalId', object);
  }

  Id putByGoalIdSync(GoalCollection object, {bool saveLinks = true}) {
    return putByIndexSync(r'goalId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByGoalId(List<GoalCollection> objects) {
    return putAllByIndex(r'goalId', objects);
  }

  List<Id> putAllByGoalIdSync(List<GoalCollection> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'goalId', objects, saveLinks: saveLinks);
  }
}

extension GoalCollectionQueryWhereSort
    on QueryBuilder<GoalCollection, GoalCollection, QWhere> {
  QueryBuilder<GoalCollection, GoalCollection, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension GoalCollectionQueryWhere
    on QueryBuilder<GoalCollection, GoalCollection, QWhereClause> {
  QueryBuilder<GoalCollection, GoalCollection, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterWhereClause> goalIdEqualTo(
      String goalId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'goalId',
        value: [goalId],
      ));
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterWhereClause>
      goalIdNotEqualTo(String goalId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'goalId',
              lower: [],
              upper: [goalId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'goalId',
              lower: [goalId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'goalId',
              lower: [goalId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'goalId',
              lower: [],
              upper: [goalId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension GoalCollectionQueryFilter
    on QueryBuilder<GoalCollection, GoalCollection, QFilterCondition> {
  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      aiLastCoachMessageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'aiLastCoachMessage',
      ));
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      aiLastCoachMessageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'aiLastCoachMessage',
      ));
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      aiLastCoachMessageEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'aiLastCoachMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      aiLastCoachMessageGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'aiLastCoachMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      aiLastCoachMessageLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'aiLastCoachMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      aiLastCoachMessageBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'aiLastCoachMessage',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      aiLastCoachMessageStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'aiLastCoachMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      aiLastCoachMessageEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'aiLastCoachMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      aiLastCoachMessageContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'aiLastCoachMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      aiLastCoachMessageMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'aiLastCoachMessage',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      aiLastCoachMessageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'aiLastCoachMessage',
        value: '',
      ));
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      aiLastCoachMessageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'aiLastCoachMessage',
        value: '',
      ));
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      categoryEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      categoryGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      categoryLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      categoryBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'category',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      categoryStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      categoryEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      categoryContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      categoryMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'category',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      categoryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      categoryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      completedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'completedAt',
      ));
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      completedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'completedAt',
      ));
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      completedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'completedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      completedAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'completedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      completedAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'completedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      completedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'completedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      currentProgressEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currentProgress',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      currentProgressGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'currentProgress',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      currentProgressLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'currentProgress',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      currentProgressBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'currentProgress',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      goalIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'goalId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      goalIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'goalId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      goalIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'goalId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      goalIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'goalId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      goalIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'goalId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      goalIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'goalId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      goalIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'goalId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      goalIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'goalId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      goalIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'goalId',
        value: '',
      ));
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      goalIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'goalId',
        value: '',
      ));
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      isCompletedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isCompleted',
        value: value,
      ));
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      isPrimaryEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isPrimary',
        value: value,
      ));
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      milestonePercentagesElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'milestonePercentages',
        value: value,
      ));
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      milestonePercentagesElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'milestonePercentages',
        value: value,
      ));
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      milestonePercentagesElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'milestonePercentages',
        value: value,
      ));
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      milestonePercentagesElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'milestonePercentages',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      milestonePercentagesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'milestonePercentages',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      milestonePercentagesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'milestonePercentages',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      milestonePercentagesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'milestonePercentages',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      milestonePercentagesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'milestonePercentages',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      milestonePercentagesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'milestonePercentages',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      milestonePercentagesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'milestonePercentages',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      milestonesReachedElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'milestonesReached',
        value: value,
      ));
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      milestonesReachedElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'milestonesReached',
        value: value,
      ));
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      milestonesReachedElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'milestonesReached',
        value: value,
      ));
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      milestonesReachedElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'milestonesReached',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      milestonesReachedLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'milestonesReached',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      milestonesReachedIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'milestonesReached',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      milestonesReachedIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'milestonesReached',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      milestonesReachedLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'milestonesReached',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      milestonesReachedLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'milestonesReached',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      milestonesReachedLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'milestonesReached',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      nameEqualTo(
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

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
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

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      nameLessThan(
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

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      nameBetween(
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

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
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

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      nameEndsWith(
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

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      targetAmountEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'targetAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      targetAmountGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'targetAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      targetAmountLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'targetAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterFilterCondition>
      targetAmountBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'targetAmount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension GoalCollectionQueryObject
    on QueryBuilder<GoalCollection, GoalCollection, QFilterCondition> {}

extension GoalCollectionQueryLinks
    on QueryBuilder<GoalCollection, GoalCollection, QFilterCondition> {}

extension GoalCollectionQuerySortBy
    on QueryBuilder<GoalCollection, GoalCollection, QSortBy> {
  QueryBuilder<GoalCollection, GoalCollection, QAfterSortBy>
      sortByAiLastCoachMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aiLastCoachMessage', Sort.asc);
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterSortBy>
      sortByAiLastCoachMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aiLastCoachMessage', Sort.desc);
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterSortBy> sortByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterSortBy>
      sortByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterSortBy>
      sortByCompletedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedAt', Sort.asc);
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterSortBy>
      sortByCompletedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedAt', Sort.desc);
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterSortBy>
      sortByCurrentProgress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentProgress', Sort.asc);
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterSortBy>
      sortByCurrentProgressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentProgress', Sort.desc);
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterSortBy> sortByGoalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goalId', Sort.asc);
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterSortBy>
      sortByGoalIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goalId', Sort.desc);
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterSortBy>
      sortByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.asc);
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterSortBy>
      sortByIsCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.desc);
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterSortBy> sortByIsPrimary() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPrimary', Sort.asc);
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterSortBy>
      sortByIsPrimaryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPrimary', Sort.desc);
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterSortBy>
      sortByTargetAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetAmount', Sort.asc);
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterSortBy>
      sortByTargetAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetAmount', Sort.desc);
    });
  }
}

extension GoalCollectionQuerySortThenBy
    on QueryBuilder<GoalCollection, GoalCollection, QSortThenBy> {
  QueryBuilder<GoalCollection, GoalCollection, QAfterSortBy>
      thenByAiLastCoachMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aiLastCoachMessage', Sort.asc);
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterSortBy>
      thenByAiLastCoachMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aiLastCoachMessage', Sort.desc);
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterSortBy> thenByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterSortBy>
      thenByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterSortBy>
      thenByCompletedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedAt', Sort.asc);
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterSortBy>
      thenByCompletedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedAt', Sort.desc);
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterSortBy>
      thenByCurrentProgress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentProgress', Sort.asc);
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterSortBy>
      thenByCurrentProgressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentProgress', Sort.desc);
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterSortBy> thenByGoalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goalId', Sort.asc);
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterSortBy>
      thenByGoalIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goalId', Sort.desc);
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterSortBy>
      thenByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.asc);
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterSortBy>
      thenByIsCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.desc);
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterSortBy> thenByIsPrimary() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPrimary', Sort.asc);
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterSortBy>
      thenByIsPrimaryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPrimary', Sort.desc);
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterSortBy>
      thenByTargetAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetAmount', Sort.asc);
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QAfterSortBy>
      thenByTargetAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetAmount', Sort.desc);
    });
  }
}

extension GoalCollectionQueryWhereDistinct
    on QueryBuilder<GoalCollection, GoalCollection, QDistinct> {
  QueryBuilder<GoalCollection, GoalCollection, QDistinct>
      distinctByAiLastCoachMessage({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'aiLastCoachMessage',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QDistinct> distinctByCategory(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'category', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QDistinct>
      distinctByCompletedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'completedAt');
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QDistinct>
      distinctByCurrentProgress() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'currentProgress');
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QDistinct> distinctByGoalId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'goalId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QDistinct>
      distinctByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isCompleted');
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QDistinct>
      distinctByIsPrimary() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isPrimary');
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QDistinct>
      distinctByMilestonePercentages() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'milestonePercentages');
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QDistinct>
      distinctByMilestonesReached() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'milestonesReached');
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GoalCollection, GoalCollection, QDistinct>
      distinctByTargetAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'targetAmount');
    });
  }
}

extension GoalCollectionQueryProperty
    on QueryBuilder<GoalCollection, GoalCollection, QQueryProperty> {
  QueryBuilder<GoalCollection, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<GoalCollection, String?, QQueryOperations>
      aiLastCoachMessageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'aiLastCoachMessage');
    });
  }

  QueryBuilder<GoalCollection, String, QQueryOperations> categoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'category');
    });
  }

  QueryBuilder<GoalCollection, DateTime?, QQueryOperations>
      completedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'completedAt');
    });
  }

  QueryBuilder<GoalCollection, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<GoalCollection, double, QQueryOperations>
      currentProgressProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'currentProgress');
    });
  }

  QueryBuilder<GoalCollection, String, QQueryOperations> goalIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'goalId');
    });
  }

  QueryBuilder<GoalCollection, bool, QQueryOperations> isCompletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isCompleted');
    });
  }

  QueryBuilder<GoalCollection, bool, QQueryOperations> isPrimaryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isPrimary');
    });
  }

  QueryBuilder<GoalCollection, List<int>, QQueryOperations>
      milestonePercentagesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'milestonePercentages');
    });
  }

  QueryBuilder<GoalCollection, List<int>, QQueryOperations>
      milestonesReachedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'milestonesReached');
    });
  }

  QueryBuilder<GoalCollection, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<GoalCollection, double, QQueryOperations>
      targetAmountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'targetAmount');
    });
  }
}
