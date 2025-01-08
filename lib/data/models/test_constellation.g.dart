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
    r'blockedIPs': PropertySchema(
      id: 1,
      name: r'blockedIPs',
      type: IsarType.stringList,
    ),
    r'displayNameAppendix': PropertySchema(
      id: 2,
      name: r'displayNameAppendix',
      type: IsarType.string,
    ),
    r'permissions': PropertySchema(
      id: 3,
      name: r'permissions',
      type: IsarType.objectList,
      target: r'PermissionSetting',
    ),
    r'testIds': PropertySchema(
      id: 4,
      name: r'testIds',
      type: IsarType.longList,
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
  bytesCount += 3 + object.blockedIPs.length * 3;
  {
    for (var i = 0; i < object.blockedIPs.length; i++) {
      final value = object.blockedIPs[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.displayNameAppendix.length * 3;
  bytesCount += 3 + object.permissions.length * 3;
  {
    final offsets = allOffsets[PermissionSetting]!;
    for (var i = 0; i < object.permissions.length; i++) {
      final value = object.permissions[i];
      bytesCount +=
          PermissionSettingSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  bytesCount += 3 + object.testIds.length * 8;
  return bytesCount;
}

void _testConstellationSerialize(
  TestConstellation object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.abbreviation);
  writer.writeStringList(offsets[1], object.blockedIPs);
  writer.writeString(offsets[2], object.displayNameAppendix);
  writer.writeObjectList<PermissionSetting>(
    offsets[3],
    allOffsets,
    PermissionSettingSchema.serialize,
    object.permissions,
  );
  writer.writeLongList(offsets[4], object.testIds);
}

TestConstellation _testConstellationDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TestConstellation(
    blockedIPs: reader.readStringList(offsets[1]) ?? const [],
    displayNameAppendix: reader.readStringOrNull(offsets[2]) ?? "",
    permissions: reader.readObjectList<PermissionSetting>(
          offsets[3],
          PermissionSettingSchema.deserialize,
          allOffsets,
          PermissionSetting(),
        ) ??
        const [],
    testIds: reader.readLongList(offsets[4]) ?? const [],
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
      return (reader.readStringList(offset) ?? const []) as P;
    case 2:
      return (reader.readStringOrNull(offset) ?? "") as P;
    case 3:
      return (reader.readObjectList<PermissionSetting>(
            offset,
            PermissionSettingSchema.deserialize,
            allOffsets,
            PermissionSetting(),
          ) ??
          const []) as P;
    case 4:
      return (reader.readLongList(offset) ?? const []) as P;
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
      blockedIPsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'blockedIPs',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestConstellation, TestConstellation, QAfterFilterCondition>
      blockedIPsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'blockedIPs',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestConstellation, TestConstellation, QAfterFilterCondition>
      blockedIPsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'blockedIPs',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestConstellation, TestConstellation, QAfterFilterCondition>
      blockedIPsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'blockedIPs',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestConstellation, TestConstellation, QAfterFilterCondition>
      blockedIPsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'blockedIPs',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestConstellation, TestConstellation, QAfterFilterCondition>
      blockedIPsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'blockedIPs',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestConstellation, TestConstellation, QAfterFilterCondition>
      blockedIPsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'blockedIPs',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestConstellation, TestConstellation, QAfterFilterCondition>
      blockedIPsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'blockedIPs',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestConstellation, TestConstellation, QAfterFilterCondition>
      blockedIPsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'blockedIPs',
        value: '',
      ));
    });
  }

  QueryBuilder<TestConstellation, TestConstellation, QAfterFilterCondition>
      blockedIPsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'blockedIPs',
        value: '',
      ));
    });
  }

  QueryBuilder<TestConstellation, TestConstellation, QAfterFilterCondition>
      blockedIPsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'blockedIPs',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<TestConstellation, TestConstellation, QAfterFilterCondition>
      blockedIPsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'blockedIPs',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<TestConstellation, TestConstellation, QAfterFilterCondition>
      blockedIPsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'blockedIPs',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<TestConstellation, TestConstellation, QAfterFilterCondition>
      blockedIPsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'blockedIPs',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<TestConstellation, TestConstellation, QAfterFilterCondition>
      blockedIPsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'blockedIPs',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<TestConstellation, TestConstellation, QAfterFilterCondition>
      blockedIPsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'blockedIPs',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<TestConstellation, TestConstellation, QAfterFilterCondition>
      displayNameAppendixEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'displayNameAppendix',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestConstellation, TestConstellation, QAfterFilterCondition>
      displayNameAppendixGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'displayNameAppendix',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestConstellation, TestConstellation, QAfterFilterCondition>
      displayNameAppendixLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'displayNameAppendix',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestConstellation, TestConstellation, QAfterFilterCondition>
      displayNameAppendixBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'displayNameAppendix',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestConstellation, TestConstellation, QAfterFilterCondition>
      displayNameAppendixStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'displayNameAppendix',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestConstellation, TestConstellation, QAfterFilterCondition>
      displayNameAppendixEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'displayNameAppendix',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestConstellation, TestConstellation, QAfterFilterCondition>
      displayNameAppendixContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'displayNameAppendix',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestConstellation, TestConstellation, QAfterFilterCondition>
      displayNameAppendixMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'displayNameAppendix',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestConstellation, TestConstellation, QAfterFilterCondition>
      displayNameAppendixIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'displayNameAppendix',
        value: '',
      ));
    });
  }

  QueryBuilder<TestConstellation, TestConstellation, QAfterFilterCondition>
      displayNameAppendixIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'displayNameAppendix',
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
      testIdsElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'testIds',
        value: value,
      ));
    });
  }

  QueryBuilder<TestConstellation, TestConstellation, QAfterFilterCondition>
      testIdsElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'testIds',
        value: value,
      ));
    });
  }

  QueryBuilder<TestConstellation, TestConstellation, QAfterFilterCondition>
      testIdsElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'testIds',
        value: value,
      ));
    });
  }

  QueryBuilder<TestConstellation, TestConstellation, QAfterFilterCondition>
      testIdsElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'testIds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TestConstellation, TestConstellation, QAfterFilterCondition>
      testIdsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'testIds',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<TestConstellation, TestConstellation, QAfterFilterCondition>
      testIdsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'testIds',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<TestConstellation, TestConstellation, QAfterFilterCondition>
      testIdsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'testIds',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<TestConstellation, TestConstellation, QAfterFilterCondition>
      testIdsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'testIds',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<TestConstellation, TestConstellation, QAfterFilterCondition>
      testIdsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'testIds',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<TestConstellation, TestConstellation, QAfterFilterCondition>
      testIdsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'testIds',
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
}
