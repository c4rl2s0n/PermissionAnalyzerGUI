import 'package:flutter/rendering.dart';
import 'package:isar/isar.dart';
import 'package:permission_analyzer_gui/common/helper.dart';
import 'package:permission_analyzer_gui/data/data.dart';

part 'test_constellation.g.dart';

@embedded
class TestConstellation {
  TestConstellation({
    this.permissions = const [],
    this.tests = const [],
  });

  List<PermissionSetting> permissions;
  List<TestRun> tests;

  List<TrafficConnection> get trafficConnections {
    List<TrafficConnection> connections = [];
    for (var test in tests) {
      connections.addAll(test.connections ?? []);
    }
    return connections;
  }

  @ignore
  String get abbreviation {
    String abbr = permissions
        .where((c) => c.state == PermissionState.granted)
        .map((c) => permissionToShortcut(c.permission))
        .join("_");
    if (abbr.isEmpty) abbr = "NONE";
    return abbr;
  }
}
