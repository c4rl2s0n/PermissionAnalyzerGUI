import 'package:permission_analyzer_gui/data/data.dart';
import 'package:isar/isar.dart';

class TestScenarioRepository extends ITestScenarioRepository {
  TestScenarioRepository(this._isar);
  final Isar _isar;
  @override
  List<TestScenario> getAll(){
    return _isar.testScenarios.where().findAllSync();
  }
  @override
  List<TestScenario> getForApplication(String applicationId) {
    return _isar.testScenarios
        .where()
        .applicationIdEqualTo(applicationId)
        .findAllSync();
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
    _isar.writeTxnSync(
      () => _isar.testScenarios
          .where()
          .applicationIdEqualTo(applicationId)
          .deleteAllSync(),
    );
  }

  @override
  void delete(int id) {
    _isar.writeTxnSync(() => _isar.testScenarios.deleteSync(id));
  }

  @override
  void update(TestScenario testScenario) {
    _isar.writeTxnSync(() => _isar.testScenarios.putSync(testScenario));
  }

  @override
  void updateEndpoints(TestScenario scenario, Map<String, TrafficEndpoint> endpoints) {
    for(var constellation in scenario.testConstellations){
      for(TrafficEndpoint endpoint in constellation.trafficGroup?.endpoints ?? []){
        if(endpoints.containsKey(endpoint.ip)){
          endpoint.hostname = endpoints[endpoint.ip]!.hostname;
        }
      }
    }
    _isar.writeTxnSync(() => _isar.testScenarios.putSync(scenario));
  }
}
