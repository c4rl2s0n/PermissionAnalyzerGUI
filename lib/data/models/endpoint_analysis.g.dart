// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'endpoint_analysis.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const EndpointAnalysisSchema = Schema(
  name: r'EndpointAnalysis',
  id: -8737956494305318579,
  properties: {
    r'endpoints': PropertySchema(
      id: 0,
      name: r'endpoints',
      type: IsarType.objectList,
      target: r'TrafficEndpoint',
    ),
    r'trafficGroups': PropertySchema(
      id: 1,
      name: r'trafficGroups',
      type: IsarType.objectList,
      target: r'TrafficGroup',
    )
  },
  estimateSize: _endpointAnalysisEstimateSize,
  serialize: _endpointAnalysisSerialize,
  deserialize: _endpointAnalysisDeserialize,
  deserializeProp: _endpointAnalysisDeserializeProp,
);

int _endpointAnalysisEstimateSize(
  EndpointAnalysis object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.endpoints.length * 3;
  {
    final offsets = allOffsets[TrafficEndpoint]!;
    for (var i = 0; i < object.endpoints.length; i++) {
      final value = object.endpoints[i];
      bytesCount +=
          TrafficEndpointSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  bytesCount += 3 + object.trafficGroups.length * 3;
  {
    final offsets = allOffsets[TrafficGroup]!;
    for (var i = 0; i < object.trafficGroups.length; i++) {
      final value = object.trafficGroups[i];
      bytesCount += TrafficGroupSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  return bytesCount;
}

void _endpointAnalysisSerialize(
  EndpointAnalysis object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObjectList<TrafficEndpoint>(
    offsets[0],
    allOffsets,
    TrafficEndpointSchema.serialize,
    object.endpoints,
  );
  writer.writeObjectList<TrafficGroup>(
    offsets[1],
    allOffsets,
    TrafficGroupSchema.serialize,
    object.trafficGroups,
  );
}

EndpointAnalysis _endpointAnalysisDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = EndpointAnalysis(
    endpoints: reader.readObjectList<TrafficEndpoint>(
          offsets[0],
          TrafficEndpointSchema.deserialize,
          allOffsets,
          TrafficEndpoint(),
        ) ??
        const [],
    trafficGroups: reader.readObjectList<TrafficGroup>(
          offsets[1],
          TrafficGroupSchema.deserialize,
          allOffsets,
          TrafficGroup(),
        ) ??
        const [],
  );
  return object;
}

P _endpointAnalysisDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectList<TrafficEndpoint>(
            offset,
            TrafficEndpointSchema.deserialize,
            allOffsets,
            TrafficEndpoint(),
          ) ??
          const []) as P;
    case 1:
      return (reader.readObjectList<TrafficGroup>(
            offset,
            TrafficGroupSchema.deserialize,
            allOffsets,
            TrafficGroup(),
          ) ??
          const []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension EndpointAnalysisQueryFilter
    on QueryBuilder<EndpointAnalysis, EndpointAnalysis, QFilterCondition> {
  QueryBuilder<EndpointAnalysis, EndpointAnalysis, QAfterFilterCondition>
      endpointsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'endpoints',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<EndpointAnalysis, EndpointAnalysis, QAfterFilterCondition>
      endpointsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'endpoints',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<EndpointAnalysis, EndpointAnalysis, QAfterFilterCondition>
      endpointsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'endpoints',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<EndpointAnalysis, EndpointAnalysis, QAfterFilterCondition>
      endpointsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'endpoints',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<EndpointAnalysis, EndpointAnalysis, QAfterFilterCondition>
      endpointsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'endpoints',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<EndpointAnalysis, EndpointAnalysis, QAfterFilterCondition>
      endpointsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'endpoints',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<EndpointAnalysis, EndpointAnalysis, QAfterFilterCondition>
      trafficGroupsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'trafficGroups',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<EndpointAnalysis, EndpointAnalysis, QAfterFilterCondition>
      trafficGroupsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'trafficGroups',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<EndpointAnalysis, EndpointAnalysis, QAfterFilterCondition>
      trafficGroupsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'trafficGroups',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<EndpointAnalysis, EndpointAnalysis, QAfterFilterCondition>
      trafficGroupsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'trafficGroups',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<EndpointAnalysis, EndpointAnalysis, QAfterFilterCondition>
      trafficGroupsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'trafficGroups',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<EndpointAnalysis, EndpointAnalysis, QAfterFilterCondition>
      trafficGroupsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'trafficGroups',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension EndpointAnalysisQueryObject
    on QueryBuilder<EndpointAnalysis, EndpointAnalysis, QFilterCondition> {
  QueryBuilder<EndpointAnalysis, EndpointAnalysis, QAfterFilterCondition>
      endpointsElement(FilterQuery<TrafficEndpoint> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'endpoints');
    });
  }

  QueryBuilder<EndpointAnalysis, EndpointAnalysis, QAfterFilterCondition>
      trafficGroupsElement(FilterQuery<TrafficGroup> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'trafficGroups');
    });
  }
}
