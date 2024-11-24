import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/common/keys.dart';
import 'package:permission_analyzer_gui/data/data.dart';

import 'package:permission_analyzer_gui/data/models/models.dart';

import 'analysis_traffic_group_cubit.dart';

part 'endpoint_analysis_cubit.freezed.dart';

class EndpointAnalysisCubit extends Cubit<EndpointAnalysisState> {
  EndpointAnalysisCubit(this._scenarios, this._testScenarioRepository)
      : super(EndpointAnalysisState.empty()) {
    initialize();
  }

  final List<TestScenario> _scenarios;
  final ITestScenarioRepository _testScenarioRepository;
  late final List<AnalysisTrafficGroupCubit> analysisTrafficGroups;

  void initialize() {
    Map<String, TrafficGroup> applications = {};
    analysisTrafficGroups = [];
    for (var scenario in _scenarios) {
      // collect applications
      if (!applications.containsKey(scenario.applicationId)) {
        applications[scenario.applicationId] = TrafficGroup(
          name: scenario.applicationName,
          info: "ID: ${scenario.applicationId}",
          tags: [tApplication],
          data: scenario.applicationId,
        );
      }
    }
    // collect all groups
    analysisTrafficGroups.addAll(applications.values.map(
      (a) => AnalysisTrafficGroupCubit(
        group: a,
        children: _scenarios
            .where((s) => a.info?.contains(s.applicationId) ?? false)
            .map((scenario) => AnalysisTrafficGroupCubit(
                group: _testScenarioToTrafficGroup(scenario),
                children: scenario.testConstellations
                    .where((tc) => tc.trafficGroup != null)
                    .map((tc) =>
                        AnalysisTrafficGroupCubit(group: tc.trafficGroup!))
                    .toList())
              ..updateGroupFromChildren()) // update trafficGroup data for scenario
            .toList(),
      )..updateGroupFromChildren(), // update trafficGroup data for application
    ));
    updateState();
  }

  void updateState() {
    var enabledGroups = _enabledGroups;
    emit(state.copyWith(
      endpoints: _getEndpointsFromGroups(enabledGroups),
      // TODO: connections table changes when Show-value changes (this is false, should only change when selection changes!!)
      connections: _getFilteredConnectionsFromGroups(enabledGroups),
      visibleGroups: _getVisibleGroups(enabledGroups),
      enabledGroups: enabledGroups,
      groups: analysisTrafficGroups,
    ));
  }

  void reloadTrafficGroups() {
    for (var group in analysisTrafficGroups) {
      _reloadChildrenTrafficGroups(group);
    }
    updateState();
  }

  void _reloadChildrenTrafficGroups(AnalysisTrafficGroupCubit group) {
    if (!group.state.isSelected) return;
    for (var child in group.state.children) {
      _reloadChildrenTrafficGroups(child);
    }
    group.updateGroupFromChildren();
  }

  TrafficGroup _testScenarioToTrafficGroup(TestScenario scenario) =>
      TrafficGroup(
        name: scenario.name,
        // TODO: Info/ID ?
        tags: [tScenario],
        data: scenario,
      );

  Future analyzeEndpoints() async {
    emit(state.copyWith(analyzingEndpoints: true));
    List<TrafficEndpoint> endpoints = _getEndpointsFromGroups(_enabledGroups);
    Map<String, TrafficEndpoint> updatedEndpoints = {};
    for (var endpoint in endpoints) {
      if (endpoint.hostname == null) {
        endpoint.hostname = await EndpointAnalyzer.lookupHostname(endpoint.ip);
        if (endpoint.hostname != null) updatedEndpoints[endpoint.ip] = endpoint;
      }
    }
    if(updatedEndpoints.isNotEmpty) {
      _updateScenarioEndpoints(updatedEndpoints);
      updateState();
    }
    emit(state.copyWith(analyzingEndpoints: false));
  }

  void _updateScenarioEndpoints(Map<String, TrafficEndpoint> updatedEndpoints) {
    for (var scenario in _scenarios) {
      _testScenarioRepository.updateEndpoints(scenario, updatedEndpoints);
    }
  }

  /// get values for update

  List<AnalysisTrafficGroupCubit> _getGroups(
    List<AnalysisTrafficGroupCubit> groups,
  ) {
    List<AnalysisTrafficGroupCubit> collectedGroups = [];
    for (var group in groups) {
      collectedGroups.add(group);
      if (group.state.children.isEmpty) continue;
      collectedGroups.addAll(_getGroups(group.state.children));
    }
    return collectedGroups;
  }

  List<AnalysisTrafficGroupCubit> get _enabledGroups =>
      _getGroups(analysisTrafficGroups)
          .where((g) => g.state.isSelected)
          .toList();
  List<AnalysisTrafficGroupCubit> _getVisibleGroups(
          List<AnalysisTrafficGroupCubit> groups) =>
      groups.where((g) => g.state.show).toList();

  List<TrafficEndpoint> _getEndpointsFromGroups(
          List<AnalysisTrafficGroupCubit> groups) =>
      TrafficAnalyzer.getEndpointsFromGroups(
          groups.map((g) => g.group).toList());

  List<TrafficConnection> _getFilteredConnectionsFromGroups(
          List<AnalysisTrafficGroupCubit> groups) =>
      TrafficAnalyzer.getConnectionsFromTrafficGroups(
          groups.where((g) => g.children.isEmpty).map((g) => g.group).toList());
}

@freezed
class EndpointAnalysisState with _$EndpointAnalysisState {
  const EndpointAnalysisState._();

  const factory EndpointAnalysisState({
    required List<TrafficEndpoint> endpoints,
    required List<TrafficConnection> connections,
    required List<AnalysisTrafficGroupCubit> groups,
    required List<AnalysisTrafficGroupCubit> visibleGroups,
    required List<AnalysisTrafficGroupCubit> enabledGroups,
    required bool analyzingEndpoints,
  }) = _EndpointAnalysisState;

  factory EndpointAnalysisState.empty() => const EndpointAnalysisState(
        endpoints: [],
        connections: [],
        groups: [],
        visibleGroups: [],
        enabledGroups: [],
        analyzingEndpoints: false,
      );

  List<TrafficGroup> get visibleTrafficGroups =>
      visibleGroups.map((g) => g.group).toList();
}
