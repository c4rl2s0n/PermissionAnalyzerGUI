// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network_connection.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const NetworkConnectionSchema = Schema(
  name: r'NetworkConnection',
  id: -919941398253619221,
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
    r'flow': PropertySchema(
      id: 4,
      name: r'flow',
      type: IsarType.string,
    ),
    r'hasServerName': PropertySchema(
      id: 5,
      name: r'hasServerName',
      type: IsarType.bool,
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
    r'ip': PropertySchema(
      id: 10,
      name: r'ip',
      type: IsarType.string,
    ),
    r'ips': PropertySchema(
      id: 11,
      name: r'ips',
      type: IsarType.stringList,
    ),
    r'outBytes': PropertySchema(
      id: 12,
      name: r'outBytes',
      type: IsarType.long,
    ),
    r'outBytesAvg': PropertySchema(
      id: 13,
      name: r'outBytesAvg',
      type: IsarType.double,
    ),
    r'outCount': PropertySchema(
      id: 14,
      name: r'outCount',
      type: IsarType.long,
    ),
    r'outCountAvg': PropertySchema(
      id: 15,
      name: r'outCountAvg',
      type: IsarType.double,
    ),
    r'packets': PropertySchema(
      id: 16,
      name: r'packets',
      type: IsarType.objectList,
      target: r'NetworkPacket',
    ),
    r'port': PropertySchema(
      id: 17,
      name: r'port',
      type: IsarType.long,
    ),
    r'ports': PropertySchema(
      id: 18,
      name: r'ports',
      type: IsarType.longList,
    ),
    r'protocols': PropertySchema(
      id: 19,
      name: r'protocols',
      type: IsarType.stringList,
    ),
    r'serverName': PropertySchema(
      id: 20,
      name: r'serverName',
      type: IsarType.string,
    ),
    r'serverNamesString': PropertySchema(
      id: 21,
      name: r'serverNamesString',
      type: IsarType.string,
    ),
    r'testRunCount': PropertySchema(
      id: 22,
      name: r'testRunCount',
      type: IsarType.long,
    ),
    r'wiresharkFilter': PropertySchema(
      id: 23,
      name: r'wiresharkFilter',
      type: IsarType.string,
    )
  },
  estimateSize: _networkConnectionEstimateSize,
  serialize: _networkConnectionSerialize,
  deserialize: _networkConnectionDeserialize,
  deserializeProp: _networkConnectionDeserializeProp,
);

int _networkConnectionEstimateSize(
  NetworkConnection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.flow.length * 3;
  bytesCount += 3 + object.ip.length * 3;
  bytesCount += 3 + object.ips.length * 3;
  {
    for (var i = 0; i < object.ips.length; i++) {
      final value = object.ips[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.packets.length * 3;
  {
    final offsets = allOffsets[NetworkPacket]!;
    for (var i = 0; i < object.packets.length; i++) {
      final value = object.packets[i];
      bytesCount +=
          NetworkPacketSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  bytesCount += 3 + object.ports.length * 8;
  bytesCount += 3 + object.protocols.length * 3;
  {
    for (var i = 0; i < object.protocols.length; i++) {
      final value = object.protocols[i];
      bytesCount += value.length * 3;
    }
  }
  {
    final value = object.serverName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.serverNamesString.length * 3;
  bytesCount += 3 + object.wiresharkFilter.length * 3;
  return bytesCount;
}

void _networkConnectionSerialize(
  NetworkConnection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.bytesAvg);
  writer.writeLong(offsets[1], object.bytesTotal);
  writer.writeDouble(offsets[2], object.countAvg);
  writer.writeLong(offsets[3], object.countTotal);
  writer.writeString(offsets[4], object.flow);
  writer.writeBool(offsets[5], object.hasServerName);
  writer.writeLong(offsets[6], object.inBytes);
  writer.writeDouble(offsets[7], object.inBytesAvg);
  writer.writeLong(offsets[8], object.inCount);
  writer.writeDouble(offsets[9], object.inCountAvg);
  writer.writeString(offsets[10], object.ip);
  writer.writeStringList(offsets[11], object.ips);
  writer.writeLong(offsets[12], object.outBytes);
  writer.writeDouble(offsets[13], object.outBytesAvg);
  writer.writeLong(offsets[14], object.outCount);
  writer.writeDouble(offsets[15], object.outCountAvg);
  writer.writeObjectList<NetworkPacket>(
    offsets[16],
    allOffsets,
    NetworkPacketSchema.serialize,
    object.packets,
  );
  writer.writeLong(offsets[17], object.port);
  writer.writeLongList(offsets[18], object.ports);
  writer.writeStringList(offsets[19], object.protocols);
  writer.writeString(offsets[20], object.serverName);
  writer.writeString(offsets[21], object.serverNamesString);
  writer.writeLong(offsets[22], object.testRunCount);
  writer.writeString(offsets[23], object.wiresharkFilter);
}

NetworkConnection _networkConnectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = NetworkConnection(
    ip: reader.readStringOrNull(offsets[10]) ?? "0.0.0.0",
    packets: reader.readObjectList<NetworkPacket>(
          offsets[16],
          NetworkPacketSchema.deserialize,
          allOffsets,
          NetworkPacket(),
        ) ??
        const [],
    port: reader.readLongOrNull(offsets[17]),
    serverName: reader.readStringOrNull(offsets[20]),
  );
  object.inBytes = reader.readLong(offsets[6]);
  object.inCount = reader.readLong(offsets[8]);
  object.outBytes = reader.readLong(offsets[12]);
  object.outCount = reader.readLong(offsets[14]);
  object.protocols = reader.readStringList(offsets[19]) ?? [];
  return object;
}

P _networkConnectionDeserializeProp<P>(
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
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readBool(offset)) as P;
    case 6:
      return (reader.readLong(offset)) as P;
    case 7:
      return (reader.readDouble(offset)) as P;
    case 8:
      return (reader.readLong(offset)) as P;
    case 9:
      return (reader.readDouble(offset)) as P;
    case 10:
      return (reader.readStringOrNull(offset) ?? "0.0.0.0") as P;
    case 11:
      return (reader.readStringList(offset) ?? []) as P;
    case 12:
      return (reader.readLong(offset)) as P;
    case 13:
      return (reader.readDouble(offset)) as P;
    case 14:
      return (reader.readLong(offset)) as P;
    case 15:
      return (reader.readDouble(offset)) as P;
    case 16:
      return (reader.readObjectList<NetworkPacket>(
            offset,
            NetworkPacketSchema.deserialize,
            allOffsets,
            NetworkPacket(),
          ) ??
          const []) as P;
    case 17:
      return (reader.readLongOrNull(offset)) as P;
    case 18:
      return (reader.readLongList(offset) ?? []) as P;
    case 19:
      return (reader.readStringList(offset) ?? []) as P;
    case 20:
      return (reader.readStringOrNull(offset)) as P;
    case 21:
      return (reader.readString(offset)) as P;
    case 22:
      return (reader.readLong(offset)) as P;
    case 23:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension NetworkConnectionQueryFilter
    on QueryBuilder<NetworkConnection, NetworkConnection, QFilterCondition> {
  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
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

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
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

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
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

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
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

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      bytesTotalEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bytesTotal',
        value: value,
      ));
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
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

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
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

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
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

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
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

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
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

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
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

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
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

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      countTotalEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'countTotal',
        value: value,
      ));
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
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

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
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

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
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

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
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

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
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

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
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

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
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

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
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

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
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

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      flowContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'flow',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      flowMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'flow',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      flowIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'flow',
        value: '',
      ));
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      flowIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'flow',
        value: '',
      ));
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      hasServerNameEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hasServerName',
        value: value,
      ));
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      inBytesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'inBytes',
        value: value,
      ));
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
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

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
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

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
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

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
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

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
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

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
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

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
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

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      inCountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'inCount',
        value: value,
      ));
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
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

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
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

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
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

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
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

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
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

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
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

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
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

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      ipEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ip',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      ipGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ip',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      ipLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ip',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      ipBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ip',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      ipStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'ip',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      ipEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'ip',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      ipContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'ip',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      ipMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'ip',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      ipIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ip',
        value: '',
      ));
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      ipIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'ip',
        value: '',
      ));
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      ipsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ips',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      ipsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ips',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      ipsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ips',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      ipsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ips',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      ipsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'ips',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      ipsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'ips',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      ipsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'ips',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      ipsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'ips',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      ipsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ips',
        value: '',
      ));
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      ipsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'ips',
        value: '',
      ));
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      ipsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ips',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      ipsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ips',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      ipsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ips',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      ipsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ips',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      ipsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ips',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      ipsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ips',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      outBytesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'outBytes',
        value: value,
      ));
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
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

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
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

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
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

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
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

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
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

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
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

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
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

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      outCountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'outCount',
        value: value,
      ));
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
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

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
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

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
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

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
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

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
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

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
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

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
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

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      packetsLengthEqualTo(int length) {
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

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      packetsIsEmpty() {
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

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      packetsIsNotEmpty() {
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

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      packetsLengthLessThan(
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

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
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

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      packetsLengthBetween(
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

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      portIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'port',
      ));
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      portIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'port',
      ));
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      portEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'port',
        value: value,
      ));
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      portGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'port',
        value: value,
      ));
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      portLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'port',
        value: value,
      ));
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      portBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'port',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      portsElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ports',
        value: value,
      ));
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      portsElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ports',
        value: value,
      ));
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      portsElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ports',
        value: value,
      ));
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      portsElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ports',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      portsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ports',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      portsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ports',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      portsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ports',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      portsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ports',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      portsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ports',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      portsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ports',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      protocolsElementEqualTo(
    String value, {
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

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      protocolsElementGreaterThan(
    String value, {
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

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      protocolsElementLessThan(
    String value, {
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

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      protocolsElementBetween(
    String lower,
    String upper, {
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

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      protocolsElementStartsWith(
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

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      protocolsElementEndsWith(
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

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      protocolsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'protocols',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      protocolsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'protocols',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      protocolsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'protocols',
        value: '',
      ));
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      protocolsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'protocols',
        value: '',
      ));
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      protocolsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'protocols',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      protocolsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'protocols',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      protocolsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'protocols',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      protocolsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'protocols',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      protocolsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'protocols',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      protocolsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'protocols',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      serverNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'serverName',
      ));
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      serverNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'serverName',
      ));
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      serverNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'serverName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      serverNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'serverName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      serverNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'serverName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      serverNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'serverName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      serverNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'serverName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      serverNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'serverName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      serverNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'serverName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      serverNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'serverName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      serverNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'serverName',
        value: '',
      ));
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      serverNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'serverName',
        value: '',
      ));
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      serverNamesStringEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'serverNamesString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      serverNamesStringGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'serverNamesString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      serverNamesStringLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'serverNamesString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      serverNamesStringBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'serverNamesString',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      serverNamesStringStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'serverNamesString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      serverNamesStringEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'serverNamesString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      serverNamesStringContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'serverNamesString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      serverNamesStringMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'serverNamesString',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      serverNamesStringIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'serverNamesString',
        value: '',
      ));
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      serverNamesStringIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'serverNamesString',
        value: '',
      ));
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      testRunCountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'testRunCount',
        value: value,
      ));
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
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

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
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

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
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

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      wiresharkFilterEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'wiresharkFilter',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      wiresharkFilterGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'wiresharkFilter',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      wiresharkFilterLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'wiresharkFilter',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      wiresharkFilterBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'wiresharkFilter',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      wiresharkFilterStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'wiresharkFilter',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      wiresharkFilterEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'wiresharkFilter',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      wiresharkFilterContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'wiresharkFilter',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      wiresharkFilterMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'wiresharkFilter',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      wiresharkFilterIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'wiresharkFilter',
        value: '',
      ));
    });
  }

  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      wiresharkFilterIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'wiresharkFilter',
        value: '',
      ));
    });
  }
}

extension NetworkConnectionQueryObject
    on QueryBuilder<NetworkConnection, NetworkConnection, QFilterCondition> {
  QueryBuilder<NetworkConnection, NetworkConnection, QAfterFilterCondition>
      packetsElement(FilterQuery<NetworkPacket> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'packets');
    });
  }
}
