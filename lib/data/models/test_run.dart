import 'package:isar/isar.dart';

part 'test_run.g.dart';

@embedded
class TestRun {
  TestRun({
    this.screenRecordPath,
    this.pcapPath,
  });

  String? screenRecordPath;
  String? pcapPath;
  bool get hasData =>
      screenRecordPath != null &&
      screenRecordPath!.isNotEmpty &&
      pcapPath != null &&
      pcapPath!.isNotEmpty;
}
