import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/common/keys.dart';
import 'package:permission_analyzer_gui/data/data.dart';
import 'package:permission_analyzer_gui/features/analysis/widgets/endpoint_analysis/logic/test_run_dto.dart';

import 'analysis_traffic_group_cubit.dart';

part 'endpoint_analysis_cubit.freezed.dart';

class EndpointAnalysisCubit extends Cubit<EndpointAnalysisState> {
  EndpointAnalysisCubit({
    required this.scenarios,
    required this.testScenarioRepository,
    required this.settingsCubit,
  }) : super(EndpointAnalysisState.empty()) {
    initialize();
  }

  final SettingsCubit settingsCubit;
  final List<TestScenario> scenarios;
  final ITestScenarioRepository testScenarioRepository;
  late List<AnalysisTrafficGroupCubit> analysisTrafficGroups;

  void initialize() {
    Map<String, TrafficGroup> applications = {};
    analysisTrafficGroups = [];
    for (var scenario in scenarios) {
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
        children: scenarios
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

  Future rerunAnalysis() async {
    emit(state.copyWith(analyzingTraffic: true));
    for (var scenario in scenarios) {
      for (var constellation in scenario.testConstellations) {
        for (var test in constellation.tests) {
          if (test.pcapPath == null) continue;
          test.packets = await TrafficAnalyzer.extractPackets(
              Tshark(settingsCubit), test.pcapPath!);
          test.connections =
              TrafficAnalyzer.getConnectionsFromPackets(test.packets!);
          if (test.startTimeInMs == 0) {
            test.startTimeInMs = test.packets?.firstOrNull?.timeInMs ?? 0;
          }
          if (test.durationInMs == 0) {
            test.durationInMs = (test.packets?.lastOrNull?.timeInMs ?? 0) -
                (test.packets?.firstOrNull?.timeInMs ?? 0);
          }
        }
        constellation.trafficGroup = constellation.getTrafficGroup();
      }
      testScenarioRepository.update(scenario);
    }
    emit(state.copyWith(analyzingTraffic: false));
    initialize();
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
    if (updatedEndpoints.isNotEmpty) {
      _updateScenarioEndpoints(updatedEndpoints);
      updateState();
    }
    emit(state.copyWith(analyzingEndpoints: false));
  }

  void _updateScenarioEndpoints(Map<String, TrafficEndpoint> updatedEndpoints) {
    for (var scenario in scenarios) {
      testScenarioRepository.updateEndpoints(scenario, updatedEndpoints);
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
    required bool analyzingTraffic,
    required bool analyzingEndpoints,
  }) = _EndpointAnalysisState;

  factory EndpointAnalysisState.empty() => const EndpointAnalysisState(
        endpoints: [],
        connections: [],
        groups: [],
        visibleGroups: [],
        enabledGroups: [],
        analyzingTraffic: false,
        analyzingEndpoints: false,
      );

  List<TrafficGroup> get visibleTrafficGroups =>
      visibleGroups.map((g) => g.group).toList();
  List<NetworkPacket> get networkPackets => enabledGroups.fold(
      <NetworkPacket>[],
      (packets, group) => [
            ...packets,
            ...group.group.tests.fold(
              [],
              (trPackets, test) => [...trPackets, ...(test.packets ?? [])],
            ),
          ]);
  List<TestRunDto> get tests {
    List<TestRunDto> tests = [];
    for (var g in enabledGroups.where((g) => g.group.data is TestScenario)) {
      TestScenario scenario = g.group.data as TestScenario;
      for (var constellation in scenario.testConstellations) {
        int index = 0;
        for (var test in constellation.tests) {
          tests.add(TestRunDto(
            scenario: scenario,
            constellation: constellation,
            test: test,
            index: index++,
          ));
        }
      }
    }
    return tests;
  }
}
