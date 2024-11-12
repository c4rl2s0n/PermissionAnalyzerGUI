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
    r'endpoints': PropertySchema(
      id: 1,
      name: r'endpoints',
      type: IsarType.objectList,
      target: r'TrafficEndpoint',
    ),
    r'info': PropertySchema(
      id: 2,
      name: r'info',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 3,
      name: r'name',
      type: IsarType.string,
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
  {
    final value = object.info;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.name.length * 3;
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
  writer.writeObjectList<TrafficEndpoint>(
    offsets[1],
    allOffsets,
    TrafficEndpointSchema.serialize,
    object.endpoints,
  );
  writer.writeString(offsets[2], object.info);
  writer.writeString(offsets[3], object.name);
}

TrafficGroup _trafficGroupDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TrafficGroup(
    connections: reader.readObjectList<TrafficConnection>(
          offsets[0],
          TrafficConnectionSchema.deserialize,
          allOffsets,
          TrafficConnection(),
        ) ??
        const [],
    info: reader.readStringOrNull(offsets[2]),
    name: reader.readStringOrNull(offsets[3]) ?? "",
  );
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
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset) ?? "") as P;
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
}
