// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analysis.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const AnalysisSchema = Schema(
  name: r'Analysis',
  id: -4774546373947357019,
  properties: {
    r'endpointAnalysis': PropertySchema(
      id: 0,
      name: r'endpointAnalysis',
      type: IsarType.object,
      target: r'EndpointAnalysis',
    )
  },
  estimateSize: _analysisEstimateSize,
  serialize: _analysisSerialize,
  deserialize: _analysisDeserialize,
  deserializeProp: _analysisDeserializeProp,
);

int _analysisEstimateSize(
  Analysis object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.endpointAnalysis;
    if (value != null) {
      bytesCount += 3 +
          EndpointAnalysisSchema.estimateSize(
              value, allOffsets[EndpointAnalysis]!, allOffsets);
    }
  }
  return bytesCount;
}

void _analysisSerialize(
  Analysis object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObject<EndpointAnalysis>(
    offsets[0],
    allOffsets,
    EndpointAnalysisSchema.serialize,
    object.endpointAnalysis,
  );
}

Analysis _analysisDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Analysis(
    endpointAnalysis: reader.readObjectOrNull<EndpointAnalysis>(
      offsets[0],
      EndpointAnalysisSchema.deserialize,
      allOffsets,
    ),
  );
  return object;
}

P _analysisDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectOrNull<EndpointAnalysis>(
        offset,
        EndpointAnalysisSchema.deserialize,
        allOffsets,
      )) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension AnalysisQueryFilter
    on QueryBuilder<Analysis, Analysis, QFilterCondition> {
  QueryBuilder<Analysis, Analysis, QAfterFilterCondition>
      endpointAnalysisIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'endpointAnalysis',
      ));
    });
  }

  QueryBuilder<Analysis, Analysis, QAfterFilterCondition>
      endpointAnalysisIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'endpointAnalysis',
      ));
    });
  }
}

extension AnalysisQueryObject
    on QueryBuilder<Analysis, Analysis, QFilterCondition> {
  QueryBuilder<Analysis, Analysis, QAfterFilterCondition> endpointAnalysis(
      FilterQuery<EndpointAnalysis> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'endpointAnalysis');
    });
  }
}
