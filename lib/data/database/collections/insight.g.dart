// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insight.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetInsightCollectionCollection on Isar {
  IsarCollection<InsightCollection> get insightCollections => this.collection();
}

const InsightCollectionSchema = CollectionSchema(
  name: r'InsightCollection',
  id: 4790021253723873132,
  properties: {
    r'category': PropertySchema(
      id: 0,
      name: r'category',
      type: IsarType.string,
    ),
    r'confidenceScore': PropertySchema(
      id: 1,
      name: r'confidenceScore',
      type: IsarType.double,
    ),
    r'generatedAt': PropertySchema(
      id: 2,
      name: r'generatedAt',
      type: IsarType.dateTime,
    ),
    r'insightId': PropertySchema(
      id: 3,
      name: r'insightId',
      type: IsarType.string,
    ),
    r'isRead': PropertySchema(
      id: 4,
      name: r'isRead',
      type: IsarType.bool,
    ),
    r'reasonText': PropertySchema(
      id: 5,
      name: r'reasonText',
      type: IsarType.string,
    ),
    r'signalSource': PropertySchema(
      id: 6,
      name: r'signalSource',
      type: IsarType.string,
    ),
    r'suggestedAction': PropertySchema(
      id: 7,
      name: r'suggestedAction',
      type: IsarType.string,
    ),
    r'text': PropertySchema(
      id: 8,
      name: r'text',
      type: IsarType.string,
    )
  },
  estimateSize: _insightCollectionEstimateSize,
  serialize: _insightCollectionSerialize,
  deserialize: _insightCollectionDeserialize,
  deserializeProp: _insightCollectionDeserializeProp,
  idName: r'id',
  indexes: {
    r'insightId': IndexSchema(
      id: 5818887354909674719,
      name: r'insightId',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'insightId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _insightCollectionGetId,
  getLinks: _insightCollectionGetLinks,
  attach: _insightCollectionAttach,
  version: '3.1.0+1',
);

int _insightCollectionEstimateSize(
  InsightCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.category.length * 3;
  bytesCount += 3 + object.insightId.length * 3;
  bytesCount += 3 + object.reasonText.length * 3;
  bytesCount += 3 + object.signalSource.length * 3;
  bytesCount += 3 + object.suggestedAction.length * 3;
  bytesCount += 3 + object.text.length * 3;
  return bytesCount;
}

void _insightCollectionSerialize(
  InsightCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.category);
  writer.writeDouble(offsets[1], object.confidenceScore);
  writer.writeDateTime(offsets[2], object.generatedAt);
  writer.writeString(offsets[3], object.insightId);
  writer.writeBool(offsets[4], object.isRead);
  writer.writeString(offsets[5], object.reasonText);
  writer.writeString(offsets[6], object.signalSource);
  writer.writeString(offsets[7], object.suggestedAction);
  writer.writeString(offsets[8], object.text);
}

InsightCollection _insightCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = InsightCollection();
  object.category = reader.readString(offsets[0]);
  object.confidenceScore = reader.readDouble(offsets[1]);
  object.generatedAt = reader.readDateTime(offsets[2]);
  object.id = id;
  object.insightId = reader.readString(offsets[3]);
  object.isRead = reader.readBool(offsets[4]);
  object.reasonText = reader.readString(offsets[5]);
  object.signalSource = reader.readString(offsets[6]);
  object.suggestedAction = reader.readString(offsets[7]);
  object.text = reader.readString(offsets[8]);
  return object;
}

P _insightCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readDouble(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _insightCollectionGetId(InsightCollection object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _insightCollectionGetLinks(
    InsightCollection object) {
  return [];
}

void _insightCollectionAttach(
    IsarCollection<dynamic> col, Id id, InsightCollection object) {
  object.id = id;
}

extension InsightCollectionByIndex on IsarCollection<InsightCollection> {
  Future<InsightCollection?> getByInsightId(String insightId) {
    return getByIndex(r'insightId', [insightId]);
  }

  InsightCollection? getByInsightIdSync(String insightId) {
    return getByIndexSync(r'insightId', [insightId]);
  }

  Future<bool> deleteByInsightId(String insightId) {
    return deleteByIndex(r'insightId', [insightId]);
  }

  bool deleteByInsightIdSync(String insightId) {
    return deleteByIndexSync(r'insightId', [insightId]);
  }

  Future<List<InsightCollection?>> getAllByInsightId(
      List<String> insightIdValues) {
    final values = insightIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'insightId', values);
  }

  List<InsightCollection?> getAllByInsightIdSync(List<String> insightIdValues) {
    final values = insightIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'insightId', values);
  }

  Future<int> deleteAllByInsightId(List<String> insightIdValues) {
    final values = insightIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'insightId', values);
  }

  int deleteAllByInsightIdSync(List<String> insightIdValues) {
    final values = insightIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'insightId', values);
  }

  Future<Id> putByInsightId(InsightCollection object) {
    return putByIndex(r'insightId', object);
  }

  Id putByInsightIdSync(InsightCollection object, {bool saveLinks = true}) {
    return putByIndexSync(r'insightId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByInsightId(List<InsightCollection> objects) {
    return putAllByIndex(r'insightId', objects);
  }

  List<Id> putAllByInsightIdSync(List<InsightCollection> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'insightId', objects, saveLinks: saveLinks);
  }
}

extension InsightCollectionQueryWhereSort
    on QueryBuilder<InsightCollection, InsightCollection, QWhere> {
  QueryBuilder<InsightCollection, InsightCollection, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension InsightCollectionQueryWhere
    on QueryBuilder<InsightCollection, InsightCollection, QWhereClause> {
  QueryBuilder<InsightCollection, InsightCollection, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterWhereClause>
      idNotEqualTo(Id id) {
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

  QueryBuilder<InsightCollection, InsightCollection, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterWhereClause>
      idBetween(
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

  QueryBuilder<InsightCollection, InsightCollection, QAfterWhereClause>
      insightIdEqualTo(String insightId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'insightId',
        value: [insightId],
      ));
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterWhereClause>
      insightIdNotEqualTo(String insightId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'insightId',
              lower: [],
              upper: [insightId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'insightId',
              lower: [insightId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'insightId',
              lower: [insightId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'insightId',
              lower: [],
              upper: [insightId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension InsightCollectionQueryFilter
    on QueryBuilder<InsightCollection, InsightCollection, QFilterCondition> {
  QueryBuilder<InsightCollection, InsightCollection, QAfterFilterCondition>
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

  QueryBuilder<InsightCollection, InsightCollection, QAfterFilterCondition>
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

  QueryBuilder<InsightCollection, InsightCollection, QAfterFilterCondition>
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

  QueryBuilder<InsightCollection, InsightCollection, QAfterFilterCondition>
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

  QueryBuilder<InsightCollection, InsightCollection, QAfterFilterCondition>
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

  QueryBuilder<InsightCollection, InsightCollection, QAfterFilterCondition>
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

  QueryBuilder<InsightCollection, InsightCollection, QAfterFilterCondition>
      categoryContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterFilterCondition>
      categoryMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'category',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterFilterCondition>
      categoryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterFilterCondition>
      categoryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterFilterCondition>
      confidenceScoreEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'confidenceScore',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterFilterCondition>
      confidenceScoreGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'confidenceScore',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterFilterCondition>
      confidenceScoreLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'confidenceScore',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterFilterCondition>
      confidenceScoreBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'confidenceScore',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterFilterCondition>
      generatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'generatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterFilterCondition>
      generatedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'generatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterFilterCondition>
      generatedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'generatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterFilterCondition>
      generatedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'generatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterFilterCondition>
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

  QueryBuilder<InsightCollection, InsightCollection, QAfterFilterCondition>
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

  QueryBuilder<InsightCollection, InsightCollection, QAfterFilterCondition>
      idBetween(
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

  QueryBuilder<InsightCollection, InsightCollection, QAfterFilterCondition>
      insightIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'insightId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterFilterCondition>
      insightIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'insightId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterFilterCondition>
      insightIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'insightId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterFilterCondition>
      insightIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'insightId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterFilterCondition>
      insightIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'insightId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterFilterCondition>
      insightIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'insightId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterFilterCondition>
      insightIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'insightId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterFilterCondition>
      insightIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'insightId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterFilterCondition>
      insightIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'insightId',
        value: '',
      ));
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterFilterCondition>
      insightIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'insightId',
        value: '',
      ));
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterFilterCondition>
      isReadEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isRead',
        value: value,
      ));
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterFilterCondition>
      reasonTextEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'reasonText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterFilterCondition>
      reasonTextGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'reasonText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterFilterCondition>
      reasonTextLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'reasonText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterFilterCondition>
      reasonTextBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'reasonText',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterFilterCondition>
      reasonTextStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'reasonText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterFilterCondition>
      reasonTextEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'reasonText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterFilterCondition>
      reasonTextContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'reasonText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterFilterCondition>
      reasonTextMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'reasonText',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterFilterCondition>
      reasonTextIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'reasonText',
        value: '',
      ));
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterFilterCondition>
      reasonTextIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'reasonText',
        value: '',
      ));
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterFilterCondition>
      signalSourceEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'signalSource',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterFilterCondition>
      signalSourceGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'signalSource',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterFilterCondition>
      signalSourceLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'signalSource',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterFilterCondition>
      signalSourceBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'signalSource',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterFilterCondition>
      signalSourceStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'signalSource',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterFilterCondition>
      signalSourceEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'signalSource',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterFilterCondition>
      signalSourceContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'signalSource',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterFilterCondition>
      signalSourceMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'signalSource',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterFilterCondition>
      signalSourceIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'signalSource',
        value: '',
      ));
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterFilterCondition>
      signalSourceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'signalSource',
        value: '',
      ));
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterFilterCondition>
      suggestedActionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'suggestedAction',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterFilterCondition>
      suggestedActionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'suggestedAction',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterFilterCondition>
      suggestedActionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'suggestedAction',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterFilterCondition>
      suggestedActionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'suggestedAction',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterFilterCondition>
      suggestedActionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'suggestedAction',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterFilterCondition>
      suggestedActionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'suggestedAction',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterFilterCondition>
      suggestedActionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'suggestedAction',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterFilterCondition>
      suggestedActionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'suggestedAction',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterFilterCondition>
      suggestedActionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'suggestedAction',
        value: '',
      ));
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterFilterCondition>
      suggestedActionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'suggestedAction',
        value: '',
      ));
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterFilterCondition>
      textEqualTo(
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

  QueryBuilder<InsightCollection, InsightCollection, QAfterFilterCondition>
      textGreaterThan(
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

  QueryBuilder<InsightCollection, InsightCollection, QAfterFilterCondition>
      textLessThan(
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

  QueryBuilder<InsightCollection, InsightCollection, QAfterFilterCondition>
      textBetween(
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

  QueryBuilder<InsightCollection, InsightCollection, QAfterFilterCondition>
      textStartsWith(
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

  QueryBuilder<InsightCollection, InsightCollection, QAfterFilterCondition>
      textEndsWith(
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

  QueryBuilder<InsightCollection, InsightCollection, QAfterFilterCondition>
      textContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterFilterCondition>
      textMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'text',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterFilterCondition>
      textIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'text',
        value: '',
      ));
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterFilterCondition>
      textIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'text',
        value: '',
      ));
    });
  }
}

extension InsightCollectionQueryObject
    on QueryBuilder<InsightCollection, InsightCollection, QFilterCondition> {}

extension InsightCollectionQueryLinks
    on QueryBuilder<InsightCollection, InsightCollection, QFilterCondition> {}

extension InsightCollectionQuerySortBy
    on QueryBuilder<InsightCollection, InsightCollection, QSortBy> {
  QueryBuilder<InsightCollection, InsightCollection, QAfterSortBy>
      sortByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterSortBy>
      sortByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterSortBy>
      sortByConfidenceScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'confidenceScore', Sort.asc);
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterSortBy>
      sortByConfidenceScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'confidenceScore', Sort.desc);
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterSortBy>
      sortByGeneratedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'generatedAt', Sort.asc);
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterSortBy>
      sortByGeneratedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'generatedAt', Sort.desc);
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterSortBy>
      sortByInsightId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'insightId', Sort.asc);
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterSortBy>
      sortByInsightIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'insightId', Sort.desc);
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterSortBy>
      sortByIsRead() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRead', Sort.asc);
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterSortBy>
      sortByIsReadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRead', Sort.desc);
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterSortBy>
      sortByReasonText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reasonText', Sort.asc);
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterSortBy>
      sortByReasonTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reasonText', Sort.desc);
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterSortBy>
      sortBySignalSource() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'signalSource', Sort.asc);
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterSortBy>
      sortBySignalSourceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'signalSource', Sort.desc);
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterSortBy>
      sortBySuggestedAction() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'suggestedAction', Sort.asc);
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterSortBy>
      sortBySuggestedActionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'suggestedAction', Sort.desc);
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterSortBy>
      sortByText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'text', Sort.asc);
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterSortBy>
      sortByTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'text', Sort.desc);
    });
  }
}

extension InsightCollectionQuerySortThenBy
    on QueryBuilder<InsightCollection, InsightCollection, QSortThenBy> {
  QueryBuilder<InsightCollection, InsightCollection, QAfterSortBy>
      thenByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterSortBy>
      thenByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterSortBy>
      thenByConfidenceScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'confidenceScore', Sort.asc);
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterSortBy>
      thenByConfidenceScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'confidenceScore', Sort.desc);
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterSortBy>
      thenByGeneratedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'generatedAt', Sort.asc);
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterSortBy>
      thenByGeneratedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'generatedAt', Sort.desc);
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterSortBy>
      thenByInsightId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'insightId', Sort.asc);
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterSortBy>
      thenByInsightIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'insightId', Sort.desc);
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterSortBy>
      thenByIsRead() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRead', Sort.asc);
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterSortBy>
      thenByIsReadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRead', Sort.desc);
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterSortBy>
      thenByReasonText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reasonText', Sort.asc);
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterSortBy>
      thenByReasonTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reasonText', Sort.desc);
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterSortBy>
      thenBySignalSource() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'signalSource', Sort.asc);
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterSortBy>
      thenBySignalSourceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'signalSource', Sort.desc);
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterSortBy>
      thenBySuggestedAction() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'suggestedAction', Sort.asc);
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterSortBy>
      thenBySuggestedActionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'suggestedAction', Sort.desc);
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterSortBy>
      thenByText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'text', Sort.asc);
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QAfterSortBy>
      thenByTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'text', Sort.desc);
    });
  }
}

extension InsightCollectionQueryWhereDistinct
    on QueryBuilder<InsightCollection, InsightCollection, QDistinct> {
  QueryBuilder<InsightCollection, InsightCollection, QDistinct>
      distinctByCategory({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'category', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QDistinct>
      distinctByConfidenceScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'confidenceScore');
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QDistinct>
      distinctByGeneratedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'generatedAt');
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QDistinct>
      distinctByInsightId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'insightId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QDistinct>
      distinctByIsRead() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isRead');
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QDistinct>
      distinctByReasonText({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'reasonText', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QDistinct>
      distinctBySignalSource({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'signalSource', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QDistinct>
      distinctBySuggestedAction({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'suggestedAction',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InsightCollection, InsightCollection, QDistinct> distinctByText(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'text', caseSensitive: caseSensitive);
    });
  }
}

extension InsightCollectionQueryProperty
    on QueryBuilder<InsightCollection, InsightCollection, QQueryProperty> {
  QueryBuilder<InsightCollection, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<InsightCollection, String, QQueryOperations> categoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'category');
    });
  }

  QueryBuilder<InsightCollection, double, QQueryOperations>
      confidenceScoreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'confidenceScore');
    });
  }

  QueryBuilder<InsightCollection, DateTime, QQueryOperations>
      generatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'generatedAt');
    });
  }

  QueryBuilder<InsightCollection, String, QQueryOperations>
      insightIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'insightId');
    });
  }

  QueryBuilder<InsightCollection, bool, QQueryOperations> isReadProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isRead');
    });
  }

  QueryBuilder<InsightCollection, String, QQueryOperations>
      reasonTextProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'reasonText');
    });
  }

  QueryBuilder<InsightCollection, String, QQueryOperations>
      signalSourceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'signalSource');
    });
  }

  QueryBuilder<InsightCollection, String, QQueryOperations>
      suggestedActionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'suggestedAction');
    });
  }

  QueryBuilder<InsightCollection, String, QQueryOperations> textProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'text');
    });
  }
}
