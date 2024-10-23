import 'package:permission_analyzer_gui/data/data.dart';
import 'package:isar/isar.dart';

class TestScenarioRepository extends ITestScenarioRepository {
  TestScenarioRepository(this._isar);
  final Isar _isar;

  @override
  List<TestScenario> getTestScenarios(String applicationId) {
    return _isar.testScenarios
        .where()
        .applicationIdEqualTo(applicationId)
        .findAllSync();
  }

  @override
  void updateTestScenario(TestScenario testScenario) {
    _isar.writeTxnSync(() => _isar.testScenarios.putSync(testScenario));
  }
}
