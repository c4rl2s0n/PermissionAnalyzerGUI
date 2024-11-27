import 'package:isar/isar.dart';
import 'package:permission_analyzer_gui/common/common.dart';

import 'models.dart';

part 'traffic_group.g.dart';

@embedded
class TrafficGroup {
  TrafficGroup({
    this.name = "",
    this.info,
    this.id = "",
    this.tags = const [],
    List<TestRun> tests = const [],
    this.data,
  }){
    this.tests = tests;
  }

  String name;
  String? info;
  String id;
  int testRuns = 0;
  List<String> tags;

  late List<TestRun> _tests;
  List<TestRun> get tests => _tests;
  set tests(List<TestRun> value) {
    _tests = value;
    testRuns = tests.length;
    connections = TrafficAnalyzer.getConnectionsFromTestRuns(tests, filtered: true);
    endpoints = _endpoints;
    countEndpoints();
  }
  @ignore
  dynamic data;

  late List<TrafficConnection> connections;
  late List<TrafficEndpoint> endpoints;

  @ignore
  List<TrafficEndpoint> get _endpoints => connections
      .where((c) => c.endpoint != null)
      .map((c) => c.endpoint!)
      .toList();



  void countEndpoints() {
    int? countMin;
    int? countMax;
    int countAvg = 0;
    for (var test in tests) {
      int count = test.endpoints.length ?? 0;
      countAvg += count;
      if (countMin == null || countMin > count) countMin = count;
      if (countMax == null || countMax < count) countMax = count;
    }
    if (tests.isNotEmpty) countAvg = (countAvg / tests.length).floor();
    endpointCountMin = countMin ?? 0;
    endpointCountMax = countMax ?? 0;
    endpointCountAvg = countAvg;
  }
  int endpointCountMin = 0;
  int endpointCountMax = 0;
  int endpointCountAvg = 0;
}
