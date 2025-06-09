import 'dart:async';

import 'package:path/path.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/data/data.dart';

import 'exeution_module.dart';

class ScreenRecordModuleStopArgument{
  ScreenRecordModuleStopArgument(this.fileDirectory, this.index, this.testRun, this.testRunEndTime);

  final String fileDirectory;
  final int index;
  final TestRun testRun;
  final DateTime testRunEndTime;
}

class ScreenRecordModule extends ExecutionModule{
  ScreenRecordModule(this._adb, {required Duration duration}) : super(duration: duration);
  final Adb _adb;

  String get _videoStoragePathOnDevice => "/data/local/tmp/out.mp4";

  @override
  FutureOr start() {
    _adb.recordScreen(
      videoPath: _videoStoragePathOnDevice,
      duration: duration!,
    );
  }

  @override
  Future stop([Object? argument]) async {
    if(argument != null && argument is ScreenRecordModuleStopArgument) {
      // wait a short time for the device to properly store the screen record
      int delay =
          15 - DateTime
              .timestamp()
              .difference(argument.testRunEndTime)
              .inSeconds;
      if (delay > 0) {
        await sleepSec(delay);
      }

      // get the screenrecord video from the device
      argument.testRun.screenRecordPath = join(argument.fileDirectory,
          "screenrecord_${argument.index.toString().padLeft(3, "0")}.mp4");
      await _adb.pullFile(
        _videoStoragePathOnDevice,
        argument.testRun.screenRecordPath!,
      );
    }
    return super.stop(argument);
  }

}
