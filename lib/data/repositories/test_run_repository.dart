import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/data/data.dart';
import 'package:isar/isar.dart';

class TestRunRepository extends ITestRunRepository {
  TestRunRepository(this._isar) {
    _networkEndpointRepository = NetworkEndpointRepository(_isar);
  }
  final Isar _isar;

  late final INetworkEndpointRepository _networkEndpointRepository;

  @override
  void deleteAll(List<int> testIds) {
    _isar.writeTxnSync(() => _isar.testRuns.deleteAllSync(testIds));
  }

  @override
  List<TestRun> getAll(List<int> testIds) {
    List<TestRun> tests = _isar.testRuns.getAllSync(testIds).nonNulls.toList();
    for (var test in tests) {
      test.endpoints = TrafficAnalyzer.getEndpointsFromConnections(
        test.connections,
        filtered: false,
        endpointRepository: _networkEndpointRepository,
      ).whereType<NetworkEndpoint>().toList();
    }
    return tests;
  }

  @override
  List<int> updateAll(List<TestRun> tests) {
    List<int> testIds = [];
    _isar.writeTxnSync(() => testIds = _isar.testRuns.putAllSync(tests));
    return testIds;
  }

  @override
  void loadForScenario(TestScenario scenario) {
    for (var constellation in scenario.testConstellations) {
      constellation.tests = getAll(constellation.testIds);
    }
  }

  @override
  void updateForScenario(TestScenario scenario) {
    for (var constellation in scenario.testConstellations) {
      constellation.testIds = updateAll(constellation.tests);
    }
  }

  @override
  void deleteForScenario(TestScenario scenario) {
    for (var constellation in scenario.testConstellations) {
      deleteAll(constellation.testIds);
      constellation.testIds = <int>[];
      constellation.tests = <TestRun>[];
    }
  }
}
