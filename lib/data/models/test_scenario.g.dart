// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_scenario.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTestScenarioCollection on Isar {
  IsarCollection<TestScenario> get testScenarios => this.collection();
}

const TestScenarioSchema = CollectionSchema(
  name: r'TestScenario',
  id: 5064110888938082989,
  properties: {
    r'applicationId': PropertySchema(
      id: 0,
      name: r'applicationId',
      type: IsarType.string,
    ),
    r'applicationName': PropertySchema(
      id: 1,
      name: r'applicationName',
      type: IsarType.string,
    ),
    r'captureTraffic': PropertySchema(
      id: 2,
      name: r'captureTraffic',
      type: IsarType.bool,
    ),
    r'device': PropertySchema(
      id: 3,
      name: r'device',
      type: IsarType.string,
    ),
    r'deviceInput': PropertySchema(
      id: 4,
      name: r'deviceInput',
      type: IsarType.object,
      target: r'AndroidInputDevice',
    ),
    r'durationInSeconds': PropertySchema(
      id: 5,
      name: r'durationInSeconds',
      type: IsarType.long,
    ),
    r'fileDirectory': PropertySchema(
      id: 6,
      name: r'fileDirectory',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 7,
      name: r'name',
      type: IsarType.string,
    ),
    r'networkInterface': PropertySchema(
      id: 8,
      name: r'networkInterface',
      type: IsarType.object,
      target: r'TsharkNetworkInterface',
    ),
    r'numTestRuns': PropertySchema(
      id: 9,
      name: r'numTestRuns',
      type: IsarType.long,
    ),
    r'permissions': PropertySchema(
      id: 10,
      name: r'permissions',
      type: IsarType.objectList,
      target: r'PermissionSetting',
    ),
    r'recordScreen': PropertySchema(
      id: 11,
      name: r'recordScreen',
      type: IsarType.bool,
    ),
    r'testConstellations': PropertySchema(
      id: 12,
      name: r'testConstellations',
      type: IsarType.objectList,
      target: r'TestConstellation',
    ),
    r'userInputRecord': PropertySchema(
      id: 13,
      name: r'userInputRecord',
      type: IsarType.string,
    )
  },
  estimateSize: _testScenarioEstimateSize,
  serialize: _testScenarioSerialize,
  deserialize: _testScenarioDeserialize,
  deserializeProp: _testScenarioDeserializeProp,
  idName: r'id',
  indexes: {
    r'applicationId': IndexSchema(
      id: -6637474116175318442,
      name: r'applicationId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'applicationId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {
    r'AndroidInputDevice': AndroidInputDeviceSchema,
    r'TsharkNetworkInterface': TsharkNetworkInterfaceSchema,
    r'PermissionSetting': PermissionSettingSchema,
    r'TestConstellation': TestConstellationSchema,
    r'TestRun': TestRunSchema,
    r'NetworkPacket': NetworkPacketSchema,
    r'TrafficEndpoint': TrafficEndpointSchema,
    r'TrafficConnection': TrafficConnectionSchema,
    r'TrafficGroup': TrafficGroupSchema
  },
  getId: _testScenarioGetId,
  getLinks: _testScenarioGetLinks,
  attach: _testScenarioAttach,
  version: '3.1.8',
);

int _testScenarioEstimateSize(
  TestScenario object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.applicationId.length * 3;
  bytesCount += 3 + object.applicationName.length * 3;
  bytesCount += 3 + object.device.length * 3;
  bytesCount += 3 +
      AndroidInputDeviceSchema.estimateSize(
          object.deviceInput, allOffsets[AndroidInputDevice]!, allOffsets);
  bytesCount += 3 + object.fileDirectory.length * 3;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 +
      TsharkNetworkInterfaceSchema.estimateSize(object.networkInterface,
          allOffsets[TsharkNetworkInterface]!, allOffsets);
  bytesCount += 3 + object.permissions.length * 3;
  {
    final offsets = allOffsets[PermissionSetting]!;
    for (var i = 0; i < object.permissions.length; i++) {
      final value = object.permissions[i];
      bytesCount +=
          PermissionSettingSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  bytesCount += 3 + object.testConstellations.length * 3;
  {
    final offsets = allOffsets[TestConstellation]!;
    for (var i = 0; i < object.testConstellations.length; i++) {
      final value = object.testConstellations[i];
      bytesCount +=
          TestConstellationSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  bytesCount += 3 + object.userInputRecord.length * 3;
  return bytesCount;
}

void _testScenarioSerialize(
  TestScenario object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.applicationId);
  writer.writeString(offsets[1], object.applicationName);
  writer.writeBool(offsets[2], object.captureTraffic);
  writer.writeString(offsets[3], object.device);
  writer.writeObject<AndroidInputDevice>(
    offsets[4],
    allOffsets,
    AndroidInputDeviceSchema.serialize,
    object.deviceInput,
  );
  writer.writeLong(offsets[5], object.durationInSeconds);
  writer.writeString(offsets[6], object.fileDirectory);
  writer.writeString(offsets[7], object.name);
  writer.writeObject<TsharkNetworkInterface>(
    offsets[8],
    allOffsets,
    TsharkNetworkInterfaceSchema.serialize,
    object.networkInterface,
  );
  writer.writeLong(offsets[9], object.numTestRuns);
  writer.writeObjectList<PermissionSetting>(
    offsets[10],
    allOffsets,
    PermissionSettingSchema.serialize,
    object.permissions,
  );
  writer.writeBool(offsets[11], object.recordScreen);
  writer.writeObjectList<TestConstellation>(
    offsets[12],
    allOffsets,
    TestConstellationSchema.serialize,
    object.testConstellations,
  );
  writer.writeString(offsets[13], object.userInputRecord);
}

TestScenario _testScenarioDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TestScenario(
    applicationId: reader.readStringOrNull(offsets[0]) ?? "",
    applicationName: reader.readStringOrNull(offsets[1]) ?? "",
    captureTraffic: reader.readBoolOrNull(offsets[2]) ?? true,
    device: reader.readStringOrNull(offsets[3]) ?? "",
    deviceInput: reader.readObjectOrNull<AndroidInputDevice>(
          offsets[4],
          AndroidInputDeviceSchema.deserialize,
          allOffsets,
        ) ??
        const AndroidInputDevice(),
    durationInSeconds: reader.readLongOrNull(offsets[5]) ?? 60,
    fileDirectory: reader.readStringOrNull(offsets[6]) ?? "",
    name: reader.readStringOrNull(offsets[7]) ?? "",
    networkInterface: reader.readObjectOrNull<TsharkNetworkInterface>(
          offsets[8],
          TsharkNetworkInterfaceSchema.deserialize,
          allOffsets,
        ) ??
        const TsharkNetworkInterface(),
    numTestRuns: reader.readLongOrNull(offsets[9]) ?? 1,
    permissions: reader.readObjectList<PermissionSetting>(
          offsets[10],
          PermissionSettingSchema.deserialize,
          allOffsets,
          PermissionSetting(),
        ) ??
        const [],
    recordScreen: reader.readBoolOrNull(offsets[11]) ?? true,
    testConstellations: reader.readObjectList<TestConstellation>(
          offsets[12],
          TestConstellationSchema.deserialize,
          allOffsets,
          TestConstellation(),
        ) ??
        const [],
    userInputRecord: reader.readStringOrNull(offsets[13]) ?? "",
  );
  object.id = id;
  return object;
}

P _testScenarioDeserializeProp<P>(
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
      return (reader.readBoolOrNull(offset) ?? true) as P;
    case 3:
      return (reader.readStringOrNull(offset) ?? "") as P;
    case 4:
      return (reader.readObjectOrNull<AndroidInputDevice>(
            offset,
            AndroidInputDeviceSchema.deserialize,
            allOffsets,
          ) ??
          const AndroidInputDevice()) as P;
    case 5:
      return (reader.readLongOrNull(offset) ?? 60) as P;
    case 6:
      return (reader.readStringOrNull(offset) ?? "") as P;
    case 7:
      return (reader.readStringOrNull(offset) ?? "") as P;
    case 8:
      return (reader.readObjectOrNull<TsharkNetworkInterface>(
            offset,
            TsharkNetworkInterfaceSchema.deserialize,
            allOffsets,
          ) ??
          const TsharkNetworkInterface()) as P;
    case 9:
      return (reader.readLongOrNull(offset) ?? 1) as P;
    case 10:
      return (reader.readObjectList<PermissionSetting>(
            offset,
            PermissionSettingSchema.deserialize,
            allOffsets,
            PermissionSetting(),
          ) ??
          const []) as P;
    case 11:
      return (reader.readBoolOrNull(offset) ?? true) as P;
    case 12:
      return (reader.readObjectList<TestConstellation>(
            offset,
            TestConstellationSchema.deserialize,
            allOffsets,
            TestConstellation(),
          ) ??
          const []) as P;
    case 13:
      return (reader.readStringOrNull(offset) ?? "") as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _testScenarioGetId(TestScenario object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _testScenarioGetLinks(TestScenario object) {
  return [];
}

void _testScenarioAttach(
    IsarCollection<dynamic> col, Id id, TestScenario object) {
  object.id = id;
}

extension TestScenarioQueryWhereSort
    on QueryBuilder<TestScenario, TestScenario, QWhere> {
  QueryBuilder<TestScenario, TestScenario, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension TestScenarioQueryWhere
    on QueryBuilder<TestScenario, TestScenario, QWhereClause> {
  QueryBuilder<TestScenario, TestScenario, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<TestScenario, TestScenario, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterWhereClause> idBetween(
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

  QueryBuilder<TestScenario, TestScenario, QAfterWhereClause>
      applicationIdEqualTo(String applicationId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'applicationId',
        value: [applicationId],
      ));
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterWhereClause>
      applicationIdNotEqualTo(String applicationId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'applicationId',
              lower: [],
              upper: [applicationId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'applicationId',
              lower: [applicationId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'applicationId',
              lower: [applicationId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'applicationId',
              lower: [],
              upper: [applicationId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension TestScenarioQueryFilter
    on QueryBuilder<TestScenario, TestScenario, QFilterCondition> {
  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition>
      applicationIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'applicationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition>
      applicationIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'applicationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition>
      applicationIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'applicationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition>
      applicationIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'applicationId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition>
      applicationIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'applicationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition>
      applicationIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'applicationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition>
      applicationIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'applicationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition>
      applicationIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'applicationId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition>
      applicationIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'applicationId',
        value: '',
      ));
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition>
      applicationIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'applicationId',
        value: '',
      ));
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition>
      applicationNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'applicationName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition>
      applicationNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'applicationName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition>
      applicationNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'applicationName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition>
      applicationNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'applicationName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition>
      applicationNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'applicationName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition>
      applicationNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'applicationName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition>
      applicationNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'applicationName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition>
      applicationNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'applicationName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition>
      applicationNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'applicationName',
        value: '',
      ));
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition>
      applicationNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'applicationName',
        value: '',
      ));
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition>
      captureTrafficEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'captureTraffic',
        value: value,
      ));
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition> deviceEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'device',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition>
      deviceGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'device',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition>
      deviceLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'device',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition> deviceBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'device',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition>
      deviceStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'device',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition>
      deviceEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'device',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition>
      deviceContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'device',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition> deviceMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'device',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition>
      deviceIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'device',
        value: '',
      ));
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition>
      deviceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'device',
        value: '',
      ));
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition>
      durationInSecondsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'durationInSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition>
      durationInSecondsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'durationInSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition>
      durationInSecondsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'durationInSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition>
      durationInSecondsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'durationInSeconds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition>
      fileDirectoryEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fileDirectory',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition>
      fileDirectoryGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fileDirectory',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition>
      fileDirectoryLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fileDirectory',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition>
      fileDirectoryBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fileDirectory',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition>
      fileDirectoryStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'fileDirectory',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition>
      fileDirectoryEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'fileDirectory',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition>
      fileDirectoryContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'fileDirectory',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition>
      fileDirectoryMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'fileDirectory',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition>
      fileDirectoryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fileDirectory',
        value: '',
      ));
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition>
      fileDirectoryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fileDirectory',
        value: '',
      ));
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition> idBetween(
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

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition>
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

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition> nameLessThan(
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

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition> nameBetween(
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

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition>
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

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition> nameEndsWith(
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

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition> nameContains(
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

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition> nameMatches(
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

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition>
      numTestRunsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'numTestRuns',
        value: value,
      ));
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition>
      numTestRunsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'numTestRuns',
        value: value,
      ));
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition>
      numTestRunsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'numTestRuns',
        value: value,
      ));
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition>
      numTestRunsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'numTestRuns',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition>
      permissionsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'permissions',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition>
      permissionsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'permissions',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition>
      permissionsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'permissions',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition>
      permissionsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'permissions',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition>
      permissionsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'permissions',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition>
      permissionsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'permissions',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition>
      recordScreenEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'recordScreen',
        value: value,
      ));
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition>
      testConstellationsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'testConstellations',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition>
      testConstellationsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'testConstellations',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition>
      testConstellationsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'testConstellations',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition>
      testConstellationsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'testConstellations',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition>
      testConstellationsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'testConstellations',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition>
      testConstellationsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'testConstellations',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition>
      userInputRecordEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userInputRecord',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition>
      userInputRecordGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'userInputRecord',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition>
      userInputRecordLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'userInputRecord',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition>
      userInputRecordBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'userInputRecord',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition>
      userInputRecordStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'userInputRecord',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition>
      userInputRecordEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'userInputRecord',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition>
      userInputRecordContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'userInputRecord',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition>
      userInputRecordMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'userInputRecord',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition>
      userInputRecordIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userInputRecord',
        value: '',
      ));
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition>
      userInputRecordIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'userInputRecord',
        value: '',
      ));
    });
  }
}

extension TestScenarioQueryObject
    on QueryBuilder<TestScenario, TestScenario, QFilterCondition> {
  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition> deviceInput(
      FilterQuery<AndroidInputDevice> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'deviceInput');
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition>
      networkInterface(FilterQuery<TsharkNetworkInterface> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'networkInterface');
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition>
      permissionsElement(FilterQuery<PermissionSetting> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'permissions');
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterFilterCondition>
      testConstellationsElement(FilterQuery<TestConstellation> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'testConstellations');
    });
  }
}

extension TestScenarioQueryLinks
    on QueryBuilder<TestScenario, TestScenario, QFilterCondition> {}

extension TestScenarioQuerySortBy
    on QueryBuilder<TestScenario, TestScenario, QSortBy> {
  QueryBuilder<TestScenario, TestScenario, QAfterSortBy> sortByApplicationId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'applicationId', Sort.asc);
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterSortBy>
      sortByApplicationIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'applicationId', Sort.desc);
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterSortBy>
      sortByApplicationName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'applicationName', Sort.asc);
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterSortBy>
      sortByApplicationNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'applicationName', Sort.desc);
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterSortBy>
      sortByCaptureTraffic() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'captureTraffic', Sort.asc);
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterSortBy>
      sortByCaptureTrafficDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'captureTraffic', Sort.desc);
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterSortBy> sortByDevice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'device', Sort.asc);
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterSortBy> sortByDeviceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'device', Sort.desc);
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterSortBy>
      sortByDurationInSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationInSeconds', Sort.asc);
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterSortBy>
      sortByDurationInSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationInSeconds', Sort.desc);
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterSortBy> sortByFileDirectory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileDirectory', Sort.asc);
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterSortBy>
      sortByFileDirectoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileDirectory', Sort.desc);
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterSortBy> sortByNumTestRuns() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numTestRuns', Sort.asc);
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterSortBy>
      sortByNumTestRunsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numTestRuns', Sort.desc);
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterSortBy> sortByRecordScreen() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recordScreen', Sort.asc);
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterSortBy>
      sortByRecordScreenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recordScreen', Sort.desc);
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterSortBy>
      sortByUserInputRecord() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userInputRecord', Sort.asc);
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterSortBy>
      sortByUserInputRecordDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userInputRecord', Sort.desc);
    });
  }
}

extension TestScenarioQuerySortThenBy
    on QueryBuilder<TestScenario, TestScenario, QSortThenBy> {
  QueryBuilder<TestScenario, TestScenario, QAfterSortBy> thenByApplicationId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'applicationId', Sort.asc);
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterSortBy>
      thenByApplicationIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'applicationId', Sort.desc);
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterSortBy>
      thenByApplicationName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'applicationName', Sort.asc);
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterSortBy>
      thenByApplicationNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'applicationName', Sort.desc);
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterSortBy>
      thenByCaptureTraffic() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'captureTraffic', Sort.asc);
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterSortBy>
      thenByCaptureTrafficDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'captureTraffic', Sort.desc);
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterSortBy> thenByDevice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'device', Sort.asc);
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterSortBy> thenByDeviceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'device', Sort.desc);
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterSortBy>
      thenByDurationInSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationInSeconds', Sort.asc);
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterSortBy>
      thenByDurationInSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationInSeconds', Sort.desc);
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterSortBy> thenByFileDirectory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileDirectory', Sort.asc);
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterSortBy>
      thenByFileDirectoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileDirectory', Sort.desc);
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterSortBy> thenByNumTestRuns() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numTestRuns', Sort.asc);
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterSortBy>
      thenByNumTestRunsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numTestRuns', Sort.desc);
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterSortBy> thenByRecordScreen() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recordScreen', Sort.asc);
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterSortBy>
      thenByRecordScreenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recordScreen', Sort.desc);
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterSortBy>
      thenByUserInputRecord() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userInputRecord', Sort.asc);
    });
  }

  QueryBuilder<TestScenario, TestScenario, QAfterSortBy>
      thenByUserInputRecordDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userInputRecord', Sort.desc);
    });
  }
}

extension TestScenarioQueryWhereDistinct
    on QueryBuilder<TestScenario, TestScenario, QDistinct> {
  QueryBuilder<TestScenario, TestScenario, QDistinct> distinctByApplicationId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'applicationId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TestScenario, TestScenario, QDistinct> distinctByApplicationName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'applicationName',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TestScenario, TestScenario, QDistinct>
      distinctByCaptureTraffic() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'captureTraffic');
    });
  }

  QueryBuilder<TestScenario, TestScenario, QDistinct> distinctByDevice(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'device', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TestScenario, TestScenario, QDistinct>
      distinctByDurationInSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'durationInSeconds');
    });
  }

  QueryBuilder<TestScenario, TestScenario, QDistinct> distinctByFileDirectory(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fileDirectory',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TestScenario, TestScenario, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TestScenario, TestScenario, QDistinct> distinctByNumTestRuns() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'numTestRuns');
    });
  }

  QueryBuilder<TestScenario, TestScenario, QDistinct> distinctByRecordScreen() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'recordScreen');
    });
  }

  QueryBuilder<TestScenario, TestScenario, QDistinct> distinctByUserInputRecord(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userInputRecord',
          caseSensitive: caseSensitive);
    });
  }
}

extension TestScenarioQueryProperty
    on QueryBuilder<TestScenario, TestScenario, QQueryProperty> {
  QueryBuilder<TestScenario, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<TestScenario, String, QQueryOperations> applicationIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'applicationId');
    });
  }

  QueryBuilder<TestScenario, String, QQueryOperations>
      applicationNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'applicationName');
    });
  }

  QueryBuilder<TestScenario, bool, QQueryOperations> captureTrafficProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'captureTraffic');
    });
  }

  QueryBuilder<TestScenario, String, QQueryOperations> deviceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'device');
    });
  }

  QueryBuilder<TestScenario, AndroidInputDevice, QQueryOperations>
      deviceInputProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'deviceInput');
    });
  }

  QueryBuilder<TestScenario, int, QQueryOperations>
      durationInSecondsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'durationInSeconds');
    });
  }

  QueryBuilder<TestScenario, String, QQueryOperations> fileDirectoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fileDirectory');
    });
  }

  QueryBuilder<TestScenario, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<TestScenario, TsharkNetworkInterface, QQueryOperations>
      networkInterfaceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'networkInterface');
    });
  }

  QueryBuilder<TestScenario, int, QQueryOperations> numTestRunsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'numTestRuns');
    });
  }

  QueryBuilder<TestScenario, List<PermissionSetting>, QQueryOperations>
      permissionsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'permissions');
    });
  }

  QueryBuilder<TestScenario, bool, QQueryOperations> recordScreenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'recordScreen');
    });
  }

  QueryBuilder<TestScenario, List<TestConstellation>, QQueryOperations>
      testConstellationsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'testConstellations');
    });
  }

  QueryBuilder<TestScenario, String, QQueryOperations>
      userInputRecordProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userInputRecord');
    });
  }
}
