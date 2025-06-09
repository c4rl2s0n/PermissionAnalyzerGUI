import 'dart:async';
import 'dart:io';

import 'package:permission_analyzer_gui/common/common.dart';

import 'exeution_module.dart';

class InputReplayModule extends ExecutionModule{
  InputReplayModule(this._adb, this._settings);
  final Adb _adb;
  final SettingsState _settings;

  late Process _userInputProcess;

  @override
  Future start() async {
    _userInputProcess = await _adb.shellProc([
      _settings.recorderDestinationPath,
      _settings.inputRecordDestinationPath,
    ]);
  }

  @override
  FutureOr stop([Object? argument]) {
    _userInputProcess.kill();
    return super.stop(argument);
  }

}