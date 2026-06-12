// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journey_event.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetJourneyEventCollectionCollection on Isar {
  IsarCollection<JourneyEventCollection> get journeyEventCollections =>
      this.collection();
}

const JourneyEventCollectionSchema = CollectionSchema(
  name: r'JourneyEventCollection',
  id: 86944551493061384,
  properties: {
    r'description': PropertySchema(
      id: 0,
      name: r'description',
      type: IsarType.string,
    ),
    r'eventId': PropertySchema(
      id: 1,
      name: r'eventId',
      type: IsarType.string,
    ),
    r'eventType': PropertySchema(
      id: 2,
      name: r'eventType',
      type: IsarType.string,
    ),
    r'iconKey': PropertySchema(
      id: 3,
      name: r'iconKey',
      type: IsarType.string,
    ),
    r'relatedGoalId': PropertySchema(
      id: 4,
      name: r'relatedGoalId',
      type: IsarType.string,
    ),
    r'timestamp': PropertySchema(
      id: 5,
      name: r'timestamp',
      type: IsarType.dateTime,
    ),
    r'title': PropertySchema(
      id: 6,
      name: r'title',
      type: IsarType.string,
    )
  },
  estimateSize: _journeyEventCollectionEstimateSize,
  serialize: _journeyEventCollectionSerialize,
  deserialize: _journeyEventCollectionDeserialize,
  deserializeProp: _journeyEventCollectionDeserializeProp,
  idName: r'id',
  indexes: {
    r'eventId': IndexSchema(
      id: -2707901133518603130,
      name: r'eventId',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'eventId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _journeyEventCollectionGetId,
  getLinks: _journeyEventCollectionGetLinks,
  attach: _journeyEventCollectionAttach,
  version: '3.1.0+1',
);

int _journeyEventCollectionEstimateSize(
  JourneyEventCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.description.length * 3;
  bytesCount += 3 + object.eventId.length * 3;
  bytesCount += 3 + object.eventType.length * 3;
  bytesCount += 3 + object.iconKey.length * 3;
  {
    final value = object.relatedGoalId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.title.length * 3;
  return bytesCount;
}

void _journeyEventCollectionSerialize(
  JourneyEventCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.description);
  writer.writeString(offsets[1], object.eventId);
  writer.writeString(offsets[2], object.eventType);
  writer.writeString(offsets[3], object.iconKey);
  writer.writeString(offsets[4], object.relatedGoalId);
  writer.writeDateTime(offsets[5], object.timestamp);
  writer.writeString(offsets[6], object.title);
}

JourneyEventCollection _journeyEventCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = JourneyEventCollection();
  object.description = reader.readString(offsets[0]);
  object.eventId = reader.readString(offsets[1]);
  object.eventType = reader.readString(offsets[2]);
  object.iconKey = reader.readString(offsets[3]);
  object.id = id;
  object.relatedGoalId = reader.readStringOrNull(offsets[4]);
  object.timestamp = reader.readDateTime(offsets[5]);
  object.title = reader.readString(offsets[6]);
  return object;
}

P _journeyEventCollectionDeserializeProp<P>(
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
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readDateTime(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _journeyEventCollectionGetId(JourneyEventCollection object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _journeyEventCollectionGetLinks(
    JourneyEventCollection object) {
  return [];
}

void _journeyEventCollectionAttach(
    IsarCollection<dynamic> col, Id id, JourneyEventCollection object) {
  object.id = id;
}

extension JourneyEventCollectionByIndex
    on IsarCollection<JourneyEventCollection> {
  Future<JourneyEventCollection?> getByEventId(String eventId) {
    return getByIndex(r'eventId', [eventId]);
  }

  JourneyEventCollection? getByEventIdSync(String eventId) {
    return getByIndexSync(r'eventId', [eventId]);
  }

  Future<bool> deleteByEventId(String eventId) {
    return deleteByIndex(r'eventId', [eventId]);
  }

  bool deleteByEventIdSync(String eventId) {
    return deleteByIndexSync(r'eventId', [eventId]);
  }

  Future<List<JourneyEventCollection?>> getAllByEventId(
      List<String> eventIdValues) {
    final values = eventIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'eventId', values);
  }

  List<JourneyEventCollection?> getAllByEventIdSync(
      List<String> eventIdValues) {
    final values = eventIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'eventId', values);
  }

  Future<int> deleteAllByEventId(List<String> eventIdValues) {
    final values = eventIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'eventId', values);
  }

  int deleteAllByEventIdSync(List<String> eventIdValues) {
    final values = eventIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'eventId', values);
  }

  Future<Id> putByEventId(JourneyEventCollection object) {
    return putByIndex(r'eventId', object);
  }

  Id putByEventIdSync(JourneyEventCollection object, {bool saveLinks = true}) {
    return putByIndexSync(r'eventId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByEventId(List<JourneyEventCollection> objects) {
    return putAllByIndex(r'eventId', objects);
  }

  List<Id> putAllByEventIdSync(List<JourneyEventCollection> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'eventId', objects, saveLinks: saveLinks);
  }
}

extension JourneyEventCollectionQueryWhereSort
    on QueryBuilder<JourneyEventCollection, JourneyEventCollection, QWhere> {
  QueryBuilder<JourneyEventCollection, JourneyEventCollection, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension JourneyEventCollectionQueryWhere on QueryBuilder<
    JourneyEventCollection, JourneyEventCollection, QWhereClause> {
  QueryBuilder<JourneyEventCollection, JourneyEventCollection,
      QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection,
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

  QueryBuilder<JourneyEventCollection, JourneyEventCollection,
      QAfterWhereClause> idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection,
      QAfterWhereClause> idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection,
      QAfterWhereClause> idBetween(
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

  QueryBuilder<JourneyEventCollection, JourneyEventCollection,
      QAfterWhereClause> eventIdEqualTo(String eventId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'eventId',
        value: [eventId],
      ));
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection,
      QAfterWhereClause> eventIdNotEqualTo(String eventId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'eventId',
              lower: [],
              upper: [eventId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'eventId',
              lower: [eventId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'eventId',
              lower: [eventId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'eventId',
              lower: [],
              upper: [eventId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension JourneyEventCollectionQueryFilter on QueryBuilder<
    JourneyEventCollection, JourneyEventCollection, QFilterCondition> {
  QueryBuilder<JourneyEventCollection, JourneyEventCollection,
      QAfterFilterCondition> descriptionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection,
      QAfterFilterCondition> descriptionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection,
      QAfterFilterCondition> descriptionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection,
      QAfterFilterCondition> descriptionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'description',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection,
      QAfterFilterCondition> descriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection,
      QAfterFilterCondition> descriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection,
          QAfterFilterCondition>
      descriptionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection,
          QAfterFilterCondition>
      descriptionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'description',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection,
      QAfterFilterCondition> descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection,
      QAfterFilterCondition> descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection,
      QAfterFilterCondition> eventIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'eventId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection,
      QAfterFilterCondition> eventIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'eventId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection,
      QAfterFilterCondition> eventIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'eventId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection,
      QAfterFilterCondition> eventIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'eventId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection,
      QAfterFilterCondition> eventIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'eventId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection,
      QAfterFilterCondition> eventIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'eventId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection,
          QAfterFilterCondition>
      eventIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'eventId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection,
          QAfterFilterCondition>
      eventIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'eventId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection,
      QAfterFilterCondition> eventIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'eventId',
        value: '',
      ));
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection,
      QAfterFilterCondition> eventIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'eventId',
        value: '',
      ));
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection,
      QAfterFilterCondition> eventTypeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'eventType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection,
      QAfterFilterCondition> eventTypeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'eventType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection,
      QAfterFilterCondition> eventTypeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'eventType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection,
      QAfterFilterCondition> eventTypeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'eventType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection,
      QAfterFilterCondition> eventTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'eventType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection,
      QAfterFilterCondition> eventTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'eventType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection,
          QAfterFilterCondition>
      eventTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'eventType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection,
          QAfterFilterCondition>
      eventTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'eventType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection,
      QAfterFilterCondition> eventTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'eventType',
        value: '',
      ));
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection,
      QAfterFilterCondition> eventTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'eventType',
        value: '',
      ));
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection,
      QAfterFilterCondition> iconKeyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'iconKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection,
      QAfterFilterCondition> iconKeyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'iconKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection,
      QAfterFilterCondition> iconKeyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'iconKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection,
      QAfterFilterCondition> iconKeyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'iconKey',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection,
      QAfterFilterCondition> iconKeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'iconKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection,
      QAfterFilterCondition> iconKeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'iconKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection,
          QAfterFilterCondition>
      iconKeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'iconKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection,
          QAfterFilterCondition>
      iconKeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'iconKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection,
      QAfterFilterCondition> iconKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'iconKey',
        value: '',
      ));
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection,
      QAfterFilterCondition> iconKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'iconKey',
        value: '',
      ));
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection,
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

  QueryBuilder<JourneyEventCollection, JourneyEventCollection,
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

  QueryBuilder<JourneyEventCollection, JourneyEventCollection,
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

  QueryBuilder<JourneyEventCollection, JourneyEventCollection,
      QAfterFilterCondition> relatedGoalIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'relatedGoalId',
      ));
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection,
      QAfterFilterCondition> relatedGoalIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'relatedGoalId',
      ));
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection,
      QAfterFilterCondition> relatedGoalIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'relatedGoalId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection,
      QAfterFilterCondition> relatedGoalIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'relatedGoalId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection,
      QAfterFilterCondition> relatedGoalIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'relatedGoalId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection,
      QAfterFilterCondition> relatedGoalIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'relatedGoalId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection,
      QAfterFilterCondition> relatedGoalIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'relatedGoalId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection,
      QAfterFilterCondition> relatedGoalIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'relatedGoalId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection,
          QAfterFilterCondition>
      relatedGoalIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'relatedGoalId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection,
          QAfterFilterCondition>
      relatedGoalIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'relatedGoalId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection,
      QAfterFilterCondition> relatedGoalIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'relatedGoalId',
        value: '',
      ));
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection,
      QAfterFilterCondition> relatedGoalIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'relatedGoalId',
        value: '',
      ));
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection,
      QAfterFilterCondition> timestampEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection,
      QAfterFilterCondition> timestampGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection,
      QAfterFilterCondition> timestampLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection,
      QAfterFilterCondition> timestampBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'timestamp',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection,
      QAfterFilterCondition> titleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection,
      QAfterFilterCondition> titleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection,
      QAfterFilterCondition> titleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection,
      QAfterFilterCondition> titleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection,
      QAfterFilterCondition> titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection,
      QAfterFilterCondition> titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection,
          QAfterFilterCondition>
      titleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection,
          QAfterFilterCondition>
      titleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection,
      QAfterFilterCondition> titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection,
      QAfterFilterCondition> titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }
}

extension JourneyEventCollectionQueryObject on QueryBuilder<
    JourneyEventCollection, JourneyEventCollection, QFilterCondition> {}

extension JourneyEventCollectionQueryLinks on QueryBuilder<
    JourneyEventCollection, JourneyEventCollection, QFilterCondition> {}

extension JourneyEventCollectionQuerySortBy
    on QueryBuilder<JourneyEventCollection, JourneyEventCollection, QSortBy> {
  QueryBuilder<JourneyEventCollection, JourneyEventCollection, QAfterSortBy>
      sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection, QAfterSortBy>
      sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection, QAfterSortBy>
      sortByEventId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eventId', Sort.asc);
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection, QAfterSortBy>
      sortByEventIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eventId', Sort.desc);
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection, QAfterSortBy>
      sortByEventType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eventType', Sort.asc);
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection, QAfterSortBy>
      sortByEventTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eventType', Sort.desc);
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection, QAfterSortBy>
      sortByIconKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconKey', Sort.asc);
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection, QAfterSortBy>
      sortByIconKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconKey', Sort.desc);
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection, QAfterSortBy>
      sortByRelatedGoalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'relatedGoalId', Sort.asc);
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection, QAfterSortBy>
      sortByRelatedGoalIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'relatedGoalId', Sort.desc);
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection, QAfterSortBy>
      sortByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection, QAfterSortBy>
      sortByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection, QAfterSortBy>
      sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection, QAfterSortBy>
      sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension JourneyEventCollectionQuerySortThenBy on QueryBuilder<
    JourneyEventCollection, JourneyEventCollection, QSortThenBy> {
  QueryBuilder<JourneyEventCollection, JourneyEventCollection, QAfterSortBy>
      thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection, QAfterSortBy>
      thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection, QAfterSortBy>
      thenByEventId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eventId', Sort.asc);
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection, QAfterSortBy>
      thenByEventIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eventId', Sort.desc);
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection, QAfterSortBy>
      thenByEventType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eventType', Sort.asc);
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection, QAfterSortBy>
      thenByEventTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eventType', Sort.desc);
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection, QAfterSortBy>
      thenByIconKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconKey', Sort.asc);
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection, QAfterSortBy>
      thenByIconKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconKey', Sort.desc);
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection, QAfterSortBy>
      thenByRelatedGoalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'relatedGoalId', Sort.asc);
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection, QAfterSortBy>
      thenByRelatedGoalIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'relatedGoalId', Sort.desc);
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection, QAfterSortBy>
      thenByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection, QAfterSortBy>
      thenByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection, QAfterSortBy>
      thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection, QAfterSortBy>
      thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension JourneyEventCollectionQueryWhereDistinct
    on QueryBuilder<JourneyEventCollection, JourneyEventCollection, QDistinct> {
  QueryBuilder<JourneyEventCollection, JourneyEventCollection, QDistinct>
      distinctByDescription({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection, QDistinct>
      distinctByEventId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'eventId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection, QDistinct>
      distinctByEventType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'eventType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection, QDistinct>
      distinctByIconKey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'iconKey', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection, QDistinct>
      distinctByRelatedGoalId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'relatedGoalId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection, QDistinct>
      distinctByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timestamp');
    });
  }

  QueryBuilder<JourneyEventCollection, JourneyEventCollection, QDistinct>
      distinctByTitle({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }
}

extension JourneyEventCollectionQueryProperty on QueryBuilder<
    JourneyEventCollection, JourneyEventCollection, QQueryProperty> {
  QueryBuilder<JourneyEventCollection, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<JourneyEventCollection, String, QQueryOperations>
      descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<JourneyEventCollection, String, QQueryOperations>
      eventIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'eventId');
    });
  }

  QueryBuilder<JourneyEventCollection, String, QQueryOperations>
      eventTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'eventType');
    });
  }

  QueryBuilder<JourneyEventCollection, String, QQueryOperations>
      iconKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'iconKey');
    });
  }

  QueryBuilder<JourneyEventCollection, String?, QQueryOperations>
      relatedGoalIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'relatedGoalId');
    });
  }

  QueryBuilder<JourneyEventCollection, DateTime, QQueryOperations>
      timestampProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timestamp');
    });
  }

  QueryBuilder<JourneyEventCollection, String, QQueryOperations>
      titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }
}
