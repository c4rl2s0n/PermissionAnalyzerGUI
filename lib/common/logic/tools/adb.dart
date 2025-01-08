import 'dart:io';

import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/data/data.dart';

class Adb {
  Adb(
    this._settingsCubit, {
    SystemProcess? systemProcess,
    this.device,
  }) {
    _ps = systemProcess ?? SystemProcess();
  }

  final SettingsCubit _settingsCubit;
  SettingsState get _settings => _settingsCubit.state;
  late final SystemProcess _ps;
  final String? device;

  // TODO: Test if functions return usefull resultCodes

  static Future<String?> lookupPath() async {
    return (await SystemProcess.which("adb"))?.replaceAll("\n", "");
  }

  List<String> _getArguments(List<String> arguments) {
    return [
      if (device != null) ...["-s", device!],
      ...arguments
    ];
  }

  Future<Process> start(List<String> arguments, {Duration? timeout}) {
    assert(_settings.adbPath.isNotEmpty);
    return _ps.start(
      _settings.adbPath,
      _getArguments(arguments),
      timeout: timeout,
    );
  }

  Future<Process> shellProc(List<String> arguments, {Duration? timeout}) {
    return start(["shell", ...arguments], timeout: timeout);
  }

  Future<ProcessResult> run(List<String> arguments) {
    assert(_settings.adbPath.isNotEmpty);
    return _ps.run(_settings.adbPath, _getArguments(arguments));
  }

  Future<ProcessResult> shell(List<String> arguments) {
    return run(["shell", ...arguments]);
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

  Future<List<AndroidInputDevice>> getDeviceInputs() async {
    List<AndroidInputDevice> deviceInputs = [];
    List<String> infos =
        (await shell(["getevent", "-p"])).outText.split("add device");
    for (String info in infos) {
      List<String> infoLines = info.split("\n");
      if (infoLines.length <= 1) continue;
      String path = infoLines[0].split(":")[1].trim();
      String name = infoLines[1].split("name:")[1].trim().replaceAll('"', "");
      infoLines[0] = "Input Device: $path";
      deviceInputs.add(AndroidInputDevice(
          path: path, name: name, info: infoLines.join("\n")));
    }
    return deviceInputs;
  }

  Future<Process> getEvents({
    required Duration duration,
  }) async {
    return await shellProc(
      ["getevent", "-t"],
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

  Future<List<String>> getOptionalApplicationPermissions(String applicationId) async {
    var dump = (await shell(["dumpsys", "package", applicationId])).outText;
    List<String> permissions = [];
    List<String> permissionDump =
        dump.split("runtime permissions:")[1].split("\n");
    for (var line in permissionDump) {
      if (line.isEmpty) continue;
      if (!line.contains(":") || !line.contains("granted")) break;
      permissions.add(line.split(":")[0].trim());
    }
    permissions.sort();
    return permissions;
  }

  Future<Process> captureTraffic({
    required String pcapPath,
    required String interface,
    required Duration duration,
  }) async {
    return await start(
      [
        "tcpdump",
        "-w",
        pcapPath,
        "-i",
        interface,
      ],
      timeout: duration,
    );
  }

  Future<List<String>> getApplications() async {
    List<String> applications = (await shell(["pm", "list", "packages"]))
        .outLines
        .where((l) => l.contains(":"))
        .map((l) => l.split(":")[1])
        .toList();
    applications.sort();
    return applications;
  }

  Future<bool> applicationExists(String appId) async {
    return (await getApplications()).any((p) => p == appId);
  }

  /// ##########
  /// # Firewall
  /// ##########

  Future blockIP({required String ip}) async {
    await shell(["iptables", "-A", "INPUT", "-s", ip, "-j", "DROP"]);
    await shell(["iptables", "-A", "OUTPUT", "-d", ip, "-j", "DROP"]);
  }
  Future allowIP({required String ip}) async {
    await shell(["iptables", "-D", "INPUT", "-s", ip, "-j", "DROP"]);
    await shell(["iptables", "-D", "OUTPUT", "-d", ip, "-j", "DROP"]);
  }
}
