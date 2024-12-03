import 'package:permission_analyzer_gui/data/data.dart';

abstract class ITestScenarioRepository {
  List<TestScenario> getAll();
  List<TestScenario> getForApplication(String applicationId);
  Stream<List<TestScenario>> watchForApplication(String applicationId);
  void deleteForApplication(String applicationId);
  void delete(int id);
  void update(TestScenario testScenario);
  void updateEndpoints(TestScenario scenario, Map<String, TrafficEndpoint> endpoints);
  void loadTests(List<TestScenario> scenarios);
}
