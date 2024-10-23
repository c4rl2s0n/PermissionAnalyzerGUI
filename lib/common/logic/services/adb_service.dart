import 'dart:io';

import 'package:permission_analyzer_gui/common/common.dart';

class AdbService {
  AdbService(
    this._settingsCubit, {
    ProcessService? processService,
    this.device,
  }) {
    _ps = processService ?? ProcessService();
  }

  final SettingsCubit _settingsCubit;
  SettingsState get _settings => _settingsCubit.state;
  late final ProcessService _ps;
  final String? device;

  // TODO: Test if functions return usefull resultCodes

  static Future<String?> lookupPath() async {
    return await ProcessService.which("adb");
  }

  List<String> _getArguments(List<String> arguments) {
    return [
      if (device != null) ...["-s", device!],
      ...arguments
    ];
  }

  Future<Process> start(List<String> arguments, {Duration? timeout}) {
    return _ps.start(_settings.adbPath, _getArguments(arguments),
        timeout: timeout);
  }

  Future<Process> shellProc(List<String> arguments, {Duration? timeout}) {
    return start(_getArguments(["shell", ...arguments]), timeout: timeout);
  }

  Future<ProcessResult> run(List<String> arguments) {
    return _ps.run(_settings.adbPath, _getArguments(arguments));
  }

  Future<ProcessResult> shell(List<String> arguments) {
    return run(_getArguments(["shell", ...arguments]));
  }

  Future<List<String>> devices() async {
    return (await run(["devices"]))
        .outLines
        .skip(1)
        .map((dev) => dev.split("\t")[0])
        .where((d) => d.isNotEmpty)
        .toList();
  }

  Future<bool> pathFound() async {
    ProcessResult result = await run(["--version"]);
    return result.exitCode >= 0 &&
        result.outText.contains("Android Debug Bridge version");
  }

  Future root() async {
    await run(["root"]);
  }

  Future stopApp(String appId) async {
    await shell(["am", "force-stop", appId]);
  }

  Future startApp(String appId) async {
    await shell(["monkey", "-p", appId, "1"]);
  }

  Future pushFile(String srcPath, String dstPath) async {
    ProcessResult result = await run(["push", srcPath, dstPath]);
    return result.exitCode >= 0;
  }

  Future pullFile(String srcPath, String dstPath) async {
    ProcessResult result = await run(["pull", srcPath, dstPath]);
    return result.exitCode >= 0;
  }

  Future writeFile(String content, String dstPath) async {
    ProcessResult result = await run(["echo", content, '>', dstPath]);
    return result.exitCode >= 0;
  }

  Future<Map<String, String>> getEventDevices() async {
    Map<String, String> events = {};
    List<String> infos =
        (await shell(["getevent", "-p"])).outText.split("add device");
    for (String info in infos) {
      List<String> infoLines = info.split("\n");
      if (infoLines.length <= 1) continue;
      String dev = infoLines[0].split(":")[1].trim();
      infoLines[0] = "Input Device: $dev";
      events[dev] = infoLines.join("\n");
    }
    return events;
  }

  Future<Process> getEvents({
    required String devicePath,
    required Duration duration,
  }) async {
    return await shellProc(
      ["getevent", "-t", devicePath],
      timeout: duration,
    );
  }

  Future<Process> recordScreen({
    required String videoPath,
    required Duration duration,
  }) async {
    assert(duration.inSeconds <= 180);
    return await shellProc(
      [
        "screenrecord",
        "--time-limit",
        duration.inSeconds.toString(),
        videoPath,
      ],
    );
  }

  Future setPermission({
    required String applicationId,
    required String permission,
    required bool granted,
  }) async {
    return await shell(
        ["pm", granted ? "grant" : "revoke", applicationId, permission]);
  }

  Future<List<String>> getApplicationPermissions(String applicaitonId) async {
    var dump = (await shell(["dumpsys", "package", applicaitonId])).outText;
    List<String> permissions = dump
        .split("requested permissions:")[1]
        .split("install permissions:")[0]
        .trim()
        .split("\n")
        .map((p) => p.trim())
        .toList();
    permissions.sort();
    return permissions;
  }
}
