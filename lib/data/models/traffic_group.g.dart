// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'traffic_group.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const TrafficGroupSchema = Schema(
  name: r'TrafficGroup',
  id: 9215509396303311655,
  properties: {
    r'connections': PropertySchema(
      id: 0,
      name: r'connections',
      type: IsarType.objectList,
      target: r'TrafficConnection',
    ),
    r'endpointCountAvg': PropertySchema(
      id: 1,
      name: r'endpointCountAvg',
      type: IsarType.long,
    ),
    r'endpointCountMax': PropertySchema(
      id: 2,
      name: r'endpointCountMax',
      type: IsarType.long,
    ),
    r'endpointCountMin': PropertySchema(
      id: 3,
      name: r'endpointCountMin',
      type: IsarType.long,
    ),
    r'endpoints': PropertySchema(
      id: 4,
      name: r'endpoints',
      type: IsarType.objectList,
      target: r'TrafficEndpoint',
    ),
    r'id': PropertySchema(
      id: 5,
      name: r'id',
      type: IsarType.string,
    ),
    r'info': PropertySchema(
      id: 6,
      name: r'info',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 7,
      name: r'name',
      type: IsarType.string,
    ),
    r'tags': PropertySchema(
      id: 8,
      name: r'tags',
      type: IsarType.stringList,
    ),
    r'testRuns': PropertySchema(
      id: 9,
      name: r'testRuns',
      type: IsarType.long,
    ),
    r'tests': PropertySchema(
      id: 10,
      name: r'tests',
      type: IsarType.objectList,
      target: r'TestRun',
    )
  },
  estimateSize: _trafficGroupEstimateSize,
  serialize: _trafficGroupSerialize,
  deserialize: _trafficGroupDeserialize,
  deserializeProp: _trafficGroupDeserializeProp,
);

int _trafficGroupEstimateSize(
  TrafficGroup object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.connections.length * 3;
  {
    final offsets = allOffsets[TrafficConnection]!;
    for (var i = 0; i < object.connections.length; i++) {
      final value = object.connections[i];
      bytesCount +=
          TrafficConnectionSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  bytesCount += 3 + object.endpoints.length * 3;
  {
    final offsets = allOffsets[TrafficEndpoint]!;
    for (var i = 0; i < object.endpoints.length; i++) {
      final value = object.endpoints[i];
      bytesCount +=
          TrafficEndpointSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  bytesCount += 3 + object.id.length * 3;
  {
    final value = object.info;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.tags.length * 3;
  {
    for (var i = 0; i < object.tags.length; i++) {
      final value = object.tags[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.tests.length * 3;
  {
    final offsets = allOffsets[TestRun]!;
    for (var i = 0; i < object.tests.length; i++) {
      final value = object.tests[i];
      bytesCount += TestRunSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  return bytesCount;
}

void _trafficGroupSerialize(
  TrafficGroup object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObjectList<TrafficConnection>(
    offsets[0],
    allOffsets,
    TrafficConnectionSchema.serialize,
    object.connections,
  );
  writer.writeLong(offsets[1], object.endpointCountAvg);
  writer.writeLong(offsets[2], object.endpointCountMax);
  writer.writeLong(offsets[3], object.endpointCountMin);
  writer.writeObjectList<TrafficEndpoint>(
    offsets[4],
    allOffsets,
    TrafficEndpointSchema.serialize,
    object.endpoints,
  );
  writer.writeString(offsets[5], object.id);
  writer.writeString(offsets[6], object.info);
  writer.writeString(offsets[7], object.name);
  writer.writeStringList(offsets[8], object.tags);
  writer.writeLong(offsets[9], object.testRuns);
  writer.writeObjectList<TestRun>(
    offsets[10],
    allOffsets,
    TestRunSchema.serialize,
    object.tests,
  );
}

TrafficGroup _trafficGroupDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TrafficGroup(
    id: reader.readStringOrNull(offsets[5]) ?? "",
    info: reader.readStringOrNull(offsets[6]),
    name: reader.readStringOrNull(offsets[7]) ?? "",
    tags: reader.readStringList(offsets[8]) ?? const [],
    tests: reader.readObjectList<TestRun>(
          offsets[10],
          TestRunSchema.deserialize,
          allOffsets,
          TestRun(),
        ) ??
        const [],
  );
  object.connections = reader.readObjectList<TrafficConnection>(
        offsets[0],
        TrafficConnectionSchema.deserialize,
        allOffsets,
        TrafficConnection(),
      ) ??
      [];
  object.endpointCountAvg = reader.readLong(offsets[1]);
  object.endpointCountMax = reader.readLong(offsets[2]);
  object.endpointCountMin = reader.readLong(offsets[3]);
  object.endpoints = reader.readObjectList<TrafficEndpoint>(
        offsets[4],
        TrafficEndpointSchema.deserialize,
        allOffsets,
        TrafficEndpoint(),
      ) ??
      [];
  object.testRuns = reader.readLong(offsets[9]);
  return object;
}

P _trafficGroupDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectList<TrafficConnection>(
            offset,
            TrafficConnectionSchema.deserialize,
            allOffsets,
            TrafficConnection(),
          ) ??
          []) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readObjectList<TrafficEndpoint>(
            offset,
            TrafficEndpointSchema.deserialize,
            allOffsets,
            TrafficEndpoint(),
          ) ??
          []) as P;
    case 5:
      return (reader.readStringOrNull(offset) ?? "") as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset) ?? "") as P;
    case 8:
      return (reader.readStringList(offset) ?? const []) as P;
    case 9:
      return (reader.readLong(offset)) as P;
    case 10:
      return (reader.readObjectList<TestRun>(
            offset,
            TestRunSchema.deserialize,
            allOffsets,
            TestRun(),
          ) ??
          const []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension TrafficGroupQueryFilter
    on QueryBuilder<TrafficGroup, TrafficGroup, QFilterCondition> {
  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition>
      connectionsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'connections',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition>
      connectionsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'connections',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition>
      connectionsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'connections',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition>
      connectionsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'connections',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition>
      connectionsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'connections',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition>
      connectionsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'connections',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition>
      endpointCountAvgEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'endpointCountAvg',
        value: value,
      ));
    });
  }

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition>
      endpointCountAvgGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'endpointCountAvg',
        value: value,
      ));
    });
  }

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition>
      endpointCountAvgLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'endpointCountAvg',
        value: value,
      ));
    });
  }

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition>
      endpointCountAvgBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'endpointCountAvg',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition>
      endpointCountMaxEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'endpointCountMax',
        value: value,
      ));
    });
  }

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition>
      endpointCountMaxGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'endpointCountMax',
        value: value,
      ));
    });
  }

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition>
      endpointCountMaxLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'endpointCountMax',
        value: value,
      ));
    });
  }

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition>
      endpointCountMaxBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'endpointCountMax',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition>
      endpointCountMinEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'endpointCountMin',
        value: value,
      ));
    });
  }

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition>
      endpointCountMinGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'endpointCountMin',
        value: value,
      ));
    });
  }

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition>
      endpointCountMinLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'endpointCountMin',
        value: value,
      ));
    });
  }

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition>
      endpointCountMinBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'endpointCountMin',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition>
      endpointsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'endpoints',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition>
      endpointsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'endpoints',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition>
      endpointsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'endpoints',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition>
      endpointsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'endpoints',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition>
      endpointsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'endpoints',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition>
      endpointsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'endpoints',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition> idEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition> idGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition> idLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition> idBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition> idStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition> idEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition> idContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition> idMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'id',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition> idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition>
      idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition> infoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'info',
      ));
    });
  }

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition>
      infoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'info',
      ));
    });
  }

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition> infoEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'info',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition>
      infoGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'info',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition> infoLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'info',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition> infoBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'info',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition>
      infoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'info',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition> infoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'info',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition> infoContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'info',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition> infoMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'info',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition>
      infoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'info',
        value: '',
      ));
    });
  }

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition>
      infoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'info',
        value: '',
      ));
    });
  }

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition>
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

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition> nameLessThan(
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

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition> nameBetween(
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

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition>
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

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition> nameEndsWith(
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

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition> nameContains(
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

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition> nameMatches(
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

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition>
      tagsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition>
      tagsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition>
      tagsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition>
      tagsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tags',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition>
      tagsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition>
      tagsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition>
      tagsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition>
      tagsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tags',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition>
      tagsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tags',
        value: '',
      ));
    });
  }

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition>
      tagsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tags',
        value: '',
      ));
    });
  }

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition>
      tagsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition>
      tagsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition>
      tagsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition>
      tagsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition>
      tagsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition>
      tagsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition>
      testRunsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'testRuns',
        value: value,
      ));
    });
  }

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition>
      testRunsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'testRuns',
        value: value,
      ));
    });
  }

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition>
      testRunsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'testRuns',
        value: value,
      ));
    });
  }

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition>
      testRunsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'testRuns',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition>
      testsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tests',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition>
      testsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tests',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition>
      testsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tests',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition>
      testsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tests',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition>
      testsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tests',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition>
      testsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tests',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension TrafficGroupQueryObject
    on QueryBuilder<TrafficGroup, TrafficGroup, QFilterCondition> {
  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition>
      connectionsElement(FilterQuery<TrafficConnection> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'connections');
    });
  }

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition>
      endpointsElement(FilterQuery<TrafficEndpoint> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'endpoints');
    });
  }

  QueryBuilder<TrafficGroup, TrafficGroup, QAfterFilterCondition> testsElement(
      FilterQuery<TestRun> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'tests');
    });
  }
}
