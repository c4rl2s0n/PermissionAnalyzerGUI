// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'permission_setting.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const PermissionSettingSchema = Schema(
  name: r'PermissionSetting',
  id: -8835314887670561930,
  properties: {
    r'permission': PropertySchema(
      id: 0,
      name: r'permission',
      type: IsarType.string,
    ),
    r'state': PropertySchema(
      id: 1,
      name: r'state',
      type: IsarType.string,
      enumMap: _PermissionSettingstateEnumValueMap,
    )
  },
  estimateSize: _permissionSettingEstimateSize,
  serialize: _permissionSettingSerialize,
  deserialize: _permissionSettingDeserialize,
  deserializeProp: _permissionSettingDeserializeProp,
);

int _permissionSettingEstimateSize(
  PermissionSetting object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.permission.length * 3;
  bytesCount += 3 + object.state.name.length * 3;
  return bytesCount;
}

void _permissionSettingSerialize(
  PermissionSetting object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.permission);
  writer.writeString(offsets[1], object.state.name);
}

PermissionSetting _permissionSettingDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PermissionSetting(
    permission: reader.readStringOrNull(offsets[0]) ?? "",
    state: _PermissionSettingstateValueEnumMap[
            reader.readStringOrNull(offsets[1])] ??
        PermissionState.revoked,
  );
  return object;
}

P _permissionSettingDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset) ?? "") as P;
    case 1:
      return (_PermissionSettingstateValueEnumMap[
              reader.readStringOrNull(offset)] ??
          PermissionState.revoked) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _PermissionSettingstateEnumValueMap = {
  r'granted': r'granted',
  r'revoked': r'revoked',
  r'test': r'test',
};
const _PermissionSettingstateValueEnumMap = {
  r'granted': PermissionState.granted,
  r'revoked': PermissionState.revoked,
  r'test': PermissionState.test,
};

extension PermissionSettingQueryFilter
    on QueryBuilder<PermissionSetting, PermissionSetting, QFilterCondition> {
  QueryBuilder<PermissionSetting, PermissionSetting, QAfterFilterCondition>
      permissionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'permission',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PermissionSetting, PermissionSetting, QAfterFilterCondition>
      permissionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'permission',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PermissionSetting, PermissionSetting, QAfterFilterCondition>
      permissionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'permission',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PermissionSetting, PermissionSetting, QAfterFilterCondition>
      permissionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'permission',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PermissionSetting, PermissionSetting, QAfterFilterCondition>
      permissionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'permission',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PermissionSetting, PermissionSetting, QAfterFilterCondition>
      permissionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'permission',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PermissionSetting, PermissionSetting, QAfterFilterCondition>
      permissionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'permission',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PermissionSetting, PermissionSetting, QAfterFilterCondition>
      permissionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'permission',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PermissionSetting, PermissionSetting, QAfterFilterCondition>
      permissionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'permission',
        value: '',
      ));
    });
  }

  QueryBuilder<PermissionSetting, PermissionSetting, QAfterFilterCondition>
      permissionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'permission',
        value: '',
      ));
    });
  }

  QueryBuilder<PermissionSetting, PermissionSetting, QAfterFilterCondition>
      stateEqualTo(
    PermissionState value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'state',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PermissionSetting, PermissionSetting, QAfterFilterCondition>
      stateGreaterThan(
    PermissionState value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'state',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PermissionSetting, PermissionSetting, QAfterFilterCondition>
      stateLessThan(
    PermissionState value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'state',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PermissionSetting, PermissionSetting, QAfterFilterCondition>
      stateBetween(
    PermissionState lower,
    PermissionState upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'state',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PermissionSetting, PermissionSetting, QAfterFilterCondition>
      stateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'state',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PermissionSetting, PermissionSetting, QAfterFilterCondition>
      stateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'state',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PermissionSetting, PermissionSetting, QAfterFilterCondition>
      stateContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'state',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PermissionSetting, PermissionSetting, QAfterFilterCondition>
      stateMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'state',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PermissionSetting, PermissionSetting, QAfterFilterCondition>
      stateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'state',
        value: '',
      ));
    });
  }

  QueryBuilder<PermissionSetting, PermissionSetting, QAfterFilterCondition>
      stateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'state',
        value: '',
      ));
    });
  }
}

extension PermissionSettingQueryObject
    on QueryBuilder<PermissionSetting, PermissionSetting, QFilterCondition> {}
