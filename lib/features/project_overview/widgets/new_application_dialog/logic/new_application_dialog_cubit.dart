import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path/path.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/data/data.dart';

part 'new_application_dialog_cubit.freezed.dart';

class NewApplicationDialogCubit extends Cubit<NewApplicationDialogState> {
  NewApplicationDialogCubit(
    this._settingsCubit,
    this._sessionCubit,
    this.existingApplications,
  ) : super(NewApplicationDialogState.empty()){
    selectAdbDevice(_sessionCubit.state.adbDevice);
  }

  final SettingsCubit _settingsCubit;
  final SessionCubit _sessionCubit;
  final List<String> existingApplications;

  Future selectAdbDevice(String device) async {
    List<String> appIds = state.applications;
    String appId = state.applicationId;
    if (device != state.adbDevice) {
      List<String> applications =
          await Adb(_settingsCubit, device: device).getApplications();
      appIds =
          applications.where((a) => !existingApplications.contains(a)).toList();
      appId = "";
    }
    emit(state.copyWith(
      adbDevice: device,
      applications: appIds,
      applicationId: appId,
    ));
  }

  void selectApplication(String id) {
    String fileDirectory = join(_settingsCubit.state.workingDirectory, id);
    emit(state.copyWith(applicationId: id, fileDirectory: fileDirectory));
  }

  void selectName(String name) {
    emit(state.copyWith(name: name));
  }

  Future cleanup() async {
    // clear files
    String outputDirectory =
        join(_settingsCubit.state.workingDirectory, state.applicationId);

    Directory outDir = Directory(outputDirectory);
    if (state.applicationId.notEmpty && await outDir.exists()) await outDir.delete(recursive: true);
  }

  Future<String?> extractAppIcon() async {
    String appId = state.applicationId;
    String outputDirectory =
        join(_settingsCubit.state.workingDirectory, state.applicationId);

    SystemProcess ps = SystemProcess();
    Adb adb = Adb(
      _settingsCubit,
      systemProcess: ps,
      device: _sessionCubit.state.adbDevice,
    );
    if (!await adb.applicationExists(appId)) return null;
    emit(state.copyWith(searching: true));

    Directory outDir = Directory(outputDirectory);
    if (!await outDir.exists()) await outDir.create(recursive: true);
    ps.workingDirectory = outputDirectory;

    // # Step 1: Get the package name
    // adb shell pm list packages | grep <app-name>
    //
    // # Step 2: Locate the APK path
    // adb shell pm path com.example.myapp
    List<String> apkPaths = (await adb.shell(["pm", "path", appId]))
        .outLines
        .where((l) => l.contains(":"))
        .map((l) => l.split(":")[1])
        .toList();

    // # Step 3: Pull the APK to your computer
    // adb pull /data/app/com.example.myapp-1/base.apk ./myapp.apk
    String apkPath = join(outputDirectory, "base.apk");
    await adb.pullFile(apkPaths.first, apkPath);
    //
    // # Step 4: Extract the APK contents
    // unzip myapp.apk -d ./myapp
    String extractedPath = join(outputDirectory, "app");
    await ps.run("unzip", [apkPath, "-d", extractedPath]);

    // # Step 5: Find and copy the icon
    // cp ./myapp/res/mipmap-xxxhdpi-v4/ic_launcher.png ./app_icon.png
    try {
      String? apkIcon = await _findIcon(extractedPath);
      String iconPath = join(outputDirectory, "icon.png");
      await File(apkIcon!).rename(iconPath);
      emit(state.copyWith(
        iconPath: iconPath,
        iconFound: true,
        searching: false,
      ));
      return iconPath;
    } catch (_) {
      emit(state.copyWith(iconPath: "", iconFound: false, searching: false));
      return null;
    } finally {
      await Directory(extractedPath).delete(recursive: true);
      await File(apkPath).delete(recursive: true);
    }
  }

  Future<String?> _findIcon(String path) async {
    Directory directory = Directory(path);
    List<File> icons = directory
        .listSync(recursive: true)
        .where((f) => FileSystemEntity.isFileSync(f.path))
        .map((f) => File(f.path))
        .where((f) => _isIcon(f))
        .toList();
    icons.sort((a, b) => b.lengthSync().compareTo(a.lengthSync()));
    return icons.firstOrNull?.path;
  }

  bool _isIcon(FileSystemEntity file) {
    String path = file.path.toLowerCase();
    return path.endsWith(".png") &&
        (path.contains("mipmap") ||
            path.contains("launcher") ||
            path.contains("favicon"));
    //(file.path.contains("icon") || file.path.contains("launcher"));
  }
}

@freezed
class NewApplicationDialogState with _$NewApplicationDialogState {
  const NewApplicationDialogState._();
  const factory NewApplicationDialogState({
    required String adbDevice,
    required List<String> applications,
    required String applicationId,
    required String name,
    required String fileDirectory,
    required String iconPath,
    required bool iconFound,
    required bool searching,
  }) = _NewApplicationDialogState;

  factory NewApplicationDialogState.empty() => const NewApplicationDialogState(
        adbDevice: "",
        applications: [],
        applicationId: "",
        name: "",
        fileDirectory: "",
        iconPath: "",
        iconFound: false,
        searching: false,
      );

  TestApplication get application => TestApplication(
        name: name,
        device: adbDevice,
        id: applicationId,
        fileDirectory: fileDirectory,
        iconPath: iconPath,
      );
}