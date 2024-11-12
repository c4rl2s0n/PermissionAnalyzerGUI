import 'package:permission_analyzer_gui/data/data.dart';

abstract class ITestScenarioRepository {
  List<TestScenario> getForApplication(String applicationId);
  Stream<List<TestScenario>> watchForApplication(String applicationId);
  void deleteForApplication(String applicationId);
  void delete(int id);
  void update(TestScenario testScenario);
}
