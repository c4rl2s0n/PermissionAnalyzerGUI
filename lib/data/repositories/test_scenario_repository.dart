import 'package:permission_analyzer_gui/data/data.dart';
import 'package:isar/isar.dart';

class TestScenarioRepository extends ITestScenarioRepository {
  TestScenarioRepository(this._isar, this._testRunRepository);
  final Isar _isar;
  final ITestRunRepository _testRunRepository;

  void _loadTests(List<TestScenario> scenarios) {
    scenarios.forEach(_testRunRepository.loadForScenario);
  }

  void _deleteTests(List<TestScenario> scenarios) {
    scenarios.forEach(_testRunRepository.deleteForScenario);
  }

  @override
  List<TestScenario> getAll() {
    List<TestScenario> scenarios = _isar.testScenarios.where().findAllSync();
    _loadTests(scenarios);
    return scenarios;
  }

  @override
  List<TestScenario> getForApplication(String applicationId) {
    List<TestScenario> scenarios = _isar.testScenarios
        .where()
        .applicationIdEqualTo(applicationId)
        .findAllSync();
    _loadTests(scenarios);
    return scenarios;
  }

  @override
  Stream<List<TestScenario>> watchForApplication(String applicationId) {
    return _isar.testScenarios
        .where()
        .applicationIdEqualTo(applicationId)
        .watch();
  }

  @override
  void deleteForApplication(String applicationId) {
    List<TestScenario> scenarios = _isar.testScenarios
        .where()
        .applicationIdEqualTo(applicationId)
        .findAllSync();
    _deleteTests(scenarios);
    _isar.writeTxnSync(
      () => _isar.testScenarios
          .deleteAllSync(scenarios.map((s) => s.id).toList()),
    );
  }

  @override
  void delete(int id) {
    TestScenario? scenario = _isar.testScenarios.getSync(id);
    if(scenario == null) return;
    _deleteTests([scenario]);
    _isar.writeTxnSync(() => _isar.testScenarios.deleteSync(id));
  }

  @override
  void update(TestScenario testScenario) {
    // TODO: update tests repo. Do not use TestRunRepo anywhere but here in this repo!
    _isar.writeTxnSync(() => _isar.testScenarios.putSync(testScenario));
  }

  @override
  void updateEndpoints(
      TestScenario scenario, Map<String, TrafficEndpoint> endpoints) {
    for (var constellation in scenario.testConstellations) {
      for (TrafficEndpoint endpoint
          in constellation.trafficGroup?.endpoints ?? []) {
        if (endpoints.containsKey(endpoint.ip)) {
          endpoint.hostname = endpoints[endpoint.ip]!.hostname;
        }
      }
    }
    _isar.writeTxnSync(() => _isar.testScenarios.putSync(scenario));
  }
}
