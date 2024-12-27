import 'package:isar/isar.dart';
import 'package:permission_analyzer_gui/common/helper.dart';
import 'package:permission_analyzer_gui/common/keys.dart';
import 'package:permission_analyzer_gui/data/data.dart';

part 'test_constellation.g.dart';

@embedded
class TestConstellation {
  TestConstellation({
    this.permissions = const [],
    this.testIds = const [],
  });

  List<PermissionSetting> permissions;
  List<int> testIds;
  List<TestRun>? _tests;
  @ignore
  List<TestRun> get tests => _tests ?? [];
  set tests(List<TestRun> value) {
    _tests = value;
  }


  String get info {
    String info = 'Permissions:\n';
    info += permissions
        .where((p) => p.state == PermissionState.granted)
        .map((p) => p.permission)
        .join("\t\t\n");
    return info;
  }

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
