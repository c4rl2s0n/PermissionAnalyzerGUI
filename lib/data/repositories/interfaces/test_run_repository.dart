import 'package:permission_analyzer_gui/data/data.dart';

abstract class ITestRunRepository {
  List<TestRun> getAll(List<int> testIds);
  void deleteAll(List<int> testIds);
  List<int> updateAll(List<TestRun> tests);
  void loadForScenario(TestScenario scenario);
  void updateForScenario(TestScenario scenario);
  void deleteForScenario(TestScenario scenario);
}
