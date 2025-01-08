import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/common/keys.dart';
import 'package:permission_analyzer_gui/data/data.dart';
import 'package:permission_analyzer_gui/features/analysis/models/models.dart';

import 'analysis_traffic_group_cubit.dart';
import 'test_run_dto.dart';

part 'analysis_cubit.freezed.dart';

class AnalysisCubit extends Cubit<AnalysisState> {
  AnalysisCubit({
    required this.scenarios,
    required this.testScenarioRepository,
    required this.networkEndpointRepository,
    required this.settingsCubit,
  }) : super(AnalysisState.empty()) {
    initialize();
  }

  final SettingsCubit settingsCubit;
  final List<TestScenario> scenarios;
  final ITestScenarioRepository testScenarioRepository;
  final INetworkEndpointRepository networkEndpointRepository;
  late List<AnalysisTrafficGroupCubit> applicationGroups;
  late List<AnalysisTrafficGroupCubit> constellationGroups;

  void initialize() {
    Map<String, TrafficGroup> applications = {};
    applicationGroups = [];
    constellationGroups = [];
    for (var scenario in scenarios) {
      // collect applications
      if (!applications.containsKey(scenario.applicationId)) {
        applications[scenario.applicationId] = TrafficGroup(
          name: scenario.applicationName,
          id: scenario.applicationName,
          info: "ID: ${scenario.applicationId}",
          graphTags: [tApplication],
          data: scenario.applicationId,
        );
      }
    }
    // collect all groups
    applicationGroups.addAll(applications.values.map(
      (a) => AnalysisTrafficGroupCubit(
        group: a,
        children: scenarios
            .where((s) => a.info?.contains(s.applicationId) ?? false)
            .map((scenario) => AnalysisTrafficGroupCubit(
                group: TrafficGroup.fromScenario(scenario),
                children: scenario.testConstellations.map((tc) {
                  var constellationGroup = AnalysisTrafficGroupCubit(
                      group: TrafficGroup.fromConstellation(tc),
                      children: tc.tests
                          .map(
                            (t) => AnalysisTrafficGroupCubit(
                                group: TrafficGroup.fromTest(t)),
                          )
                          .toList());
                  constellationGroups.add(constellationGroup);
                  return constellationGroup;
                }).toList())) // update trafficGroup data for scenario
            .toList(),
      )..updateGroupFromChildren(connectionsGrouped: state.connectionsGrouped), // update trafficGroup data for application
    ));
    updateState();
  }

  void updateState() {
    emit(state.copyWith(
      enabledGroups: _enabledGroups,
      groups: applicationGroups,
    ));
  }

  Future rerunAnalysis() async {
    emit(state.copyWith(analyzingTraffic: true));
    for (var scenario in scenarios) {
      for (var constellation in scenario.testConstellations) {
        for (var test in constellation.tests) {
          if (test.pcapPath == null) continue;
          test.packets = await TrafficAnalyzer.extractPackets(
            Tshark(settingsCubit),
            test.pcapPath!,
          );
          test.connections = TrafficAnalyzer.getConnectionsFromPackets(test.packets);
          if (test.startTimeInMs == 0) {
            test.startTimeInMs = test.packets.firstOrNull?.timeInMs ?? 0;
          }
          if (test.durationInMs == 0) {
            test.durationInMs = (test.packets.lastOrNull?.timeInMs ?? 0) -
                (test.packets.firstOrNull?.timeInMs ?? 0);
          }
        }
      }
      testScenarioRepository.update(scenario);
    }
    emit(state.copyWith(analyzingTraffic: false));
    initialize();
  }

  void reloadTrafficGroups() {
    for (var group in applicationGroups) {
      _reloadChildrenTrafficGroups(group);
    }
    updateState();
  }

  void _reloadChildrenTrafficGroups(AnalysisTrafficGroupCubit group) {
    if (!group.state.isSelected) return;
    for (var child in group.state.children) {
      _reloadChildrenTrafficGroups(child);
    }
    group.updateGroupFromChildren(connectionsGrouped: state.connectionsGrouped);
  }

  Future analyzeEndpoints({bool force = false}) async {
    emit(state.copyWith(analyzingEndpoints: true));
    List<INetworkEndpoint> groupEndpoints =
        _getEndpointsFromGroups(_enabledGroups);
    // get all explicit endpoints, in case we have a grouped endpoint
    List<NetworkEndpoint> endpoints = [];
    for (var endpoint in groupEndpoints) {
      if (endpoint is NetworkEndpoint) endpoints.add(endpoint);
      if (endpoint is EndpointGroup) endpoints.addAll(endpoint.endpoints);
    }
    List<String> locationLookupIps =
        endpoints.where((e) => force || !e.analyzed).map((e) => e.ip).toList();
    Map<String, Geolocation> geolocations =
        await EndpointAnalyzer.lookupGeolocations(locationLookupIps);
    // analyze each single endpoint
    for (var endpoint in endpoints) {
      if (endpoint.analyzed && !force) continue;
      // perform all hostname-analysis here!
      endpoint.hostname = await EndpointAnalyzer.lookupHostname(endpoint.ip);
      if (geolocations.containsKey(endpoint.ip)) {
        endpoint.geolocation = geolocations[endpoint.ip]!;
      }
      endpoint.analyzed = true;
    }
    networkEndpointRepository.updateAll(endpoints);
    updateState();
    emit(state.copyWith(analyzingEndpoints: false));
  }

  void setGrouped(bool grouped) {
    emit(state.copyWith(connectionsGrouped: grouped));
    for (var group in applicationGroups) {
      group.updateGroupConnections(grouped: state.connectionsGrouped);
    }
    updateState();
  }

  void setTrafficLoadInPackets(bool loadInPackets) {
    emit(state.copyWith(trafficLoadInPackets: loadInPackets));
  }

  void setShowTestsInGroupTable(bool showTests) {
    emit(state.copyWith(showTestsInGroupTable: showTests));
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
      _getGroups(applicationGroups).where((g) => g.state.isSelected).toList();

  List<INetworkEndpoint> _getEndpointsFromGroups(
    List<AnalysisTrafficGroupCubit> groups,
  ) =>
      TrafficAnalyzer.getEndpointsFromGroups(
        groups.map((g) => g.group).toList(),
      );
}

@freezed
class AnalysisState with _$AnalysisState {
  const AnalysisState._();

  const factory AnalysisState({
    required List<AnalysisTrafficGroupCubit> groups,
    required List<AnalysisTrafficGroupCubit> enabledGroups,
    required bool analyzingTraffic,
    required bool analyzingEndpoints,
    required bool connectionsGrouped,
    required bool showTestsInGroupTable,
    required bool trafficLoadInPackets,
  }) = _AnalysisState;

  factory AnalysisState.empty() => const AnalysisState(
        groups: [],
        enabledGroups: [],
        analyzingTraffic: false,
        analyzingEndpoints: false,
        connectionsGrouped: false,
        showTestsInGroupTable: true,
        trafficLoadInPackets: false,
      );

  List<AnalysisTrafficGroupCubit> get visibleGroups =>
      enabledGroups.where((g) => g.state.show).toList();

  List<TrafficGroup> get visibleTrafficGroups =>
      visibleGroups.map((g) => g.group).toList();

  List<INetworkConnection> get visibleConnections =>
      TrafficAnalyzer.getConnectionsFromTrafficGroups(
        visibleTrafficGroups,
        filtered: true,
        grouped: connectionsGrouped,
      );
  List<INetworkEndpoint> get endpoints =>
      TrafficAnalyzer.getEndpointsFromGroups(enabledGroups.map((g) => g.group).toList());

  List<NetworkPacket> get networkPackets => enabledGroups.fold(
      <NetworkPacket>[],
      (packets, group) => [
            ...packets,
            ...group.group.tests.fold(
              [],
              (trPackets, test) => [...trPackets, ...(test.packets)],
            ),
          ]);

  // count the number of testRuns where a given connection happened
  int testRunCount(INetworkConnection connection) {
    List<NetworkEndpoint> endpoints = connection.endpoint is NetworkEndpoint
        ? [connection.endpoint as NetworkEndpoint]
        : connection.endpoint is EndpointGroup
            ? (connection.endpoint as EndpointGroup).endpoints
            : [];
    return tests
        .where((t) =>
            t.test.endpoints
                ?.any((e) => endpoints.any((eps) => e.id == eps.id)) ??
            false)
        .length;
  }

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
