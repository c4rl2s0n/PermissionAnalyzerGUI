import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:path/path.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/data/data.dart';

class NewApplicationDialogCubit extends Cubit<NewApplicationDialogState> {
  NewApplicationDialogCubit(this._settingsCubit, this._sessionCubit)
      : super(const NewApplicationDialogState());

  final SettingsCubit _settingsCubit;
  final SessionCubit _sessionCubit;

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
    if (await outDir.exists()) await outDir.delete(recursive: true);
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
    // cp ./myapp/res/mipmap-xxxhdpi-v4/ic_launcher.png ./app_icon.png
    FileSystemEntity icon =
        File(join(path, "res/mipmap-xxxhdpi-v4/ic_launcher.png"));
    if (await icon.exists()) return icon.path;
    try {
      icon = await Directory(path)
          .list(recursive: true)
          .firstWhere((f) => _isIcon(f));
      return icon.path;
    } catch (_) {
      return null;
    }
  }

  bool _isIcon(FileSystemEntity file) {
    return file.path.contains(".png") &&
        (file.path.contains("favicon") || file.path.contains("launcher"));
  }
}

class NewApplicationDialogState extends Equatable {
  const NewApplicationDialogState({
    this.applicationId = "",
    this.name = "",
    this.fileDirectory = "",
    this.iconPath = "",
    this.iconFound = false,
    this.searching = false,
  });

  final String applicationId;
  final String name;
  final String fileDirectory;
  final String iconPath;
  final bool iconFound;
  final bool searching;

  TestApplication get application => TestApplication(
        name: name,
        id: applicationId,
        fileDirectory: fileDirectory,
        iconPath: iconPath,
      );

  @override
  List<Object?> get props =>
      [applicationId, name, fileDirectory, iconPath, iconFound, searching];

  NewApplicationDialogState copyWith({
    String? applicationId,
    String? name,
    String? fileDirectory,
    String? iconPath,
    bool? iconFound,
    bool? searching,
  }) {
    return NewApplicationDialogState(
      applicationId: applicationId ?? this.applicationId,
      name: name ?? this.name,
      fileDirectory: fileDirectory ?? this.fileDirectory,
      iconPath: iconPath ?? this.iconPath,
      iconFound: iconFound ?? this.iconFound,
      searching: searching ?? this.searching,
    );
  }
}
