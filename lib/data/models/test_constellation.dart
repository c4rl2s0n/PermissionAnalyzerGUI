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
    this.trafficGroup,
  }) {
    if (trafficGroup != null) trafficGroup!.data = this;
  }

  List<PermissionSetting> permissions;
  List<TestRun> tests;
  TrafficGroup? trafficGroup;


  String get abbreviation {
    if (permissions.every((p) => p.state == PermissionState.granted)) {
      return "ALL";
    }
    String abbr = permissions
        .where((c) => c.state == PermissionState.granted)
        .map((c) => permissionToShortcut(c.permission))
        .join("_");
    if (abbr.isEmpty) abbr = "NONE";
    return abbr;
  }
}
