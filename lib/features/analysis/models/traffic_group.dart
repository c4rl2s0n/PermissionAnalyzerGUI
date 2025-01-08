import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/common/keys.dart';
import 'package:permission_analyzer_gui/data/data.dart';

class TrafficGroup {
  TrafficGroup({
    this.name = "",
    this.info,
    this.id = "",
    this.graphTags = const [],
    List<TestRun> tests = const [],
    this.data,
  }) {
    setTests(tests);
  }

  TrafficGroup.fromScenario(TestScenario s)
      : this(
          name: s.name,
          id: "${s.applicationId}_${s.name}",
          // TODO: Info/ID ?
          graphTags: [tScenario],
          data: s,
        );

  TrafficGroup.fromConstellation(TestConstellation c)
      : this(
          name: c.displayName,
          id: c.uniqueIdentifier,
          data: c,
          info: c.info,
          graphTags: [tConstellation],
          tests: List.of(c.tests),
        );

  TrafficGroup.fromTest(TestRun t)
      : this(
          name: t.index.toString(),
          id: t.id.toString(),
          data: t,
          graphTags: [tTest],
          tests: [t],
        );

  String name;
  String? info;
  String id;
  int testRuns = 0;
  List<String> graphTags;

  late List<TestRun> _tests;
  List<TestRun> get tests => _tests;
  void setTests(List<TestRun> values, {bool grouped = false}) {
    _tests = values;
    testRuns = tests.length;
    loadConnections(grouped: grouped);
    countEndpoints();
  }

  dynamic data;

  void loadConnections({bool grouped = false}) {
    connections = TrafficAnalyzer.getConnectionsFromTestRuns(
      tests,
      filtered: true,
      grouped: grouped,
    );
    endpoints = _endpoints;
  }

  late List<INetworkConnection> connections;
  late List<INetworkEndpoint> endpoints;

  List<NetworkConnection> get networkConnections => connections.fold(<NetworkConnection>[], (all, con) => [...all, ...con.connections]).distinct;

  List<INetworkEndpoint> get _endpoints =>
      connections.map((c) => c.endpoint).toList().distinct;

  void countEndpoints() {
    int? countMin;
    int? countMax;
    int countAvg = 0;
    for (var test in tests) {
      int count = test.endpoints?.length ?? 0;
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
