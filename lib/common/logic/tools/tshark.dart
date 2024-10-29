import 'dart:io';

import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/data/data.dart';


class Tshark{
  Tshark(this._settingsCubit, {SystemProcess? systemProcess}){
    _ps = systemProcess ?? SystemProcess();
  }
  final SettingsCubit _settingsCubit;
  SettingsState get _settings => _settingsCubit.state;
  late final SystemProcess _ps;

  static Future<String?> lookupPath(){
    return SystemProcess.which("tshark");
  }

  Future<Process> start(List<String> arguments, {Duration? timeout}) {
    return _ps.start(_settings.tsharkPath, arguments, timeout: timeout);
  }
  Future<ProcessResult> run(List<String> arguments) {
    return _ps.run(_settings.tsharkPath, arguments);
  }

  Future<bool> pathFound()async{
    ProcessResult result = await _ps.run(_settings.tsharkPath, ["--version"]);
    return result.exitCode >= 0 && result.outText.contains("TShark") && result.outText.contains("Wireshark");
  }

  Future<List<TsharkNetworkInterface>> getInterfaces()async{
    ProcessResult result = await run(["--list-interfaces"]);
    List<String> lines = result.outText.split("\n");
    List<TsharkNetworkInterface> interfaces = [];
    for(var l in lines){
      List<String> parts = l.split(".");
      int? id = int.tryParse(parts[0]);
      if(id == null) continue;
      parts = parts[1].trim().split(" ");
      String name = parts[0];
      String? info;
      if(parts.length > 1){
        info = l.split(name)[1].trim();
      }
      interfaces.add(TsharkNetworkInterface(id: id, name: name, info: info));
    }
    return interfaces;
  }

  Future<Process> capture({
    required String pcapPath,
    required String interface,
    required Duration duration,
  }) async {
    return await start(
      ["-w", pcapPath, "-T", "json", "-i", interface, "-a", "duration:${duration.inSeconds}"],
      //timeout: duration,
    );
  }

}