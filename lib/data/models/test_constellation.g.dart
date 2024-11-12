// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_constellation.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const TestConstellationSchema = Schema(
  name: r'TestConstellation',
  id: -5871104126575400918,
  properties: {
    r'permissions': PropertySchema(
      id: 0,
      name: r'permissions',
      type: IsarType.objectList,
      target: r'PermissionSetting',
    ),
    r'tests': PropertySchema(
      id: 1,
      name: r'tests',
      type: IsarType.objectList,
      target: r'TestRun',
    ),
    r'trafficConnections': PropertySchema(
      id: 2,
      name: r'trafficConnections',
      type: IsarType.objectList,
      target: r'TrafficConnection',
    )
  },
  estimateSize: _testConstellationEstimateSize,
  serialize: _testConstellationSerialize,
  deserialize: _testConstellationDeserialize,
  deserializeProp: _testConstellationDeserializeProp,
);

int _testConstellationEstimateSize(
  TestConstellation object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.permissions.length * 3;
  {
    final offsets = allOffsets[PermissionSetting]!;
    for (var i = 0; i < object.permissions.length; i++) {
      final value = object.permissions[i];
      bytesCount +=
          PermissionSettingSchema.estimateSize(value, offsets, allOffsets);
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
  bytesCount += 3 + object.trafficConnections.length * 3;
  {
    final offsets = allOffsets[TrafficConnection]!;
    for (var i = 0; i < object.trafficConnections.length; i++) {
      final value = object.trafficConnections[i];
      bytesCount +=
          TrafficConnectionSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  return bytesCount;
}

void _testConstellationSerialize(
  TestConstellation object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObjectList<PermissionSetting>(
    offsets[0],
    allOffsets,
    PermissionSettingSchema.serialize,
    object.permissions,
  );
  writer.writeObjectList<TestRun>(
    offsets[1],
    allOffsets,
    TestRunSchema.serialize,
    object.tests,
  );
  writer.writeObjectList<TrafficConnection>(
    offsets[2],
    allOffsets,
    TrafficConnectionSchema.serialize,
    object.trafficConnections,
  );
}

TestConstellation _testConstellationDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TestConstellation(
    permissions: reader.readObjectList<PermissionSetting>(
          offsets[0],
          PermissionSettingSchema.deserialize,
          allOffsets,
          PermissionSetting(),
        ) ??
        const [],
    tests: reader.readObjectList<TestRun>(
          offsets[1],
          TestRunSchema.deserialize,
          allOffsets,
          TestRun(),
        ) ??
        const [],
  );
  return object;
}

P _testConstellationDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectList<PermissionSetting>(
            offset,
            PermissionSettingSchema.deserialize,
            allOffsets,
            PermissionSetting(),
          ) ??
          const []) as P;
    case 1:
      return (reader.readObjectList<TestRun>(
            offset,
            TestRunSchema.deserialize,
            allOffsets,
            TestRun(),
          ) ??
          const []) as P;
    case 2:
      return (reader.readObjectList<TrafficConnection>(
            offset,
            TrafficConnectionSchema.deserialize,
            allOffsets,
            TrafficConnection(),
          ) ??
          []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension TestConstellationQueryFilter
    on QueryBuilder<TestConstellation, TestConstellation, QFilterCondition> {
  QueryBuilder<TestConstellation, TestConstellation, QAfterFilterCondition>
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

  QueryBuilder<TestConstellation, TestConstellation, QAfterFilterCondition>
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

  QueryBuilder<TestConstellation, TestConstellation, QAfterFilterCondition>
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

  QueryBuilder<TestConstellation, TestConstellation, QAfterFilterCondition>
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

  QueryBuilder<TestConstellation, TestConstellation, QAfterFilterCondition>
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

  QueryBuilder<TestConstellation, TestConstellation, QAfterFilterCondition>
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

  QueryBuilder<TestConstellation, TestConstellation, QAfterFilterCondition>
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

  QueryBuilder<TestConstellation, TestConstellation, QAfterFilterCondition>
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

  QueryBuilder<TestConstellation, TestConstellation, QAfterFilterCondition>
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

  QueryBuilder<TestConstellation, TestConstellation, QAfterFilterCondition>
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

  QueryBuilder<TestConstellation, TestConstellation, QAfterFilterCondition>
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

  QueryBuilder<TestConstellation, TestConstellation, QAfterFilterCondition>
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

  QueryBuilder<TestConstellation, TestConstellation, QAfterFilterCondition>
      trafficConnectionsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'trafficConnections',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<TestConstellation, TestConstellation, QAfterFilterCondition>
      trafficConnectionsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'trafficConnections',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<TestConstellation, TestConstellation, QAfterFilterCondition>
      trafficConnectionsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'trafficConnections',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<TestConstellation, TestConstellation, QAfterFilterCondition>
      trafficConnectionsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'trafficConnections',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<TestConstellation, TestConstellation, QAfterFilterCondition>
      trafficConnectionsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'trafficConnections',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<TestConstellation, TestConstellation, QAfterFilterCondition>
      trafficConnectionsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'trafficConnections',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension TestConstellationQueryObject
    on QueryBuilder<TestConstellation, TestConstellation, QFilterCondition> {
  QueryBuilder<TestConstellation, TestConstellation, QAfterFilterCondition>
      permissionsElement(FilterQuery<PermissionSetting> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'permissions');
    });
  }

  QueryBuilder<TestConstellation, TestConstellation, QAfterFilterCondition>
      testsElement(FilterQuery<TestRun> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'tests');
    });
  }

  QueryBuilder<TestConstellation, TestConstellation, QAfterFilterCondition>
      trafficConnectionsElement(FilterQuery<TrafficConnection> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'trafficConnections');
    });
  }
}
