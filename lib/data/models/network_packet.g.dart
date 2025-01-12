// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network_packet.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const NetworkPacketSchema = Schema(
  name: r'NetworkPacket',
  id: -7884949800176198288,
  properties: {
    r'ipDst': PropertySchema(
      id: 0,
      name: r'ipDst',
      type: IsarType.string,
    ),
    r'ipSrc': PropertySchema(
      id: 1,
      name: r'ipSrc',
      type: IsarType.string,
    ),
    r'portDst': PropertySchema(
      id: 2,
      name: r'portDst',
      type: IsarType.long,
    ),
    r'portSrc': PropertySchema(
      id: 3,
      name: r'portSrc',
      type: IsarType.long,
    ),
    r'protocols': PropertySchema(
      id: 4,
      name: r'protocols',
      type: IsarType.string,
    ),
    r'serverName': PropertySchema(
      id: 5,
      name: r'serverName',
      type: IsarType.string,
    ),
    r'size': PropertySchema(
      id: 6,
      name: r'size',
      type: IsarType.long,
    ),
    r'timeInMs': PropertySchema(
      id: 7,
      name: r'timeInMs',
      type: IsarType.long,
    )
  },
  estimateSize: _networkPacketEstimateSize,
  serialize: _networkPacketSerialize,
  deserialize: _networkPacketDeserialize,
  deserializeProp: _networkPacketDeserializeProp,
);

int _networkPacketEstimateSize(
  NetworkPacket object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.ipDst.length * 3;
  bytesCount += 3 + object.ipSrc.length * 3;
  {
    final value = object.protocols;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.serverName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _networkPacketSerialize(
  NetworkPacket object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.ipDst);
  writer.writeString(offsets[1], object.ipSrc);
  writer.writeLong(offsets[2], object.portDst);
  writer.writeLong(offsets[3], object.portSrc);
  writer.writeString(offsets[4], object.protocols);
  writer.writeString(offsets[5], object.serverName);
  writer.writeLong(offsets[6], object.size);
  writer.writeLong(offsets[7], object.timeInMs);
}

NetworkPacket _networkPacketDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = NetworkPacket(
    ipDst: reader.readStringOrNull(offsets[0]) ?? "",
    ipSrc: reader.readStringOrNull(offsets[1]) ?? "",
    portDst: reader.readLongOrNull(offsets[2]),
    portSrc: reader.readLongOrNull(offsets[3]),
    protocols: reader.readStringOrNull(offsets[4]),
    serverName: reader.readStringOrNull(offsets[5]),
    size: reader.readLongOrNull(offsets[6]) ?? 0,
    timeInMs: reader.readLongOrNull(offsets[7]),
  );
  return object;
}

P _networkPacketDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset) ?? "") as P;
    case 1:
      return (reader.readStringOrNull(offset) ?? "") as P;
    case 2:
      return (reader.readLongOrNull(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 7:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension NetworkPacketQueryFilter
    on QueryBuilder<NetworkPacket, NetworkPacket, QFilterCondition> {
  QueryBuilder<NetworkPacket, NetworkPacket, QAfterFilterCondition>
      ipDstEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ipDst',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkPacket, NetworkPacket, QAfterFilterCondition>
      ipDstGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ipDst',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkPacket, NetworkPacket, QAfterFilterCondition>
      ipDstLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ipDst',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkPacket, NetworkPacket, QAfterFilterCondition>
      ipDstBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ipDst',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkPacket, NetworkPacket, QAfterFilterCondition>
      ipDstStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'ipDst',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkPacket, NetworkPacket, QAfterFilterCondition>
      ipDstEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'ipDst',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkPacket, NetworkPacket, QAfterFilterCondition>
      ipDstContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'ipDst',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkPacket, NetworkPacket, QAfterFilterCondition>
      ipDstMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'ipDst',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkPacket, NetworkPacket, QAfterFilterCondition>
      ipDstIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ipDst',
        value: '',
      ));
    });
  }

  QueryBuilder<NetworkPacket, NetworkPacket, QAfterFilterCondition>
      ipDstIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'ipDst',
        value: '',
      ));
    });
  }

  QueryBuilder<NetworkPacket, NetworkPacket, QAfterFilterCondition>
      ipSrcEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ipSrc',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkPacket, NetworkPacket, QAfterFilterCondition>
      ipSrcGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ipSrc',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkPacket, NetworkPacket, QAfterFilterCondition>
      ipSrcLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ipSrc',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkPacket, NetworkPacket, QAfterFilterCondition>
      ipSrcBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ipSrc',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkPacket, NetworkPacket, QAfterFilterCondition>
      ipSrcStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'ipSrc',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkPacket, NetworkPacket, QAfterFilterCondition>
      ipSrcEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'ipSrc',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkPacket, NetworkPacket, QAfterFilterCondition>
      ipSrcContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'ipSrc',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkPacket, NetworkPacket, QAfterFilterCondition>
      ipSrcMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'ipSrc',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkPacket, NetworkPacket, QAfterFilterCondition>
      ipSrcIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ipSrc',
        value: '',
      ));
    });
  }

  QueryBuilder<NetworkPacket, NetworkPacket, QAfterFilterCondition>
      ipSrcIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'ipSrc',
        value: '',
      ));
    });
  }

  QueryBuilder<NetworkPacket, NetworkPacket, QAfterFilterCondition>
      portDstIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'portDst',
      ));
    });
  }

  QueryBuilder<NetworkPacket, NetworkPacket, QAfterFilterCondition>
      portDstIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'portDst',
      ));
    });
  }

  QueryBuilder<NetworkPacket, NetworkPacket, QAfterFilterCondition>
      portDstEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'portDst',
        value: value,
      ));
    });
  }

  QueryBuilder<NetworkPacket, NetworkPacket, QAfterFilterCondition>
      portDstGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'portDst',
        value: value,
      ));
    });
  }

  QueryBuilder<NetworkPacket, NetworkPacket, QAfterFilterCondition>
      portDstLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'portDst',
        value: value,
      ));
    });
  }

  QueryBuilder<NetworkPacket, NetworkPacket, QAfterFilterCondition>
      portDstBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'portDst',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<NetworkPacket, NetworkPacket, QAfterFilterCondition>
      portSrcIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'portSrc',
      ));
    });
  }

  QueryBuilder<NetworkPacket, NetworkPacket, QAfterFilterCondition>
      portSrcIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'portSrc',
      ));
    });
  }

  QueryBuilder<NetworkPacket, NetworkPacket, QAfterFilterCondition>
      portSrcEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'portSrc',
        value: value,
      ));
    });
  }

  QueryBuilder<NetworkPacket, NetworkPacket, QAfterFilterCondition>
      portSrcGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'portSrc',
        value: value,
      ));
    });
  }

  QueryBuilder<NetworkPacket, NetworkPacket, QAfterFilterCondition>
      portSrcLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'portSrc',
        value: value,
      ));
    });
  }

  QueryBuilder<NetworkPacket, NetworkPacket, QAfterFilterCondition>
      portSrcBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'portSrc',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<NetworkPacket, NetworkPacket, QAfterFilterCondition>
      protocolsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'protocols',
      ));
    });
  }

  QueryBuilder<NetworkPacket, NetworkPacket, QAfterFilterCondition>
      protocolsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'protocols',
      ));
    });
  }

  QueryBuilder<NetworkPacket, NetworkPacket, QAfterFilterCondition>
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

  QueryBuilder<NetworkPacket, NetworkPacket, QAfterFilterCondition>
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

  QueryBuilder<NetworkPacket, NetworkPacket, QAfterFilterCondition>
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

  QueryBuilder<NetworkPacket, NetworkPacket, QAfterFilterCondition>
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

  QueryBuilder<NetworkPacket, NetworkPacket, QAfterFilterCondition>
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

  QueryBuilder<NetworkPacket, NetworkPacket, QAfterFilterCondition>
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

  QueryBuilder<NetworkPacket, NetworkPacket, QAfterFilterCondition>
      protocolsContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'protocols',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkPacket, NetworkPacket, QAfterFilterCondition>
      protocolsMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'protocols',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkPacket, NetworkPacket, QAfterFilterCondition>
      protocolsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'protocols',
        value: '',
      ));
    });
  }

  QueryBuilder<NetworkPacket, NetworkPacket, QAfterFilterCondition>
      protocolsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'protocols',
        value: '',
      ));
    });
  }

  QueryBuilder<NetworkPacket, NetworkPacket, QAfterFilterCondition>
      serverNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'serverName',
      ));
    });
  }

  QueryBuilder<NetworkPacket, NetworkPacket, QAfterFilterCondition>
      serverNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'serverName',
      ));
    });
  }

  QueryBuilder<NetworkPacket, NetworkPacket, QAfterFilterCondition>
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

  QueryBuilder<NetworkPacket, NetworkPacket, QAfterFilterCondition>
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

  QueryBuilder<NetworkPacket, NetworkPacket, QAfterFilterCondition>
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

  QueryBuilder<NetworkPacket, NetworkPacket, QAfterFilterCondition>
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

  QueryBuilder<NetworkPacket, NetworkPacket, QAfterFilterCondition>
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

  QueryBuilder<NetworkPacket, NetworkPacket, QAfterFilterCondition>
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

  QueryBuilder<NetworkPacket, NetworkPacket, QAfterFilterCondition>
      serverNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'serverName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkPacket, NetworkPacket, QAfterFilterCondition>
      serverNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'serverName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkPacket, NetworkPacket, QAfterFilterCondition>
      serverNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'serverName',
        value: '',
      ));
    });
  }

  QueryBuilder<NetworkPacket, NetworkPacket, QAfterFilterCondition>
      serverNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'serverName',
        value: '',
      ));
    });
  }

  QueryBuilder<NetworkPacket, NetworkPacket, QAfterFilterCondition> sizeEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'size',
        value: value,
      ));
    });
  }

  QueryBuilder<NetworkPacket, NetworkPacket, QAfterFilterCondition>
      sizeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'size',
        value: value,
      ));
    });
  }

  QueryBuilder<NetworkPacket, NetworkPacket, QAfterFilterCondition>
      sizeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'size',
        value: value,
      ));
    });
  }

  QueryBuilder<NetworkPacket, NetworkPacket, QAfterFilterCondition> sizeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'size',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<NetworkPacket, NetworkPacket, QAfterFilterCondition>
      timeInMsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'timeInMs',
      ));
    });
  }

  QueryBuilder<NetworkPacket, NetworkPacket, QAfterFilterCondition>
      timeInMsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'timeInMs',
      ));
    });
  }

  QueryBuilder<NetworkPacket, NetworkPacket, QAfterFilterCondition>
      timeInMsEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timeInMs',
        value: value,
      ));
    });
  }

  QueryBuilder<NetworkPacket, NetworkPacket, QAfterFilterCondition>
      timeInMsGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'timeInMs',
        value: value,
      ));
    });
  }

  QueryBuilder<NetworkPacket, NetworkPacket, QAfterFilterCondition>
      timeInMsLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'timeInMs',
        value: value,
      ));
    });
  }

  QueryBuilder<NetworkPacket, NetworkPacket, QAfterFilterCondition>
      timeInMsBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'timeInMs',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension NetworkPacketQueryObject
    on QueryBuilder<NetworkPacket, NetworkPacket, QFilterCondition> {}
