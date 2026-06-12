// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'financial_health_snapshot.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetFinancialHealthSnapshotCollectionCollection on Isar {
  IsarCollection<FinancialHealthSnapshotCollection>
      get financialHealthSnapshotCollections => this.collection();
}

const FinancialHealthSnapshotCollectionSchema = CollectionSchema(
  name: r'FinancialHealthSnapshotCollection',
  id: -6765480476577061755,
  properties: {
    r'aiExplanation': PropertySchema(
      id: 0,
      name: r'aiExplanation',
      type: IsarType.string,
    ),
    r'aiImprovementTip': PropertySchema(
      id: 1,
      name: r'aiImprovementTip',
      type: IsarType.string,
    ),
    r'consistencySubScore': PropertySchema(
      id: 2,
      name: r'consistencySubScore',
      type: IsarType.long,
    ),
    r'goalSubScore': PropertySchema(
      id: 3,
      name: r'goalSubScore',
      type: IsarType.long,
    ),
    r'recordedAt': PropertySchema(
      id: 4,
      name: r'recordedAt',
      type: IsarType.dateTime,
    ),
    r'savingsSubScore': PropertySchema(
      id: 5,
      name: r'savingsSubScore',
      type: IsarType.long,
    ),
    r'score': PropertySchema(
      id: 6,
      name: r'score',
      type: IsarType.long,
    ),
    r'snapshotId': PropertySchema(
      id: 7,
      name: r'snapshotId',
      type: IsarType.string,
    ),
    r'spendingSubScore': PropertySchema(
      id: 8,
      name: r'spendingSubScore',
      type: IsarType.long,
    ),
    r'stabilitySubScore': PropertySchema(
      id: 9,
      name: r'stabilitySubScore',
      type: IsarType.long,
    )
  },
  estimateSize: _financialHealthSnapshotCollectionEstimateSize,
  serialize: _financialHealthSnapshotCollectionSerialize,
  deserialize: _financialHealthSnapshotCollectionDeserialize,
  deserializeProp: _financialHealthSnapshotCollectionDeserializeProp,
  idName: r'id',
  indexes: {
    r'snapshotId': IndexSchema(
      id: -7574188874426247601,
      name: r'snapshotId',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'snapshotId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _financialHealthSnapshotCollectionGetId,
  getLinks: _financialHealthSnapshotCollectionGetLinks,
  attach: _financialHealthSnapshotCollectionAttach,
  version: '3.1.0+1',
);

int _financialHealthSnapshotCollectionEstimateSize(
  FinancialHealthSnapshotCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.aiExplanation.length * 3;
  bytesCount += 3 + object.aiImprovementTip.length * 3;
  bytesCount += 3 + object.snapshotId.length * 3;
  return bytesCount;
}

void _financialHealthSnapshotCollectionSerialize(
  FinancialHealthSnapshotCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.aiExplanation);
  writer.writeString(offsets[1], object.aiImprovementTip);
  writer.writeLong(offsets[2], object.consistencySubScore);
  writer.writeLong(offsets[3], object.goalSubScore);
  writer.writeDateTime(offsets[4], object.recordedAt);
  writer.writeLong(offsets[5], object.savingsSubScore);
  writer.writeLong(offsets[6], object.score);
  writer.writeString(offsets[7], object.snapshotId);
  writer.writeLong(offsets[8], object.spendingSubScore);
  writer.writeLong(offsets[9], object.stabilitySubScore);
}

FinancialHealthSnapshotCollection _financialHealthSnapshotCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = FinancialHealthSnapshotCollection();
  object.aiExplanation = reader.readString(offsets[0]);
  object.aiImprovementTip = reader.readString(offsets[1]);
  object.consistencySubScore = reader.readLong(offsets[2]);
  object.goalSubScore = reader.readLong(offsets[3]);
  object.id = id;
  object.recordedAt = reader.readDateTime(offsets[4]);
  object.savingsSubScore = reader.readLong(offsets[5]);
  object.score = reader.readLong(offsets[6]);
  object.snapshotId = reader.readString(offsets[7]);
  object.spendingSubScore = reader.readLong(offsets[8]);
  object.stabilitySubScore = reader.readLong(offsets[9]);
  return object;
}

P _financialHealthSnapshotCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readDateTime(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readLong(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readLong(offset)) as P;
    case 9:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _financialHealthSnapshotCollectionGetId(
    FinancialHealthSnapshotCollection object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _financialHealthSnapshotCollectionGetLinks(
    FinancialHealthSnapshotCollection object) {
  return [];
}

void _financialHealthSnapshotCollectionAttach(IsarCollection<dynamic> col,
    Id id, FinancialHealthSnapshotCollection object) {
  object.id = id;
}

extension FinancialHealthSnapshotCollectionByIndex
    on IsarCollection<FinancialHealthSnapshotCollection> {
  Future<FinancialHealthSnapshotCollection?> getBySnapshotId(
      String snapshotId) {
    return getByIndex(r'snapshotId', [snapshotId]);
  }

  FinancialHealthSnapshotCollection? getBySnapshotIdSync(String snapshotId) {
    return getByIndexSync(r'snapshotId', [snapshotId]);
  }

  Future<bool> deleteBySnapshotId(String snapshotId) {
    return deleteByIndex(r'snapshotId', [snapshotId]);
  }

  bool deleteBySnapshotIdSync(String snapshotId) {
    return deleteByIndexSync(r'snapshotId', [snapshotId]);
  }

  Future<List<FinancialHealthSnapshotCollection?>> getAllBySnapshotId(
      List<String> snapshotIdValues) {
    final values = snapshotIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'snapshotId', values);
  }

  List<FinancialHealthSnapshotCollection?> getAllBySnapshotIdSync(
      List<String> snapshotIdValues) {
    final values = snapshotIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'snapshotId', values);
  }

  Future<int> deleteAllBySnapshotId(List<String> snapshotIdValues) {
    final values = snapshotIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'snapshotId', values);
  }

  int deleteAllBySnapshotIdSync(List<String> snapshotIdValues) {
    final values = snapshotIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'snapshotId', values);
  }

  Future<Id> putBySnapshotId(FinancialHealthSnapshotCollection object) {
    return putByIndex(r'snapshotId', object);
  }

  Id putBySnapshotIdSync(FinancialHealthSnapshotCollection object,
      {bool saveLinks = true}) {
    return putByIndexSync(r'snapshotId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllBySnapshotId(
      List<FinancialHealthSnapshotCollection> objects) {
    return putAllByIndex(r'snapshotId', objects);
  }

  List<Id> putAllBySnapshotIdSync(
      List<FinancialHealthSnapshotCollection> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'snapshotId', objects, saveLinks: saveLinks);
  }
}

extension FinancialHealthSnapshotCollectionQueryWhereSort on QueryBuilder<
    FinancialHealthSnapshotCollection,
    FinancialHealthSnapshotCollection,
    QWhere> {
  QueryBuilder<FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension FinancialHealthSnapshotCollectionQueryWhere on QueryBuilder<
    FinancialHealthSnapshotCollection,
    FinancialHealthSnapshotCollection,
    QWhereClause> {
  QueryBuilder<FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QAfterWhereClause> idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QAfterWhereClause> idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection, QAfterWhereClause> idBetween(
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

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QAfterWhereClause> snapshotIdEqualTo(String snapshotId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'snapshotId',
        value: [snapshotId],
      ));
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QAfterWhereClause> snapshotIdNotEqualTo(String snapshotId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'snapshotId',
              lower: [],
              upper: [snapshotId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'snapshotId',
              lower: [snapshotId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'snapshotId',
              lower: [snapshotId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'snapshotId',
              lower: [],
              upper: [snapshotId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension FinancialHealthSnapshotCollectionQueryFilter on QueryBuilder<
    FinancialHealthSnapshotCollection,
    FinancialHealthSnapshotCollection,
    QFilterCondition> {
  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QAfterFilterCondition> aiExplanationEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'aiExplanation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QAfterFilterCondition> aiExplanationGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'aiExplanation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QAfterFilterCondition> aiExplanationLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'aiExplanation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QAfterFilterCondition> aiExplanationBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'aiExplanation',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QAfterFilterCondition> aiExplanationStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'aiExplanation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QAfterFilterCondition> aiExplanationEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'aiExplanation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FinancialHealthSnapshotCollection,
          FinancialHealthSnapshotCollection, QAfterFilterCondition>
      aiExplanationContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'aiExplanation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FinancialHealthSnapshotCollection,
          FinancialHealthSnapshotCollection, QAfterFilterCondition>
      aiExplanationMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'aiExplanation',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QAfterFilterCondition> aiExplanationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'aiExplanation',
        value: '',
      ));
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QAfterFilterCondition> aiExplanationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'aiExplanation',
        value: '',
      ));
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QAfterFilterCondition> aiImprovementTipEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'aiImprovementTip',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QAfterFilterCondition> aiImprovementTipGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'aiImprovementTip',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QAfterFilterCondition> aiImprovementTipLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'aiImprovementTip',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QAfterFilterCondition> aiImprovementTipBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'aiImprovementTip',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QAfterFilterCondition> aiImprovementTipStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'aiImprovementTip',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QAfterFilterCondition> aiImprovementTipEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'aiImprovementTip',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FinancialHealthSnapshotCollection,
          FinancialHealthSnapshotCollection, QAfterFilterCondition>
      aiImprovementTipContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'aiImprovementTip',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FinancialHealthSnapshotCollection,
          FinancialHealthSnapshotCollection, QAfterFilterCondition>
      aiImprovementTipMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'aiImprovementTip',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QAfterFilterCondition> aiImprovementTipIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'aiImprovementTip',
        value: '',
      ));
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QAfterFilterCondition> aiImprovementTipIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'aiImprovementTip',
        value: '',
      ));
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QAfterFilterCondition> consistencySubScoreEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'consistencySubScore',
        value: value,
      ));
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QAfterFilterCondition> consistencySubScoreGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'consistencySubScore',
        value: value,
      ));
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QAfterFilterCondition> consistencySubScoreLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'consistencySubScore',
        value: value,
      ));
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QAfterFilterCondition> consistencySubScoreBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'consistencySubScore',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QAfterFilterCondition> goalSubScoreEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'goalSubScore',
        value: value,
      ));
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QAfterFilterCondition> goalSubScoreGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'goalSubScore',
        value: value,
      ));
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QAfterFilterCondition> goalSubScoreLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'goalSubScore',
        value: value,
      ));
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QAfterFilterCondition> goalSubScoreBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'goalSubScore',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection, QAfterFilterCondition> idBetween(
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

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QAfterFilterCondition> recordedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'recordedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QAfterFilterCondition> recordedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'recordedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QAfterFilterCondition> recordedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'recordedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QAfterFilterCondition> recordedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'recordedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QAfterFilterCondition> savingsSubScoreEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'savingsSubScore',
        value: value,
      ));
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QAfterFilterCondition> savingsSubScoreGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'savingsSubScore',
        value: value,
      ));
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QAfterFilterCondition> savingsSubScoreLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'savingsSubScore',
        value: value,
      ));
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QAfterFilterCondition> savingsSubScoreBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'savingsSubScore',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QAfterFilterCondition> scoreEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'score',
        value: value,
      ));
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QAfterFilterCondition> scoreGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'score',
        value: value,
      ));
    });
  }

  QueryBuilder<FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection, QAfterFilterCondition> scoreLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'score',
        value: value,
      ));
    });
  }

  QueryBuilder<FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection, QAfterFilterCondition> scoreBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'score',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QAfterFilterCondition> snapshotIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'snapshotId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QAfterFilterCondition> snapshotIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'snapshotId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QAfterFilterCondition> snapshotIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'snapshotId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QAfterFilterCondition> snapshotIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'snapshotId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QAfterFilterCondition> snapshotIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'snapshotId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QAfterFilterCondition> snapshotIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'snapshotId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FinancialHealthSnapshotCollection,
          FinancialHealthSnapshotCollection, QAfterFilterCondition>
      snapshotIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'snapshotId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FinancialHealthSnapshotCollection,
          FinancialHealthSnapshotCollection, QAfterFilterCondition>
      snapshotIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'snapshotId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QAfterFilterCondition> snapshotIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'snapshotId',
        value: '',
      ));
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QAfterFilterCondition> snapshotIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'snapshotId',
        value: '',
      ));
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QAfterFilterCondition> spendingSubScoreEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'spendingSubScore',
        value: value,
      ));
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QAfterFilterCondition> spendingSubScoreGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'spendingSubScore',
        value: value,
      ));
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QAfterFilterCondition> spendingSubScoreLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'spendingSubScore',
        value: value,
      ));
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QAfterFilterCondition> spendingSubScoreBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'spendingSubScore',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QAfterFilterCondition> stabilitySubScoreEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stabilitySubScore',
        value: value,
      ));
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QAfterFilterCondition> stabilitySubScoreGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'stabilitySubScore',
        value: value,
      ));
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QAfterFilterCondition> stabilitySubScoreLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'stabilitySubScore',
        value: value,
      ));
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QAfterFilterCondition> stabilitySubScoreBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'stabilitySubScore',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension FinancialHealthSnapshotCollectionQueryObject on QueryBuilder<
    FinancialHealthSnapshotCollection,
    FinancialHealthSnapshotCollection,
    QFilterCondition> {}

extension FinancialHealthSnapshotCollectionQueryLinks on QueryBuilder<
    FinancialHealthSnapshotCollection,
    FinancialHealthSnapshotCollection,
    QFilterCondition> {}

extension FinancialHealthSnapshotCollectionQuerySortBy on QueryBuilder<
    FinancialHealthSnapshotCollection,
    FinancialHealthSnapshotCollection,
    QSortBy> {
  QueryBuilder<FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection, QAfterSortBy> sortByAiExplanation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aiExplanation', Sort.asc);
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QAfterSortBy> sortByAiExplanationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aiExplanation', Sort.desc);
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QAfterSortBy> sortByAiImprovementTip() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aiImprovementTip', Sort.asc);
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QAfterSortBy> sortByAiImprovementTipDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aiImprovementTip', Sort.desc);
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QAfterSortBy> sortByConsistencySubScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'consistencySubScore', Sort.asc);
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QAfterSortBy> sortByConsistencySubScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'consistencySubScore', Sort.desc);
    });
  }

  QueryBuilder<FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection, QAfterSortBy> sortByGoalSubScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goalSubScore', Sort.asc);
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QAfterSortBy> sortByGoalSubScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goalSubScore', Sort.desc);
    });
  }

  QueryBuilder<FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection, QAfterSortBy> sortByRecordedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recordedAt', Sort.asc);
    });
  }

  QueryBuilder<FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection, QAfterSortBy> sortByRecordedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recordedAt', Sort.desc);
    });
  }

  QueryBuilder<FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection, QAfterSortBy> sortBySavingsSubScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'savingsSubScore', Sort.asc);
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QAfterSortBy> sortBySavingsSubScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'savingsSubScore', Sort.desc);
    });
  }

  QueryBuilder<FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection, QAfterSortBy> sortByScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'score', Sort.asc);
    });
  }

  QueryBuilder<FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection, QAfterSortBy> sortByScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'score', Sort.desc);
    });
  }

  QueryBuilder<FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection, QAfterSortBy> sortBySnapshotId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'snapshotId', Sort.asc);
    });
  }

  QueryBuilder<FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection, QAfterSortBy> sortBySnapshotIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'snapshotId', Sort.desc);
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QAfterSortBy> sortBySpendingSubScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spendingSubScore', Sort.asc);
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QAfterSortBy> sortBySpendingSubScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spendingSubScore', Sort.desc);
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QAfterSortBy> sortByStabilitySubScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stabilitySubScore', Sort.asc);
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QAfterSortBy> sortByStabilitySubScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stabilitySubScore', Sort.desc);
    });
  }
}

extension FinancialHealthSnapshotCollectionQuerySortThenBy on QueryBuilder<
    FinancialHealthSnapshotCollection,
    FinancialHealthSnapshotCollection,
    QSortThenBy> {
  QueryBuilder<FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection, QAfterSortBy> thenByAiExplanation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aiExplanation', Sort.asc);
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QAfterSortBy> thenByAiExplanationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aiExplanation', Sort.desc);
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QAfterSortBy> thenByAiImprovementTip() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aiImprovementTip', Sort.asc);
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QAfterSortBy> thenByAiImprovementTipDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aiImprovementTip', Sort.desc);
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QAfterSortBy> thenByConsistencySubScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'consistencySubScore', Sort.asc);
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QAfterSortBy> thenByConsistencySubScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'consistencySubScore', Sort.desc);
    });
  }

  QueryBuilder<FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection, QAfterSortBy> thenByGoalSubScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goalSubScore', Sort.asc);
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QAfterSortBy> thenByGoalSubScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goalSubScore', Sort.desc);
    });
  }

  QueryBuilder<FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection, QAfterSortBy> thenByRecordedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recordedAt', Sort.asc);
    });
  }

  QueryBuilder<FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection, QAfterSortBy> thenByRecordedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recordedAt', Sort.desc);
    });
  }

  QueryBuilder<FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection, QAfterSortBy> thenBySavingsSubScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'savingsSubScore', Sort.asc);
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QAfterSortBy> thenBySavingsSubScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'savingsSubScore', Sort.desc);
    });
  }

  QueryBuilder<FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection, QAfterSortBy> thenByScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'score', Sort.asc);
    });
  }

  QueryBuilder<FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection, QAfterSortBy> thenByScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'score', Sort.desc);
    });
  }

  QueryBuilder<FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection, QAfterSortBy> thenBySnapshotId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'snapshotId', Sort.asc);
    });
  }

  QueryBuilder<FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection, QAfterSortBy> thenBySnapshotIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'snapshotId', Sort.desc);
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QAfterSortBy> thenBySpendingSubScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spendingSubScore', Sort.asc);
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QAfterSortBy> thenBySpendingSubScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spendingSubScore', Sort.desc);
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QAfterSortBy> thenByStabilitySubScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stabilitySubScore', Sort.asc);
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QAfterSortBy> thenByStabilitySubScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stabilitySubScore', Sort.desc);
    });
  }
}

extension FinancialHealthSnapshotCollectionQueryWhereDistinct on QueryBuilder<
    FinancialHealthSnapshotCollection,
    FinancialHealthSnapshotCollection,
    QDistinct> {
  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QDistinct> distinctByAiExplanation({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'aiExplanation',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QDistinct> distinctByAiImprovementTip({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'aiImprovementTip',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QDistinct> distinctByConsistencySubScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'consistencySubScore');
    });
  }

  QueryBuilder<FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection, QDistinct> distinctByGoalSubScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'goalSubScore');
    });
  }

  QueryBuilder<FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection, QDistinct> distinctByRecordedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'recordedAt');
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QDistinct> distinctBySavingsSubScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'savingsSubScore');
    });
  }

  QueryBuilder<FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection, QDistinct> distinctByScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'score');
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QDistinct> distinctBySnapshotId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'snapshotId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QDistinct> distinctBySpendingSubScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'spendingSubScore');
    });
  }

  QueryBuilder<
      FinancialHealthSnapshotCollection,
      FinancialHealthSnapshotCollection,
      QDistinct> distinctByStabilitySubScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'stabilitySubScore');
    });
  }
}

extension FinancialHealthSnapshotCollectionQueryProperty on QueryBuilder<
    FinancialHealthSnapshotCollection,
    FinancialHealthSnapshotCollection,
    QQueryProperty> {
  QueryBuilder<FinancialHealthSnapshotCollection, int, QQueryOperations>
      idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<FinancialHealthSnapshotCollection, String, QQueryOperations>
      aiExplanationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'aiExplanation');
    });
  }

  QueryBuilder<FinancialHealthSnapshotCollection, String, QQueryOperations>
      aiImprovementTipProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'aiImprovementTip');
    });
  }

  QueryBuilder<FinancialHealthSnapshotCollection, int, QQueryOperations>
      consistencySubScoreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'consistencySubScore');
    });
  }

  QueryBuilder<FinancialHealthSnapshotCollection, int, QQueryOperations>
      goalSubScoreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'goalSubScore');
    });
  }

  QueryBuilder<FinancialHealthSnapshotCollection, DateTime, QQueryOperations>
      recordedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'recordedAt');
    });
  }

  QueryBuilder<FinancialHealthSnapshotCollection, int, QQueryOperations>
      savingsSubScoreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'savingsSubScore');
    });
  }

  QueryBuilder<FinancialHealthSnapshotCollection, int, QQueryOperations>
      scoreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'score');
    });
  }

  QueryBuilder<FinancialHealthSnapshotCollection, String, QQueryOperations>
      snapshotIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'snapshotId');
    });
  }

  QueryBuilder<FinancialHealthSnapshotCollection, int, QQueryOperations>
      spendingSubScoreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'spendingSubScore');
    });
  }

  QueryBuilder<FinancialHealthSnapshotCollection, int, QQueryOperations>
      stabilitySubScoreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'stabilitySubScore');
    });
  }
}
