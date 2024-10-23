import 'package:permission_analyzer_gui/data/data.dart';

abstract class ITestScenarioRepository{
  List<TestScenario> getTestScenarios(String applicationId);
  void updateTestScenario(TestScenario testScenario);
}