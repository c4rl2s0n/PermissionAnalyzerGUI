// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_run.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTestRunCollection on Isar {
  IsarCollection<TestRun> get testRuns => this.collection();
}

const TestRunSchema = CollectionSchema(
  name: r'TestRun',
  id: -4042852072460897997,
  properties: {
    r'connections': PropertySchema(
      id: 0,
      name: r'connections',
      type: IsarType.objectList,
      target: r'NetworkConnection',
    ),
    r'durationInMs': PropertySchema(
      id: 1,
      name: r'durationInMs',
      type: IsarType.long,
    ),
    r'hasData': PropertySchema(
      id: 2,
      name: r'hasData',
      type: IsarType.bool,
    ),
    r'index': PropertySchema(
      id: 3,
      name: r'index',
      type: IsarType.long,
    ),
    r'packets': PropertySchema(
      id: 4,
      name: r'packets',
      type: IsarType.objectList,
      target: r'NetworkPacket',
    ),
    r'pcapPath': PropertySchema(
      id: 5,
      name: r'pcapPath',
      type: IsarType.string,
    ),
    r'screenRecordPath': PropertySchema(
      id: 6,
      name: r'screenRecordPath',
      type: IsarType.string,
    ),
    r'startTimeInMs': PropertySchema(
      id: 7,
      name: r'startTimeInMs',
      type: IsarType.long,
    )
  },
  estimateSize: _testRunEstimateSize,
  serialize: _testRunSerialize,
  deserialize: _testRunDeserialize,
  deserializeProp: _testRunDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {
    r'NetworkPacket': NetworkPacketSchema,
    r'NetworkConnection': NetworkConnectionSchema
  },
  getId: _testRunGetId,
  getLinks: _testRunGetLinks,
  attach: _testRunAttach,
  version: '3.1.8',
);

int _testRunEstimateSize(
  TestRun object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.connections.length * 3;
  {
    final offsets = allOffsets[NetworkConnection]!;
    for (var i = 0; i < object.connections.length; i++) {
      final value = object.connections[i];
      bytesCount +=
          NetworkConnectionSchema.estimateSize(value, offsets, allOffsets);
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
  writer.writeObjectList<NetworkConnection>(
    offsets[0],
    allOffsets,
    NetworkConnectionSchema.serialize,
    object.connections,
  );
  writer.writeLong(offsets[1], object.durationInMs);
  writer.writeBool(offsets[2], object.hasData);
  writer.writeLong(offsets[3], object.index);
  writer.writeObjectList<NetworkPacket>(
    offsets[4],
    allOffsets,
    NetworkPacketSchema.serialize,
    object.packets,
  );
  writer.writeString(offsets[5], object.pcapPath);
  writer.writeString(offsets[6], object.screenRecordPath);
  writer.writeLong(offsets[7], object.startTimeInMs);
}

TestRun _testRunDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TestRun(
    connections: reader.readObjectList<NetworkConnection>(
          offsets[0],
          NetworkConnectionSchema.deserialize,
          allOffsets,
          NetworkConnection(),
        ) ??
        const [],
    durationInMs: reader.readLongOrNull(offsets[1]) ?? 0,
    index: reader.readLongOrNull(offsets[3]) ?? 0,
    packets: reader.readObjectList<NetworkPacket>(
          offsets[4],
          NetworkPacketSchema.deserialize,
          allOffsets,
          NetworkPacket(),
        ) ??
        const [],
    pcapPath: reader.readStringOrNull(offsets[5]),
    screenRecordPath: reader.readStringOrNull(offsets[6]),
    startTimeInMs: reader.readLongOrNull(offsets[7]) ?? 0,
  );
  object.id = id;
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
      return (reader.readObjectList<NetworkConnection>(
            offset,
            NetworkConnectionSchema.deserialize,
            allOffsets,
            NetworkConnection(),
          ) ??
          const []) as P;
    case 1:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 4:
      return (reader.readObjectList<NetworkPacket>(
            offset,
            NetworkPacketSchema.deserialize,
            allOffsets,
            NetworkPacket(),
          ) ??
          const []) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _testRunGetId(TestRun object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _testRunGetLinks(TestRun object) {
  return [];
}

void _testRunAttach(IsarCollection<dynamic> col, Id id, TestRun object) {
  object.id = id;
}

extension TestRunQueryWhereSort on QueryBuilder<TestRun, TestRun, QWhere> {
  QueryBuilder<TestRun, TestRun, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension TestRunQueryWhere on QueryBuilder<TestRun, TestRun, QWhereClause> {
  QueryBuilder<TestRun, TestRun, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<TestRun, TestRun, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<TestRun, TestRun, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<TestRun, TestRun, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<TestRun, TestRun, QAfterWhereClause> idBetween(
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

  QueryBuilder<TestRun, TestRun, QAfterFilterCondition> durationInMsEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'durationInMs',
        value: value,
      ));
    });
  }

  QueryBuilder<TestRun, TestRun, QAfterFilterCondition> durationInMsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'durationInMs',
        value: value,
      ));
    });
  }

  QueryBuilder<TestRun, TestRun, QAfterFilterCondition> durationInMsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'durationInMs',
        value: value,
      ));
    });
  }

  QueryBuilder<TestRun, TestRun, QAfterFilterCondition> durationInMsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'durationInMs',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
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

  QueryBuilder<TestRun, TestRun, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TestRun, TestRun, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<TestRun, TestRun, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<TestRun, TestRun, QAfterFilterCondition> idBetween(
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

  QueryBuilder<TestRun, TestRun, QAfterFilterCondition> indexEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'index',
        value: value,
      ));
    });
  }

  QueryBuilder<TestRun, TestRun, QAfterFilterCondition> indexGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'index',
        value: value,
      ));
    });
  }

  QueryBuilder<TestRun, TestRun, QAfterFilterCondition> indexLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'index',
        value: value,
      ));
    });
  }

  QueryBuilder<TestRun, TestRun, QAfterFilterCondition> indexBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'index',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
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

  QueryBuilder<TestRun, TestRun, QAfterFilterCondition> startTimeInMsEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'startTimeInMs',
        value: value,
      ));
    });
  }

  QueryBuilder<TestRun, TestRun, QAfterFilterCondition>
      startTimeInMsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'startTimeInMs',
        value: value,
      ));
    });
  }

  QueryBuilder<TestRun, TestRun, QAfterFilterCondition> startTimeInMsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'startTimeInMs',
        value: value,
      ));
    });
  }

  QueryBuilder<TestRun, TestRun, QAfterFilterCondition> startTimeInMsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'startTimeInMs',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension TestRunQueryObject
    on QueryBuilder<TestRun, TestRun, QFilterCondition> {
  QueryBuilder<TestRun, TestRun, QAfterFilterCondition> connectionsElement(
      FilterQuery<NetworkConnection> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'connections');
    });
  }

  QueryBuilder<TestRun, TestRun, QAfterFilterCondition> packetsElement(
      FilterQuery<NetworkPacket> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'packets');
    });
  }
}

extension TestRunQueryLinks
    on QueryBuilder<TestRun, TestRun, QFilterCondition> {}

extension TestRunQuerySortBy on QueryBuilder<TestRun, TestRun, QSortBy> {
  QueryBuilder<TestRun, TestRun, QAfterSortBy> sortByDurationInMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationInMs', Sort.asc);
    });
  }

  QueryBuilder<TestRun, TestRun, QAfterSortBy> sortByDurationInMsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationInMs', Sort.desc);
    });
  }

  QueryBuilder<TestRun, TestRun, QAfterSortBy> sortByHasData() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasData', Sort.asc);
    });
  }

  QueryBuilder<TestRun, TestRun, QAfterSortBy> sortByHasDataDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasData', Sort.desc);
    });
  }

  QueryBuilder<TestRun, TestRun, QAfterSortBy> sortByIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'index', Sort.asc);
    });
  }

  QueryBuilder<TestRun, TestRun, QAfterSortBy> sortByIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'index', Sort.desc);
    });
  }

  QueryBuilder<TestRun, TestRun, QAfterSortBy> sortByPcapPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pcapPath', Sort.asc);
    });
  }

  QueryBuilder<TestRun, TestRun, QAfterSortBy> sortByPcapPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pcapPath', Sort.desc);
    });
  }

  QueryBuilder<TestRun, TestRun, QAfterSortBy> sortByScreenRecordPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'screenRecordPath', Sort.asc);
    });
  }

  QueryBuilder<TestRun, TestRun, QAfterSortBy> sortByScreenRecordPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'screenRecordPath', Sort.desc);
    });
  }

  QueryBuilder<TestRun, TestRun, QAfterSortBy> sortByStartTimeInMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTimeInMs', Sort.asc);
    });
  }

  QueryBuilder<TestRun, TestRun, QAfterSortBy> sortByStartTimeInMsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTimeInMs', Sort.desc);
    });
  }
}

extension TestRunQuerySortThenBy
    on QueryBuilder<TestRun, TestRun, QSortThenBy> {
  QueryBuilder<TestRun, TestRun, QAfterSortBy> thenByDurationInMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationInMs', Sort.asc);
    });
  }

  QueryBuilder<TestRun, TestRun, QAfterSortBy> thenByDurationInMsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationInMs', Sort.desc);
    });
  }

  QueryBuilder<TestRun, TestRun, QAfterSortBy> thenByHasData() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasData', Sort.asc);
    });
  }

  QueryBuilder<TestRun, TestRun, QAfterSortBy> thenByHasDataDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasData', Sort.desc);
    });
  }

  QueryBuilder<TestRun, TestRun, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<TestRun, TestRun, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<TestRun, TestRun, QAfterSortBy> thenByIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'index', Sort.asc);
    });
  }

  QueryBuilder<TestRun, TestRun, QAfterSortBy> thenByIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'index', Sort.desc);
    });
  }

  QueryBuilder<TestRun, TestRun, QAfterSortBy> thenByPcapPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pcapPath', Sort.asc);
    });
  }

  QueryBuilder<TestRun, TestRun, QAfterSortBy> thenByPcapPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pcapPath', Sort.desc);
    });
  }

  QueryBuilder<TestRun, TestRun, QAfterSortBy> thenByScreenRecordPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'screenRecordPath', Sort.asc);
    });
  }

  QueryBuilder<TestRun, TestRun, QAfterSortBy> thenByScreenRecordPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'screenRecordPath', Sort.desc);
    });
  }

  QueryBuilder<TestRun, TestRun, QAfterSortBy> thenByStartTimeInMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTimeInMs', Sort.asc);
    });
  }

  QueryBuilder<TestRun, TestRun, QAfterSortBy> thenByStartTimeInMsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTimeInMs', Sort.desc);
    });
  }
}

extension TestRunQueryWhereDistinct
    on QueryBuilder<TestRun, TestRun, QDistinct> {
  QueryBuilder<TestRun, TestRun, QDistinct> distinctByDurationInMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'durationInMs');
    });
  }

  QueryBuilder<TestRun, TestRun, QDistinct> distinctByHasData() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hasData');
    });
  }

  QueryBuilder<TestRun, TestRun, QDistinct> distinctByIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'index');
    });
  }

  QueryBuilder<TestRun, TestRun, QDistinct> distinctByPcapPath(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pcapPath', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TestRun, TestRun, QDistinct> distinctByScreenRecordPath(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'screenRecordPath',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TestRun, TestRun, QDistinct> distinctByStartTimeInMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'startTimeInMs');
    });
  }
}

extension TestRunQueryProperty
    on QueryBuilder<TestRun, TestRun, QQueryProperty> {
  QueryBuilder<TestRun, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<TestRun, List<NetworkConnection>, QQueryOperations>
      connectionsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'connections');
    });
  }

  QueryBuilder<TestRun, int, QQueryOperations> durationInMsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'durationInMs');
    });
  }

  QueryBuilder<TestRun, bool, QQueryOperations> hasDataProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hasData');
    });
  }

  QueryBuilder<TestRun, int, QQueryOperations> indexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'index');
    });
  }

  QueryBuilder<TestRun, List<NetworkPacket>, QQueryOperations>
      packetsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'packets');
    });
  }

  QueryBuilder<TestRun, String?, QQueryOperations> pcapPathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pcapPath');
    });
  }

  QueryBuilder<TestRun, String?, QQueryOperations> screenRecordPathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'screenRecordPath');
    });
  }

  QueryBuilder<TestRun, int, QQueryOperations> startTimeInMsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'startTimeInMs');
    });
  }
}
