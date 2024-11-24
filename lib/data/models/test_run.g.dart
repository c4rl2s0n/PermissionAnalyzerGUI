// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_run.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const TestRunSchema = Schema(
  name: r'TestRun',
  id: -4042852072460897997,
  properties: {
    r'connections': PropertySchema(
      id: 0,
      name: r'connections',
      type: IsarType.objectList,
      target: r'TrafficConnection',
    ),
    r'endpoints': PropertySchema(
      id: 1,
      name: r'endpoints',
      type: IsarType.objectList,
      target: r'TrafficEndpoint',
    ),
    r'hasData': PropertySchema(
      id: 2,
      name: r'hasData',
      type: IsarType.bool,
    ),
    r'packets': PropertySchema(
      id: 3,
      name: r'packets',
      type: IsarType.objectList,
      target: r'NetworkPacket',
    ),
    r'pcapPath': PropertySchema(
      id: 4,
      name: r'pcapPath',
      type: IsarType.string,
    ),
    r'screenRecordPath': PropertySchema(
      id: 5,
      name: r'screenRecordPath',
      type: IsarType.string,
    )
  },
  estimateSize: _testRunEstimateSize,
  serialize: _testRunSerialize,
  deserialize: _testRunDeserialize,
  deserializeProp: _testRunDeserializeProp,
);

int _testRunEstimateSize(
  TestRun object,
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
  {
    final list = object.packets;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[NetworkPacket]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount +=
              NetworkPacketSchema.estimateSize(value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final value = object.pcapPath;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.screenRecordPath;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _testRunSerialize(
  TestRun object,
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
  writer.writeObjectList<TrafficEndpoint>(
    offsets[1],
    allOffsets,
    TrafficEndpointSchema.serialize,
    object.endpoints,
  );
  writer.writeBool(offsets[2], object.hasData);
  writer.writeObjectList<NetworkPacket>(
    offsets[3],
    allOffsets,
    NetworkPacketSchema.serialize,
    object.packets,
  );
  writer.writeString(offsets[4], object.pcapPath);
  writer.writeString(offsets[5], object.screenRecordPath);
}

TestRun _testRunDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TestRun(
    connections: reader.readObjectList<TrafficConnection>(
          offsets[0],
          TrafficConnectionSchema.deserialize,
          allOffsets,
          TrafficConnection(),
        ) ??
        const [],
    packets: reader.readObjectList<NetworkPacket>(
      offsets[3],
      NetworkPacketSchema.deserialize,
      allOffsets,
      NetworkPacket(),
    ),
    pcapPath: reader.readStringOrNull(offsets[4]),
    screenRecordPath: reader.readStringOrNull(offsets[5]),
  );
  object.endpoints = reader.readObjectList<TrafficEndpoint>(
        offsets[1],
        TrafficEndpointSchema.deserialize,
        allOffsets,
        TrafficEndpoint(),
      ) ??
      [];
  return object;
}

P _testRunDeserializeProp<P>(
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
          const []) as P;
    case 1:
      return (reader.readObjectList<TrafficEndpoint>(
            offset,
            TrafficEndpointSchema.deserialize,
            allOffsets,
            TrafficEndpoint(),
          ) ??
          []) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readObjectList<NetworkPacket>(
        offset,
        NetworkPacketSchema.deserialize,
        allOffsets,
        NetworkPacket(),
      )) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension TestRunQueryFilter
    on QueryBuilder<TestRun, TestRun, QFilterCondition> {
  QueryBuilder<TestRun, TestRun, QAfterFilterCondition>
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

  QueryBuilder<TestRun, TestRun, QAfterFilterCondition> connectionsIsEmpty() {
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

  QueryBuilder<TestRun, TestRun, QAfterFilterCondition>
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

  QueryBuilder<TestRun, TestRun, QAfterFilterCondition>
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

  QueryBuilder<TestRun, TestRun, QAfterFilterCondition>
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

  QueryBuilder<TestRun, TestRun, QAfterFilterCondition>
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

  QueryBuilder<TestRun, TestRun, QAfterFilterCondition> endpointsLengthEqualTo(
      int length) {
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

  QueryBuilder<TestRun, TestRun, QAfterFilterCondition> endpointsIsEmpty() {
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

  QueryBuilder<TestRun, TestRun, QAfterFilterCondition> endpointsIsNotEmpty() {
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

  QueryBuilder<TestRun, TestRun, QAfterFilterCondition> endpointsLengthLessThan(
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

  QueryBuilder<TestRun, TestRun, QAfterFilterCondition>
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

  QueryBuilder<TestRun, TestRun, QAfterFilterCondition> endpointsLengthBetween(
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

  QueryBuilder<TestRun, TestRun, QAfterFilterCondition> hasDataEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hasData',
        value: value,
      ));
    });
  }

  QueryBuilder<TestRun, TestRun, QAfterFilterCondition> packetsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'packets',
      ));
    });
  }

  QueryBuilder<TestRun, TestRun, QAfterFilterCondition> packetsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'packets',
      ));
    });
  }

  QueryBuilder<TestRun, TestRun, QAfterFilterCondition> packetsLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'packets',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<TestRun, TestRun, QAfterFilterCondition> packetsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'packets',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<TestRun, TestRun, QAfterFilterCondition> packetsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'packets',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<TestRun, TestRun, QAfterFilterCondition> packetsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'packets',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<TestRun, TestRun, QAfterFilterCondition>
      packetsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'packets',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<TestRun, TestRun, QAfterFilterCondition> packetsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'packets',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<TestRun, TestRun, QAfterFilterCondition> pcapPathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'pcapPath',
      ));
    });
  }

  QueryBuilder<TestRun, TestRun, QAfterFilterCondition> pcapPathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'pcapPath',
      ));
    });
  }

  QueryBuilder<TestRun, TestRun, QAfterFilterCondition> pcapPathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pcapPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestRun, TestRun, QAfterFilterCondition> pcapPathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pcapPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestRun, TestRun, QAfterFilterCondition> pcapPathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pcapPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestRun, TestRun, QAfterFilterCondition> pcapPathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pcapPath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestRun, TestRun, QAfterFilterCondition> pcapPathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'pcapPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestRun, TestRun, QAfterFilterCondition> pcapPathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'pcapPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestRun, TestRun, QAfterFilterCondition> pcapPathContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'pcapPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestRun, TestRun, QAfterFilterCondition> pcapPathMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'pcapPath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestRun, TestRun, QAfterFilterCondition> pcapPathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pcapPath',
        value: '',
      ));
    });
  }

  QueryBuilder<TestRun, TestRun, QAfterFilterCondition> pcapPathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'pcapPath',
        value: '',
      ));
    });
  }

  QueryBuilder<TestRun, TestRun, QAfterFilterCondition>
      screenRecordPathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'screenRecordPath',
      ));
    });
  }

  QueryBuilder<TestRun, TestRun, QAfterFilterCondition>
      screenRecordPathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'screenRecordPath',
      ));
    });
  }

  QueryBuilder<TestRun, TestRun, QAfterFilterCondition> screenRecordPathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'screenRecordPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestRun, TestRun, QAfterFilterCondition>
      screenRecordPathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'screenRecordPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestRun, TestRun, QAfterFilterCondition>
      screenRecordPathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'screenRecordPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestRun, TestRun, QAfterFilterCondition> screenRecordPathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'screenRecordPath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestRun, TestRun, QAfterFilterCondition>
      screenRecordPathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'screenRecordPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestRun, TestRun, QAfterFilterCondition>
      screenRecordPathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'screenRecordPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestRun, TestRun, QAfterFilterCondition>
      screenRecordPathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'screenRecordPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestRun, TestRun, QAfterFilterCondition> screenRecordPathMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'screenRecordPath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestRun, TestRun, QAfterFilterCondition>
      screenRecordPathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'screenRecordPath',
        value: '',
      ));
    });
  }

  QueryBuilder<TestRun, TestRun, QAfterFilterCondition>
      screenRecordPathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'screenRecordPath',
        value: '',
      ));
    });
  }
}

extension TestRunQueryObject
    on QueryBuilder<TestRun, TestRun, QFilterCondition> {
  QueryBuilder<TestRun, TestRun, QAfterFilterCondition> connectionsElement(
      FilterQuery<TrafficConnection> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'connections');
    });
  }

  QueryBuilder<TestRun, TestRun, QAfterFilterCondition> endpointsElement(
      FilterQuery<TrafficEndpoint> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'endpoints');
    });
  }

  QueryBuilder<TestRun, TestRun, QAfterFilterCondition> packetsElement(
      FilterQuery<NetworkPacket> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'packets');
    });
  }
}
