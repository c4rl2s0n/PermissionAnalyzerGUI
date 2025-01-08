// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firewall_setting.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const FirewallSettingSchema = Schema(
  name: r'FirewallSetting',
  id: 5684398229784596305,
  properties: {
    r'blocked': PropertySchema(
      id: 0,
      name: r'blocked',
      type: IsarType.bool,
    ),
    r'ip': PropertySchema(
      id: 1,
      name: r'ip',
      type: IsarType.string,
    )
  },
  estimateSize: _firewallSettingEstimateSize,
  serialize: _firewallSettingSerialize,
  deserialize: _firewallSettingDeserialize,
  deserializeProp: _firewallSettingDeserializeProp,
);

int _firewallSettingEstimateSize(
  FirewallSetting object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.ip.length * 3;
  return bytesCount;
}

void _firewallSettingSerialize(
  FirewallSetting object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.blocked);
  writer.writeString(offsets[1], object.ip);
}

FirewallSetting _firewallSettingDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = FirewallSetting(
    blocked: reader.readBoolOrNull(offsets[0]) ?? false,
    ip: reader.readStringOrNull(offsets[1]) ?? "",
  );
  return object;
}

P _firewallSettingDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 1:
      return (reader.readStringOrNull(offset) ?? "") as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension FirewallSettingQueryFilter
    on QueryBuilder<FirewallSetting, FirewallSetting, QFilterCondition> {
  QueryBuilder<FirewallSetting, FirewallSetting, QAfterFilterCondition>
      blockedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'blocked',
        value: value,
      ));
    });
  }

  QueryBuilder<FirewallSetting, FirewallSetting, QAfterFilterCondition>
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

  QueryBuilder<FirewallSetting, FirewallSetting, QAfterFilterCondition>
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

  QueryBuilder<FirewallSetting, FirewallSetting, QAfterFilterCondition>
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

  QueryBuilder<FirewallSetting, FirewallSetting, QAfterFilterCondition>
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

  QueryBuilder<FirewallSetting, FirewallSetting, QAfterFilterCondition>
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

  QueryBuilder<FirewallSetting, FirewallSetting, QAfterFilterCondition>
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

  QueryBuilder<FirewallSetting, FirewallSetting, QAfterFilterCondition>
      ipContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'ip',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FirewallSetting, FirewallSetting, QAfterFilterCondition>
      ipMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'ip',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FirewallSetting, FirewallSetting, QAfterFilterCondition>
      ipIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ip',
        value: '',
      ));
    });
  }

  QueryBuilder<FirewallSetting, FirewallSetting, QAfterFilterCondition>
      ipIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'ip',
        value: '',
      ));
    });
  }
}

extension FirewallSettingQueryObject
    on QueryBuilder<FirewallSetting, FirewallSetting, QFilterCondition> {}
