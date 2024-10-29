import 'package:isar/isar.dart';

part 'test_run.g.dart';

@embedded
class TestRun {
  TestRun({
    this.screenRecordPath,
    this.pcapPath,
    this.pcapJson,
  });

  String? screenRecordPath;
  String? pcapPath;
  String? pcapJson;
  bool get hasData =>
      screenRecordPath != null &&
      screenRecordPath!.isNotEmpty &&
      pcapPath != null &&
      pcapPath!.isNotEmpty;
}
