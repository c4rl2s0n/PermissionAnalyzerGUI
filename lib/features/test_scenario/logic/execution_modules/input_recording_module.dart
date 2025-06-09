import 'dart:async';
import 'dart:io';

import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/features/test_scenario/logic/execution_modules/exeution_module.dart';

class InputRecordingModule extends ExecutionModule {
  InputRecordingModule({
    required this.adb,
    required Duration duration,
    super.startTime,
  }) : super(duration: duration);

  final Adb adb;

  late Process getEvents;

  List<String> eventLines = [];

  @override
  Future start() async {
    getEvents = await adb.getEvents(duration: duration!);

    getEvents.outLines.listen(_onEvent);

  }

  void _onEvent(String data) {
    List<String> lines = data.split("\n");
    if (lines.firstOrNull?.startsWith("[") ?? false) {
      String line = lines.first;
      String eventPath = line.split("]")[1].split(":")[0].trim();
      if (eventLines.isEmpty) {
        Duration initialOffset = DateTime.now().difference(startTime);
        String timestampPart = line.split("]").first.split("[")[1].trim();
        double currentEventTimestamp = double.parse(timestampPart);
        double initialEventTimestamp =
            currentEventTimestamp - (initialOffset.inMicroseconds / 1000000);
        eventLines.add("[    $initialEventTimestamp] $eventPath: 0 0 0");
        //eventLines.add("[$initialEventTimestamp] ${state.deviceInput.path} 0 0 0");
      }
      eventLines.addAll(lines.where((l) => l.startsWith("[")));
    }
  }

  @override
  Future stop([Object? argument]) async {
    await getEvents.exitCode;
    super.stop();
  }
}
