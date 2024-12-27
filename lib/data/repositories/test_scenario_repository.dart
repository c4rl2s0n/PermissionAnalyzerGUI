import 'package:permission_analyzer_gui/data/data.dart';
import 'package:isar/isar.dart';

class TestScenarioRepository extends ITestScenarioRepository {
  TestScenarioRepository(this._isar){
    _testRunRepository = TestRunRepository(_isar);
  }

  final Isar _isar;
  late final ITestRunRepository _testRunRepository;

  void loadTests(List<TestScenario> scenarios) {
    scenarios.forEach(_testRunRepository.loadForScenario);
  }
  void _updateTests(List<TestScenario> scenarios) {
    scenarios.forEach(_testRunRepository.updateForScenario);
  }

  void _deleteTests(List<TestScenario> scenarios) {
    scenarios.forEach(_testRunRepository.deleteForScenario);
  }

  @override
  List<TestScenario> getAll() {
    List<TestScenario> scenarios = _isar.testScenarios.where().findAllSync();
    loadTests(scenarios);
    return scenarios;
  }

  @override
  List<TestScenario> getForApplication(String applicationId) {
    List<TestScenario> scenarios = _isar.testScenarios
        .where()
        .applicationIdEqualTo(applicationId)
        .findAllSync();
    loadTests(scenarios);
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
    _updateTests([testScenario]);
    _isar.writeTxnSync(() => _isar.testScenarios.putSync(testScenario));
  }
}
