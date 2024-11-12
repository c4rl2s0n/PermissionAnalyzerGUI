import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:permission_analyzer_gui/data/models/models.dart';

part 'endpoint_analysis_cubit.freezed.dart';

class EndpointAnalysisCubit extends Cubit<EndpointAnalysisState> {
  EndpointAnalysisCubit({
    required this.model,
  }) : super(EndpointAnalysisState.fromAnalysis(model));

  final EndpointAnalysis model;
}

@freezed
class EndpointAnalysisState with _$EndpointAnalysisState {
  const EndpointAnalysisState._();

  const factory EndpointAnalysisState({
    required bool hideCommonEndpoints,
    required List<TrafficEndpoint> endpoints,
    required List<TrafficConnection> connections,
    required List<TrafficGroup> groups,
  }) = _EndpointAnalysisState;

  factory EndpointAnalysisState.fromAnalysis(EndpointAnalysis analysis) =>
      EndpointAnalysisState(
        hideCommonEndpoints: true,
        endpoints: analysis.endpoints,
        // endpointsCommon: analysis.endpoints
        //     .where((e) => analysis.trafficGroups
        //     .every((g) => g.endpoints.any((ge) => ge.name == e.name)))
        //     .toList(),
        // // endpoints that are not referenced by every(!) trafficGroup
        // endpointsNoCommon: analysis.endpoints
        //     .where((e) => !analysis.trafficGroups
        //         .every((g) => g.endpoints.any((ge) => ge.name == e.name)))
        //     .toList(),
        connections: analysis.connections,
        groups: analysis.trafficGroups,
      );


  List<TrafficEndpoint> get relevantEndpoints => endpoints;
      //hideCommonEndpoints ? endpointsNoCommon : [...endpointsCommon, ...endpointsNoCommon];
}
