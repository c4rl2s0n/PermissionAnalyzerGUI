

import 'dart:io';

import 'package:permission_analyzer_gui/common/common.dart';


class TsharkService{
  TsharkService(this._settingsCubit, this._ps);
  final SettingsCubit _settingsCubit;
  SettingsState get _settings => _settingsCubit.state;
  final ProcessService _ps;

  static Future<String?> lookupPath(){
    return ProcessService.which("tshark");
  }

  Future<bool> pathFound()async{
    ProcessResult result = await _ps.run(_settings.tsharkPath, ["--version"]);
    return result.exitCode >= 0 && result.outText.contains("TShark") && result.outText.contains("Wireshark");
  }

}