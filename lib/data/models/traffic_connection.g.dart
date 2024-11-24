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
    r'bytesAvg': PropertySchema(
      id: 0,
      name: r'bytesAvg',
      type: IsarType.double,
    ),
    r'bytesTotal': PropertySchema(
      id: 1,
      name: r'bytesTotal',
      type: IsarType.long,
    ),
    r'countAvg': PropertySchema(
      id: 2,
      name: r'countAvg',
      type: IsarType.double,
    ),
    r'countTotal': PropertySchema(
      id: 3,
      name: r'countTotal',
      type: IsarType.long,
    ),
    r'endpoint': PropertySchema(
      id: 4,
      name: r'endpoint',
      type: IsarType.object,
      target: r'TrafficEndpoint',
    ),
    r'flow': PropertySchema(
      id: 5,
      name: r'flow',
      type: IsarType.string,
    ),
    r'inBytes': PropertySchema(
      id: 6,
      name: r'inBytes',
      type: IsarType.long,
    ),
    r'inBytesAvg': PropertySchema(
      id: 7,
      name: r'inBytesAvg',
      type: IsarType.double,
    ),
    r'inCount': PropertySchema(
      id: 8,
      name: r'inCount',
      type: IsarType.long,
    ),
    r'inCountAvg': PropertySchema(
      id: 9,
      name: r'inCountAvg',
      type: IsarType.double,
    ),
    r'outBytes': PropertySchema(
      id: 10,
      name: r'outBytes',
      type: IsarType.long,
    ),
    r'outBytesAvg': PropertySchema(
      id: 11,
      name: r'outBytesAvg',
      type: IsarType.double,
    ),
    r'outCount': PropertySchema(
      id: 12,
      name: r'outCount',
      type: IsarType.long,
    ),
    r'outCountAvg': PropertySchema(
      id: 13,
      name: r'outCountAvg',
      type: IsarType.double,
    ),
    r'protocols': PropertySchema(
      id: 14,
      name: r'protocols',
      type: IsarType.string,
    ),
    r'testRunCount': PropertySchema(
      id: 15,
      name: r'testRunCount',
      type: IsarType.long,
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
  {
    final value = object.endpoint;
    if (value != null) {
      bytesCount += 3 +
          TrafficEndpointSchema.estimateSize(
              value, allOffsets[TrafficEndpoint]!, allOffsets);
    }
  }
  bytesCount += 3 + object.flow.length * 3;
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
  writer.writeDouble(offsets[0], object.bytesAvg);
  writer.writeLong(offsets[1], object.bytesTotal);
  writer.writeDouble(offsets[2], object.countAvg);
  writer.writeLong(offsets[3], object.countTotal);
  writer.writeObject<TrafficEndpoint>(
    offsets[4],
    allOffsets,
    TrafficEndpointSchema.serialize,
    object.endpoint,
  );
  writer.writeString(offsets[5], object.flow);
  writer.writeLong(offsets[6], object.inBytes);
  writer.writeDouble(offsets[7], object.inBytesAvg);
  writer.writeLong(offsets[8], object.inCount);
  writer.writeDouble(offsets[9], object.inCountAvg);
  writer.writeLong(offsets[10], object.outBytes);
  writer.writeDouble(offsets[11], object.outBytesAvg);
  writer.writeLong(offsets[12], object.outCount);
  writer.writeDouble(offsets[13], object.outCountAvg);
  writer.writeString(offsets[14], object.protocols);
  writer.writeLong(offsets[15], object.testRunCount);
}

TrafficConnection _trafficConnectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TrafficConnection(
    endpoint: reader.readObjectOrNull<TrafficEndpoint>(
      offsets[4],
      TrafficEndpointSchema.deserialize,
      allOffsets,
    ),
    inBytes: reader.readLongOrNull(offsets[6]) ?? 0,
    inCount: reader.readLongOrNull(offsets[8]) ?? 0,
    outBytes: reader.readLongOrNull(offsets[10]) ?? 0,
    outCount: reader.readLongOrNull(offsets[12]) ?? 0,
    protocols: reader.readStringOrNull(offsets[14]),
    testRunCount: reader.readLongOrNull(offsets[15]) ?? 1,
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
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readDouble(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readObjectOrNull<TrafficEndpoint>(
        offset,
        TrafficEndpointSchema.deserialize,
        allOffsets,
      )) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 7:
      return (reader.readDouble(offset)) as P;
    case 8:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 9:
      return (reader.readDouble(offset)) as P;
    case 10:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 11:
      return (reader.readDouble(offset)) as P;
    case 12:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 13:
      return (reader.readDouble(offset)) as P;
    case 14:
      return (reader.readStringOrNull(offset)) as P;
    case 15:
      return (reader.readLongOrNull(offset) ?? 1) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension TrafficConnectionQueryFilter
    on QueryBuilder<TrafficConnection, TrafficConnection, QFilterCondition> {
  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      bytesAvgEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bytesAvg',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      bytesAvgGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bytesAvg',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      bytesAvgLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bytesAvg',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      bytesAvgBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bytesAvg',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      bytesTotalEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bytesTotal',
        value: value,
      ));
    });
  }

  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      bytesTotalGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bytesTotal',
        value: value,
      ));
    });
  }

  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      bytesTotalLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bytesTotal',
        value: value,
      ));
    });
  }

  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      bytesTotalBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bytesTotal',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      countAvgEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'countAvg',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      countAvgGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'countAvg',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      countAvgLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'countAvg',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      countAvgBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'countAvg',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      countTotalEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'countTotal',
        value: value,
      ));
    });
  }

  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      countTotalGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'countTotal',
        value: value,
      ));
    });
  }

  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      countTotalLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'countTotal',
        value: value,
      ));
    });
  }

  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      countTotalBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'countTotal',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      endpointIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'endpoint',
      ));
    });
  }

  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      endpointIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'endpoint',
      ));
    });
  }

  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      flowEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'flow',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      flowGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'flow',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      flowLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'flow',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      flowBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'flow',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      flowStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'flow',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      flowEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'flow',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      flowContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'flow',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      flowMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'flow',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      flowIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'flow',
        value: '',
      ));
    });
  }

  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      flowIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'flow',
        value: '',
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
      inBytesAvgEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'inBytesAvg',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      inBytesAvgGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'inBytesAvg',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      inBytesAvgLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'inBytesAvg',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      inBytesAvgBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'inBytesAvg',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
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
      inCountAvgEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'inCountAvg',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      inCountAvgGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'inCountAvg',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      inCountAvgLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'inCountAvg',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      inCountAvgBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'inCountAvg',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
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
      outBytesAvgEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'outBytesAvg',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      outBytesAvgGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'outBytesAvg',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      outBytesAvgLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'outBytesAvg',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      outBytesAvgBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'outBytesAvg',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
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
      outCountAvgEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'outCountAvg',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      outCountAvgGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'outCountAvg',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      outCountAvgLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'outCountAvg',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      outCountAvgBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'outCountAvg',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
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

  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      testRunCountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'testRunCount',
        value: value,
      ));
    });
  }

  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      testRunCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'testRunCount',
        value: value,
      ));
    });
  }

  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      testRunCountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'testRunCount',
        value: value,
      ));
    });
  }

  QueryBuilder<TrafficConnection, TrafficConnection, QAfterFilterCondition>
      testRunCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'testRunCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
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
