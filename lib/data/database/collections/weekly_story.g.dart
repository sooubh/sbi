// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weekly_story.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetWeeklyStoryCollectionCollection on Isar {
  IsarCollection<WeeklyStoryCollection> get weeklyStoryCollections =>
      this.collection();
}

const WeeklyStoryCollectionSchema = CollectionSchema(
  name: r'WeeklyStoryCollection',
  id: -7374830494825123499,
  properties: {
    r'achievementHighlight': PropertySchema(
      id: 0,
      name: r'achievementHighlight',
      type: IsarType.string,
    ),
    r'bodyText': PropertySchema(
      id: 1,
      name: r'bodyText',
      type: IsarType.string,
    ),
    r'generatedAt': PropertySchema(
      id: 2,
      name: r'generatedAt',
      type: IsarType.dateTime,
    ),
    r'headline': PropertySchema(
      id: 3,
      name: r'headline',
      type: IsarType.string,
    ),
    r'healthScoreDelta': PropertySchema(
      id: 4,
      name: r'healthScoreDelta',
      type: IsarType.long,
    ),
    r'storyId': PropertySchema(
      id: 5,
      name: r'storyId',
      type: IsarType.string,
    ),
    r'streakInfo': PropertySchema(
      id: 6,
      name: r'streakInfo',
      type: IsarType.string,
    ),
    r'summary': PropertySchema(
      id: 7,
      name: r'summary',
      type: IsarType.string,
    ),
    r'topGoalProgress': PropertySchema(
      id: 8,
      name: r'topGoalProgress',
      type: IsarType.string,
    ),
    r'weekStartDate': PropertySchema(
      id: 9,
      name: r'weekStartDate',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _weeklyStoryCollectionEstimateSize,
  serialize: _weeklyStoryCollectionSerialize,
  deserialize: _weeklyStoryCollectionDeserialize,
  deserializeProp: _weeklyStoryCollectionDeserializeProp,
  idName: r'id',
  indexes: {
    r'storyId': IndexSchema(
      id: -7904996416186759579,
      name: r'storyId',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'storyId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _weeklyStoryCollectionGetId,
  getLinks: _weeklyStoryCollectionGetLinks,
  attach: _weeklyStoryCollectionAttach,
  version: '3.1.0+1',
);

int _weeklyStoryCollectionEstimateSize(
  WeeklyStoryCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.achievementHighlight;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.bodyText.length * 3;
  bytesCount += 3 + object.headline.length * 3;
  bytesCount += 3 + object.storyId.length * 3;
  bytesCount += 3 + object.streakInfo.length * 3;
  bytesCount += 3 + object.summary.length * 3;
  bytesCount += 3 + object.topGoalProgress.length * 3;
  return bytesCount;
}

void _weeklyStoryCollectionSerialize(
  WeeklyStoryCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.achievementHighlight);
  writer.writeString(offsets[1], object.bodyText);
  writer.writeDateTime(offsets[2], object.generatedAt);
  writer.writeString(offsets[3], object.headline);
  writer.writeLong(offsets[4], object.healthScoreDelta);
  writer.writeString(offsets[5], object.storyId);
  writer.writeString(offsets[6], object.streakInfo);
  writer.writeString(offsets[7], object.summary);
  writer.writeString(offsets[8], object.topGoalProgress);
  writer.writeDateTime(offsets[9], object.weekStartDate);
}

WeeklyStoryCollection _weeklyStoryCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = WeeklyStoryCollection();
  object.achievementHighlight = reader.readStringOrNull(offsets[0]);
  object.bodyText = reader.readString(offsets[1]);
  object.generatedAt = reader.readDateTime(offsets[2]);
  object.headline = reader.readString(offsets[3]);
  object.healthScoreDelta = reader.readLong(offsets[4]);
  object.id = id;
  object.storyId = reader.readString(offsets[5]);
  object.streakInfo = reader.readString(offsets[6]);
  object.summary = reader.readString(offsets[7]);
  object.topGoalProgress = reader.readString(offsets[8]);
  object.weekStartDate = reader.readDateTime(offsets[9]);
  return object;
}

P _weeklyStoryCollectionDeserializeProp<P>(
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
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _weeklyStoryCollectionGetId(WeeklyStoryCollection object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _weeklyStoryCollectionGetLinks(
    WeeklyStoryCollection object) {
  return [];
}

void _weeklyStoryCollectionAttach(
    IsarCollection<dynamic> col, Id id, WeeklyStoryCollection object) {
  object.id = id;
}

extension WeeklyStoryCollectionByIndex
    on IsarCollection<WeeklyStoryCollection> {
  Future<WeeklyStoryCollection?> getByStoryId(String storyId) {
    return getByIndex(r'storyId', [storyId]);
  }

  WeeklyStoryCollection? getByStoryIdSync(String storyId) {
    return getByIndexSync(r'storyId', [storyId]);
  }

  Future<bool> deleteByStoryId(String storyId) {
    return deleteByIndex(r'storyId', [storyId]);
  }

  bool deleteByStoryIdSync(String storyId) {
    return deleteByIndexSync(r'storyId', [storyId]);
  }

  Future<List<WeeklyStoryCollection?>> getAllByStoryId(
      List<String> storyIdValues) {
    final values = storyIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'storyId', values);
  }

  List<WeeklyStoryCollection?> getAllByStoryIdSync(List<String> storyIdValues) {
    final values = storyIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'storyId', values);
  }

  Future<int> deleteAllByStoryId(List<String> storyIdValues) {
    final values = storyIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'storyId', values);
  }

  int deleteAllByStoryIdSync(List<String> storyIdValues) {
    final values = storyIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'storyId', values);
  }

  Future<Id> putByStoryId(WeeklyStoryCollection object) {
    return putByIndex(r'storyId', object);
  }

  Id putByStoryIdSync(WeeklyStoryCollection object, {bool saveLinks = true}) {
    return putByIndexSync(r'storyId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByStoryId(List<WeeklyStoryCollection> objects) {
    return putAllByIndex(r'storyId', objects);
  }

  List<Id> putAllByStoryIdSync(List<WeeklyStoryCollection> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'storyId', objects, saveLinks: saveLinks);
  }
}

extension WeeklyStoryCollectionQueryWhereSort
    on QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection, QWhere> {
  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension WeeklyStoryCollectionQueryWhere on QueryBuilder<WeeklyStoryCollection,
    WeeklyStoryCollection, QWhereClause> {
  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection, QAfterWhereClause>
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

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection, QAfterWhereClause>
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

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection, QAfterWhereClause>
      storyIdEqualTo(String storyId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'storyId',
        value: [storyId],
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection, QAfterWhereClause>
      storyIdNotEqualTo(String storyId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'storyId',
              lower: [],
              upper: [storyId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'storyId',
              lower: [storyId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'storyId',
              lower: [storyId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'storyId',
              lower: [],
              upper: [storyId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension WeeklyStoryCollectionQueryFilter on QueryBuilder<
    WeeklyStoryCollection, WeeklyStoryCollection, QFilterCondition> {
  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
      QAfterFilterCondition> achievementHighlightIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'achievementHighlight',
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
      QAfterFilterCondition> achievementHighlightIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'achievementHighlight',
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
      QAfterFilterCondition> achievementHighlightEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'achievementHighlight',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
      QAfterFilterCondition> achievementHighlightGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'achievementHighlight',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
      QAfterFilterCondition> achievementHighlightLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'achievementHighlight',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
      QAfterFilterCondition> achievementHighlightBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'achievementHighlight',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
      QAfterFilterCondition> achievementHighlightStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'achievementHighlight',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
      QAfterFilterCondition> achievementHighlightEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'achievementHighlight',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
          QAfterFilterCondition>
      achievementHighlightContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'achievementHighlight',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
          QAfterFilterCondition>
      achievementHighlightMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'achievementHighlight',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
      QAfterFilterCondition> achievementHighlightIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'achievementHighlight',
        value: '',
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
      QAfterFilterCondition> achievementHighlightIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'achievementHighlight',
        value: '',
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
      QAfterFilterCondition> bodyTextEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bodyText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
      QAfterFilterCondition> bodyTextGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bodyText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
      QAfterFilterCondition> bodyTextLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bodyText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
      QAfterFilterCondition> bodyTextBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bodyText',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
      QAfterFilterCondition> bodyTextStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'bodyText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
      QAfterFilterCondition> bodyTextEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'bodyText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
          QAfterFilterCondition>
      bodyTextContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'bodyText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
          QAfterFilterCondition>
      bodyTextMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'bodyText',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
      QAfterFilterCondition> bodyTextIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bodyText',
        value: '',
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
      QAfterFilterCondition> bodyTextIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'bodyText',
        value: '',
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
      QAfterFilterCondition> generatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'generatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
      QAfterFilterCondition> generatedAtGreaterThan(
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

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
      QAfterFilterCondition> generatedAtLessThan(
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

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
      QAfterFilterCondition> generatedAtBetween(
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

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
      QAfterFilterCondition> headlineEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'headline',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
      QAfterFilterCondition> headlineGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'headline',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
      QAfterFilterCondition> headlineLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'headline',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
      QAfterFilterCondition> headlineBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'headline',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
      QAfterFilterCondition> headlineStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'headline',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
      QAfterFilterCondition> headlineEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'headline',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
          QAfterFilterCondition>
      headlineContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'headline',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
          QAfterFilterCondition>
      headlineMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'headline',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
      QAfterFilterCondition> headlineIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'headline',
        value: '',
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
      QAfterFilterCondition> headlineIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'headline',
        value: '',
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
      QAfterFilterCondition> healthScoreDeltaEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'healthScoreDelta',
        value: value,
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
      QAfterFilterCondition> healthScoreDeltaGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'healthScoreDelta',
        value: value,
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
      QAfterFilterCondition> healthScoreDeltaLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'healthScoreDelta',
        value: value,
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
      QAfterFilterCondition> healthScoreDeltaBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'healthScoreDelta',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
      QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
      QAfterFilterCondition> idLessThan(
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

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
      QAfterFilterCondition> idBetween(
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

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
      QAfterFilterCondition> storyIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'storyId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
      QAfterFilterCondition> storyIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'storyId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
      QAfterFilterCondition> storyIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'storyId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
      QAfterFilterCondition> storyIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'storyId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
      QAfterFilterCondition> storyIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'storyId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
      QAfterFilterCondition> storyIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'storyId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
          QAfterFilterCondition>
      storyIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'storyId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
          QAfterFilterCondition>
      storyIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'storyId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
      QAfterFilterCondition> storyIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'storyId',
        value: '',
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
      QAfterFilterCondition> storyIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'storyId',
        value: '',
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
      QAfterFilterCondition> streakInfoEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'streakInfo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
      QAfterFilterCondition> streakInfoGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'streakInfo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
      QAfterFilterCondition> streakInfoLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'streakInfo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
      QAfterFilterCondition> streakInfoBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'streakInfo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
      QAfterFilterCondition> streakInfoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'streakInfo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
      QAfterFilterCondition> streakInfoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'streakInfo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
          QAfterFilterCondition>
      streakInfoContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'streakInfo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
          QAfterFilterCondition>
      streakInfoMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'streakInfo',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
      QAfterFilterCondition> streakInfoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'streakInfo',
        value: '',
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
      QAfterFilterCondition> streakInfoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'streakInfo',
        value: '',
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
      QAfterFilterCondition> summaryEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'summary',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
      QAfterFilterCondition> summaryGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'summary',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
      QAfterFilterCondition> summaryLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'summary',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
      QAfterFilterCondition> summaryBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'summary',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
      QAfterFilterCondition> summaryStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'summary',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
      QAfterFilterCondition> summaryEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'summary',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
          QAfterFilterCondition>
      summaryContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'summary',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
          QAfterFilterCondition>
      summaryMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'summary',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
      QAfterFilterCondition> summaryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'summary',
        value: '',
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
      QAfterFilterCondition> summaryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'summary',
        value: '',
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
      QAfterFilterCondition> topGoalProgressEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'topGoalProgress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
      QAfterFilterCondition> topGoalProgressGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'topGoalProgress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
      QAfterFilterCondition> topGoalProgressLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'topGoalProgress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
      QAfterFilterCondition> topGoalProgressBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'topGoalProgress',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
      QAfterFilterCondition> topGoalProgressStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'topGoalProgress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
      QAfterFilterCondition> topGoalProgressEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'topGoalProgress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
          QAfterFilterCondition>
      topGoalProgressContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'topGoalProgress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
          QAfterFilterCondition>
      topGoalProgressMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'topGoalProgress',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
      QAfterFilterCondition> topGoalProgressIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'topGoalProgress',
        value: '',
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
      QAfterFilterCondition> topGoalProgressIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'topGoalProgress',
        value: '',
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
      QAfterFilterCondition> weekStartDateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'weekStartDate',
        value: value,
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
      QAfterFilterCondition> weekStartDateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'weekStartDate',
        value: value,
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
      QAfterFilterCondition> weekStartDateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'weekStartDate',
        value: value,
      ));
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection,
      QAfterFilterCondition> weekStartDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'weekStartDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension WeeklyStoryCollectionQueryObject on QueryBuilder<
    WeeklyStoryCollection, WeeklyStoryCollection, QFilterCondition> {}

extension WeeklyStoryCollectionQueryLinks on QueryBuilder<WeeklyStoryCollection,
    WeeklyStoryCollection, QFilterCondition> {}

extension WeeklyStoryCollectionQuerySortBy
    on QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection, QSortBy> {
  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection, QAfterSortBy>
      sortByAchievementHighlight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'achievementHighlight', Sort.asc);
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection, QAfterSortBy>
      sortByAchievementHighlightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'achievementHighlight', Sort.desc);
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection, QAfterSortBy>
      sortByBodyText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bodyText', Sort.asc);
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection, QAfterSortBy>
      sortByBodyTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bodyText', Sort.desc);
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection, QAfterSortBy>
      sortByGeneratedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'generatedAt', Sort.asc);
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection, QAfterSortBy>
      sortByGeneratedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'generatedAt', Sort.desc);
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection, QAfterSortBy>
      sortByHeadline() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'headline', Sort.asc);
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection, QAfterSortBy>
      sortByHeadlineDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'headline', Sort.desc);
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection, QAfterSortBy>
      sortByHealthScoreDelta() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'healthScoreDelta', Sort.asc);
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection, QAfterSortBy>
      sortByHealthScoreDeltaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'healthScoreDelta', Sort.desc);
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection, QAfterSortBy>
      sortByStoryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'storyId', Sort.asc);
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection, QAfterSortBy>
      sortByStoryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'storyId', Sort.desc);
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection, QAfterSortBy>
      sortByStreakInfo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'streakInfo', Sort.asc);
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection, QAfterSortBy>
      sortByStreakInfoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'streakInfo', Sort.desc);
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection, QAfterSortBy>
      sortBySummary() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'summary', Sort.asc);
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection, QAfterSortBy>
      sortBySummaryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'summary', Sort.desc);
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection, QAfterSortBy>
      sortByTopGoalProgress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'topGoalProgress', Sort.asc);
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection, QAfterSortBy>
      sortByTopGoalProgressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'topGoalProgress', Sort.desc);
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection, QAfterSortBy>
      sortByWeekStartDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weekStartDate', Sort.asc);
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection, QAfterSortBy>
      sortByWeekStartDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weekStartDate', Sort.desc);
    });
  }
}

extension WeeklyStoryCollectionQuerySortThenBy
    on QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection, QSortThenBy> {
  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection, QAfterSortBy>
      thenByAchievementHighlight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'achievementHighlight', Sort.asc);
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection, QAfterSortBy>
      thenByAchievementHighlightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'achievementHighlight', Sort.desc);
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection, QAfterSortBy>
      thenByBodyText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bodyText', Sort.asc);
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection, QAfterSortBy>
      thenByBodyTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bodyText', Sort.desc);
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection, QAfterSortBy>
      thenByGeneratedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'generatedAt', Sort.asc);
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection, QAfterSortBy>
      thenByGeneratedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'generatedAt', Sort.desc);
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection, QAfterSortBy>
      thenByHeadline() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'headline', Sort.asc);
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection, QAfterSortBy>
      thenByHeadlineDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'headline', Sort.desc);
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection, QAfterSortBy>
      thenByHealthScoreDelta() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'healthScoreDelta', Sort.asc);
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection, QAfterSortBy>
      thenByHealthScoreDeltaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'healthScoreDelta', Sort.desc);
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection, QAfterSortBy>
      thenByStoryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'storyId', Sort.asc);
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection, QAfterSortBy>
      thenByStoryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'storyId', Sort.desc);
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection, QAfterSortBy>
      thenByStreakInfo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'streakInfo', Sort.asc);
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection, QAfterSortBy>
      thenByStreakInfoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'streakInfo', Sort.desc);
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection, QAfterSortBy>
      thenBySummary() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'summary', Sort.asc);
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection, QAfterSortBy>
      thenBySummaryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'summary', Sort.desc);
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection, QAfterSortBy>
      thenByTopGoalProgress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'topGoalProgress', Sort.asc);
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection, QAfterSortBy>
      thenByTopGoalProgressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'topGoalProgress', Sort.desc);
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection, QAfterSortBy>
      thenByWeekStartDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weekStartDate', Sort.asc);
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection, QAfterSortBy>
      thenByWeekStartDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weekStartDate', Sort.desc);
    });
  }
}

extension WeeklyStoryCollectionQueryWhereDistinct
    on QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection, QDistinct> {
  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection, QDistinct>
      distinctByAchievementHighlight({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'achievementHighlight',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection, QDistinct>
      distinctByBodyText({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bodyText', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection, QDistinct>
      distinctByGeneratedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'generatedAt');
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection, QDistinct>
      distinctByHeadline({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'headline', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection, QDistinct>
      distinctByHealthScoreDelta() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'healthScoreDelta');
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection, QDistinct>
      distinctByStoryId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'storyId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection, QDistinct>
      distinctByStreakInfo({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'streakInfo', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection, QDistinct>
      distinctBySummary({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'summary', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection, QDistinct>
      distinctByTopGoalProgress({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'topGoalProgress',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<WeeklyStoryCollection, WeeklyStoryCollection, QDistinct>
      distinctByWeekStartDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'weekStartDate');
    });
  }
}

extension WeeklyStoryCollectionQueryProperty on QueryBuilder<
    WeeklyStoryCollection, WeeklyStoryCollection, QQueryProperty> {
  QueryBuilder<WeeklyStoryCollection, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<WeeklyStoryCollection, String?, QQueryOperations>
      achievementHighlightProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'achievementHighlight');
    });
  }

  QueryBuilder<WeeklyStoryCollection, String, QQueryOperations>
      bodyTextProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bodyText');
    });
  }

  QueryBuilder<WeeklyStoryCollection, DateTime, QQueryOperations>
      generatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'generatedAt');
    });
  }

  QueryBuilder<WeeklyStoryCollection, String, QQueryOperations>
      headlineProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'headline');
    });
  }

  QueryBuilder<WeeklyStoryCollection, int, QQueryOperations>
      healthScoreDeltaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'healthScoreDelta');
    });
  }

  QueryBuilder<WeeklyStoryCollection, String, QQueryOperations>
      storyIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'storyId');
    });
  }

  QueryBuilder<WeeklyStoryCollection, String, QQueryOperations>
      streakInfoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'streakInfo');
    });
  }

  QueryBuilder<WeeklyStoryCollection, String, QQueryOperations>
      summaryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'summary');
    });
  }

  QueryBuilder<WeeklyStoryCollection, String, QQueryOperations>
      topGoalProgressProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'topGoalProgress');
    });
  }

  QueryBuilder<WeeklyStoryCollection, DateTime, QQueryOperations>
      weekStartDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'weekStartDate');
    });
  }
}
