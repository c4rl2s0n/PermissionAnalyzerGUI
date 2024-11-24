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
    r'abbreviation': PropertySchema(
      id: 0,
      name: r'abbreviation',
      type: IsarType.string,
    ),
    r'permissions': PropertySchema(
      id: 1,
      name: r'permissions',
      type: IsarType.objectList,
      target: r'PermissionSetting',
    ),
    r'tests': PropertySchema(
      id: 2,
      name: r'tests',
      type: IsarType.objectList,
      target: r'TestRun',
    ),
    r'trafficGroup': PropertySchema(
      id: 3,
      name: r'trafficGroup',
      type: IsarType.object,
      target: r'TrafficGroup',
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
  bytesCount += 3 + object.abbreviation.length * 3;
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
  {
    final value = object.trafficGroup;
    if (value != null) {
      bytesCount += 3 +
          TrafficGroupSchema.estimateSize(
              value, allOffsets[TrafficGroup]!, allOffsets);
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
  writer.writeString(offsets[0], object.abbreviation);
  writer.writeObjectList<PermissionSetting>(
    offsets[1],
    allOffsets,
    PermissionSettingSchema.serialize,
    object.permissions,
  );
  writer.writeObjectList<TestRun>(
    offsets[2],
    allOffsets,
    TestRunSchema.serialize,
    object.tests,
  );
  writer.writeObject<TrafficGroup>(
    offsets[3],
    allOffsets,
    TrafficGroupSchema.serialize,
    object.trafficGroup,
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
          offsets[1],
          PermissionSettingSchema.deserialize,
          allOffsets,
          PermissionSetting(),
        ) ??
        const [],
    tests: reader.readObjectList<TestRun>(
          offsets[2],
          TestRunSchema.deserialize,
          allOffsets,
          TestRun(),
        ) ??
        const [],
    trafficGroup: reader.readObjectOrNull<TrafficGroup>(
      offsets[3],
      TrafficGroupSchema.deserialize,
      allOffsets,
    ),
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
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readObjectList<PermissionSetting>(
            offset,
            PermissionSettingSchema.deserialize,
            allOffsets,
            PermissionSetting(),
          ) ??
          const []) as P;
    case 2:
      return (reader.readObjectList<TestRun>(
            offset,
            TestRunSchema.deserialize,
            allOffsets,
            TestRun(),
          ) ??
          const []) as P;
    case 3:
      return (reader.readObjectOrNull<TrafficGroup>(
        offset,
        TrafficGroupSchema.deserialize,
        allOffsets,
      )) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension TestConstellationQueryFilter
    on QueryBuilder<TestConstellation, TestConstellation, QFilterCondition> {
  QueryBuilder<TestConstellation, TestConstellation, QAfterFilterCondition>
      abbreviationEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'abbreviation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestConstellation, TestConstellation, QAfterFilterCondition>
      abbreviationGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'abbreviation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestConstellation, TestConstellation, QAfterFilterCondition>
      abbreviationLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'abbreviation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestConstellation, TestConstellation, QAfterFilterCondition>
      abbreviationBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'abbreviation',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestConstellation, TestConstellation, QAfterFilterCondition>
      abbreviationStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'abbreviation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestConstellation, TestConstellation, QAfterFilterCondition>
      abbreviationEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'abbreviation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestConstellation, TestConstellation, QAfterFilterCondition>
      abbreviationContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'abbreviation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestConstellation, TestConstellation, QAfterFilterCondition>
      abbreviationMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'abbreviation',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestConstellation, TestConstellation, QAfterFilterCondition>
      abbreviationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'abbreviation',
        value: '',
      ));
    });
  }

  QueryBuilder<TestConstellation, TestConstellation, QAfterFilterCondition>
      abbreviationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'abbreviation',
        value: '',
      ));
    });
  }

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
      trafficGroupIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'trafficGroup',
      ));
    });
  }

  QueryBuilder<TestConstellation, TestConstellation, QAfterFilterCondition>
      trafficGroupIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'trafficGroup',
      ));
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
      trafficGroup(FilterQuery<TrafficGroup> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'trafficGroup');
    });
  }
}
