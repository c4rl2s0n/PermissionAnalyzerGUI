import 'package:isar/isar.dart';
import 'package:permission_analyzer_gui/data/data.dart';

part 'test_constellation.g.dart';

@embedded
class TestConstellation{
  TestConstellation({this.permissions = const [], this.tests = const[],});

  List<PermissionSetting> permissions;
  List<TestRun> tests;
}