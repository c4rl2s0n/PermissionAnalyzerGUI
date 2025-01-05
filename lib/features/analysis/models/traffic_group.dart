import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/common/keys.dart';
import 'package:permission_analyzer_gui/data/data.dart';

class TrafficGroup {
  TrafficGroup({
    this.name = "",
    this.info,
    this.id = "",
    this.tags = const [],
    List<TestRun> tests = const [],
    this.data,
  }) {
    this.tests = tests;
  }

  TrafficGroup.fromScenario(TestScenario s)
      : this(
          name: s.name,
          id: "${s.applicationId}_${s.name}",
          // TODO: Info/ID ?
          tags: [tScenario],
          data: s,
        );

  TrafficGroup.fromConstellation(TestConstellation c)
      : this(
          name: c.abbreviation,
          id: c.abbreviation,
          data: c,
          info: c.info,
          tags: [tConstellation],
          tests: List.of(c.tests),
        );

  TrafficGroup.fromTest(TestRun t)
      : this(
          name: t.index.toString(),
          id: t.id.toString(),
          data: t,
          tags: [tTest],
          tests: [t],
        );

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
    loadConnections();
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
