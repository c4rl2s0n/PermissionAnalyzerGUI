// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analysis_config.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const AnalysisConfigSchema = Schema(
  name: r'AnalysisConfig',
  id: -6492801109449366064,
  properties: {
    r'groupConnections': PropertySchema(
      id: 0,
      name: r'groupConnections',
      type: IsarType.bool,
    ),
    r'showLocation': PropertySchema(
      id: 1,
      name: r'showLocation',
      type: IsarType.bool,
    ),
    r'showPort': PropertySchema(
      id: 2,
      name: r'showPort',
      type: IsarType.bool,
    ),
    r'showTestsInGroupTable': PropertySchema(
      id: 3,
      name: r'showTestsInGroupTable',
      type: IsarType.bool,
    ),
    r'sniInDomain': PropertySchema(
      id: 4,
      name: r'sniInDomain',
      type: IsarType.bool,
    ),
    r'trafficLoadInPackets': PropertySchema(
      id: 5,
      name: r'trafficLoadInPackets',
      type: IsarType.bool,
    )
  },
  estimateSize: _analysisConfigEstimateSize,
  serialize: _analysisConfigSerialize,
  deserialize: _analysisConfigDeserialize,
  deserializeProp: _analysisConfigDeserializeProp,
);

int _analysisConfigEstimateSize(
  AnalysisConfig object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _analysisConfigSerialize(
  AnalysisConfig object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.groupConnections);
  writer.writeBool(offsets[1], object.showLocation);
  writer.writeBool(offsets[2], object.showPort);
  writer.writeBool(offsets[3], object.showTestsInGroupTable);
  writer.writeBool(offsets[4], object.sniInDomain);
  writer.writeBool(offsets[5], object.trafficLoadInPackets);
}

AnalysisConfig _analysisConfigDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AnalysisConfig(
    groupConnections: reader.readBoolOrNull(offsets[0]) ?? false,
    showLocation: reader.readBoolOrNull(offsets[1]) ?? true,
    showPort: reader.readBoolOrNull(offsets[2]) ?? false,
    showTestsInGroupTable: reader.readBoolOrNull(offsets[3]) ?? true,
    sniInDomain: reader.readBoolOrNull(offsets[4]) ?? true,
    trafficLoadInPackets: reader.readBoolOrNull(offsets[5]) ?? false,
  );
  return object;
}

P _analysisConfigDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 1:
      return (reader.readBoolOrNull(offset) ?? true) as P;
    case 2:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 3:
      return (reader.readBoolOrNull(offset) ?? true) as P;
    case 4:
      return (reader.readBoolOrNull(offset) ?? true) as P;
    case 5:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension AnalysisConfigQueryFilter
    on QueryBuilder<AnalysisConfig, AnalysisConfig, QFilterCondition> {
  QueryBuilder<AnalysisConfig, AnalysisConfig, QAfterFilterCondition>
      groupConnectionsEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'groupConnections',
        value: value,
      ));
    });
  }

  QueryBuilder<AnalysisConfig, AnalysisConfig, QAfterFilterCondition>
      showLocationEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'showLocation',
        value: value,
      ));
    });
  }

  QueryBuilder<AnalysisConfig, AnalysisConfig, QAfterFilterCondition>
      showPortEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'showPort',
        value: value,
      ));
    });
  }

  QueryBuilder<AnalysisConfig, AnalysisConfig, QAfterFilterCondition>
      showTestsInGroupTableEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'showTestsInGroupTable',
        value: value,
      ));
    });
  }

  QueryBuilder<AnalysisConfig, AnalysisConfig, QAfterFilterCondition>
      sniInDomainEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sniInDomain',
        value: value,
      ));
    });
  }

  QueryBuilder<AnalysisConfig, AnalysisConfig, QAfterFilterCondition>
      trafficLoadInPacketsEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'trafficLoadInPackets',
        value: value,
      ));
    });
  }
}

extension AnalysisConfigQueryObject
    on QueryBuilder<AnalysisConfig, AnalysisConfig, QFilterCondition> {}
