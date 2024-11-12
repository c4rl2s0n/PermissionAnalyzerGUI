// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'traffic_connection.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const TrafficConnectionSchema = Schema(
  name: r'TrafficConnection',
  id: -3577010959423121721,
  properties: {
    r'bytes': PropertySchema(
      id: 0,
      name: r'bytes',
      type: IsarType.long,
    ),
    r'count': PropertySchema(
      id: 1,
      name: r'count',
      type: IsarType.long,
    ),
    r'endpoint': PropertySchema(
      id: 2,
      name: r'endpoint',
      type: IsarType.object,
      target: r'TrafficEndpoint',
    ),
    r'inBytes': PropertySchema(
      id: 3,
      name: r'inBytes',
      type: IsarType.long,
    ),
    r'inCount': PropertySchema(
      id: 4,
      name: r'inCount',
      type: IsarType.long,
    ),
    r'outBytes': PropertySchema(
      id: 5,
      name: r'outBytes',
      type: IsarType.long,
    ),
    r'outCount': PropertySchema(
      id: 6,
      name: r'outCount',
      type: IsarType.long,
    ),
    r'protocols': PropertySchema(
      id: 7,
      name: r'protocols',
      type: IsarType.string,
    )
  },
  estimateSize: _trafficConnectionEstimateSize,
  serialize: _trafficConnectionSerialize,
  deserialize: _trafficConnectionDeserialize,
  deserializeProp: _trafficConnectionDeserializeProp,
);

int _trafficConnectionEstimateSize(
  TrafficConnection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 +
      TrafficEndpointSchema.estimateSize(
          object.endpoint, allOffsets[TrafficEndpoint]!, allOffsets);
  {
    final value = object.protocols;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _trafficConnectionSerialize(
  TrafficConnection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.bytes);
  writer.writeLong(offsets[1], object.count);
  writer.writeObject<TrafficEndpoint>(
    offsets[2],
    allOffsets,
    TrafficEndpointSchema.serialize,
    object.endpoint,
  );
  writer.writeLong(offsets[3], object.inBytes);
  writer.writeLong(offsets[4], object.inCount);
  writer.writeLong(offsets[5], object.outBytes);
  writer.writeLong(offsets[6], object.outCount);
  writer.writeString(offsets[7], object.protocols);
}

TrafficConnection _trafficConnectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TrafficConnection(
    endpoint: reader.readObjectOrNull<TrafficEndpoint>(
          offsets[2],
          TrafficEndpointSchema.deserialize,
          allOffsets,
        ) ??
        const TrafficEndpoint(),
    inBytes: reader.readLongOrNull(offsets[3]) ?? 0,
    inCount: reader.readLongOrNull(offsets[4]) ?? 0,
    outBytes: reader.readLongOrNull(offsets[5]) ?? 0,
    outCount: reader.readLongOrNull(offsets[6]) ?? 0,
    protocols: reader.readStringOrNull(offsets[7]),
  );
  return object;
}

P _trafficConnectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readObjectOrNull<TrafficEndpoint>(
            offset,
            TrafficEndpointSchema.deserialize,
            allOffsets,
          ) ??
          const TrafficEndpoint()) as P;
    case 3:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 4:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 5:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 6:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension TrafficConnectionQueryFilter
    on QueryBuilder<TrafficConnection, TrafficConnection, QFilterCondition> {
  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      bytesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bytes',
        value: value,
      ));
    });
  }

  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      bytesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bytes',
        value: value,
      ));
    });
  }

  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      bytesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bytes',
        value: value,
      ));
    });
  }

  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      bytesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bytes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      countEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'count',
        value: value,
      ));
    });
  }

  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      countGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'count',
        value: value,
      ));
    });
  }

  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      countLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'count',
        value: value,
      ));
    });
  }

  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      countBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'count',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      inBytesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'inBytes',
        value: value,
      ));
    });
  }

  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      inBytesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'inBytes',
        value: value,
      ));
    });
  }

  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      inBytesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'inBytes',
        value: value,
      ));
    });
  }

  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      inBytesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'inBytes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      inCountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'inCount',
        value: value,
      ));
    });
  }

  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      inCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'inCount',
        value: value,
      ));
    });
  }

  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      inCountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'inCount',
        value: value,
      ));
    });
  }

  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      inCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'inCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      outBytesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'outBytes',
        value: value,
      ));
    });
  }

  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      outBytesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'outBytes',
        value: value,
      ));
    });
  }

  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      outBytesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'outBytes',
        value: value,
      ));
    });
  }

  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      outBytesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'outBytes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      outCountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'outCount',
        value: value,
      ));
    });
  }

  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      outCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'outCount',
        value: value,
      ));
    });
  }

  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      outCountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'outCount',
        value: value,
      ));
    });
  }

  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      outCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'outCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      protocolsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'protocols',
      ));
    });
  }

  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      protocolsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'protocols',
      ));
    });
  }

  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      protocolsEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'protocols',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      protocolsGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'protocols',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      protocolsLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'protocols',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      protocolsBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'protocols',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      protocolsStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'protocols',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      protocolsEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'protocols',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      protocolsContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'protocols',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      protocolsMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'protocols',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      protocolsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'protocols',
        value: '',
      ));
    });
  }

  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      protocolsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'protocols',
        value: '',
      ));
    });
  }
}

extension TrafficConnectionQueryObject
    on QueryBuilder<TrafficConnection, TrafficConnection, QFilterCondition> {
  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      endpoint(FilterQuery<TrafficEndpoint> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'endpoint');
    });
  }
}
