import 'package:permission_analyzer_gui/data/data.dart';

class TestRunDto {
  TestRunDto({
    required this.scenario,
    required this.constellation,
    required this.test,
    this.index = 0,
  });
  String get applicationId => scenario.applicationId;
  String get applicationName => scenario.applicationName;
  TestScenario scenario;
  TestConstellation constellation;
  TestRun test;
  int index;
}
