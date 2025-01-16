import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_analyzer_gui/common/common.dart';

class ToolSettings extends StatelessWidget {
  const ToolSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsGroup(
      title: "Tools",
      settings: [
        _workingDirectory(),
        _adbPathSettings(),
        _adbDeviceSettings(),
        _tsharkPathSettings(),
        _recorderSettings(),
      ],
    );
  }

  Widget _workingDirectory() {
    return BlocBuilder<SettingsCubit, SettingsState>(
      buildWhen: (oldState, state) =>
          oldState.workingDirectory != state.workingDirectory,
      builder: (context, state) {
        return SimpleSetting(
          name: "Working Directory",
          description: state.workingDirectory,
          action:
              // pick file manually
              IconButton(
            onPressed: () async {
              String? directory = await FilePickerFactory.getFilePicker()
                  .getDirectoryPath(dialogTitle: "Pick your working directory");
              if (!context.mounted) return;
              if (directory != null && directory.isNotEmpty) {
                context.settings.setWorkingDirectory(directory);
              }
            },
            icon: Icon(context.icons.pickDirectory),
          ),
        );
      },
    );
  }

  Widget _adbPathSettings() {
    return BlocBuilder<SettingsCubit, SettingsState>(
      buildWhen: (oldState, state) => oldState.adbPath != state.adbPath,
      builder: (context, state) {
        return MultiActionSetting(
          name: context.strings.adbSettings,
          description: state.adbPath,
          actions: [
            // Scan for file
            Optional.hidden(
                hide: Platform.isWindows, child: _adbLookupButton(context)),
            // pick file manually
            PathPickerButton(
              dialogTitle: context.strings.pickAdbPath,
              onPathSelected: (path) => context.settings.setAdbPath(path),
            ),
          ],
        );
      },
    );
  }

  Widget _adbLookupButton(BuildContext context) {
    return IconButton(
      onPressed: () async {
        String? adbPath = await Adb.lookupPath();
        if (!context.mounted) return;
        if (adbPath != null && adbPath.isNotEmpty) {
          context.settings.setAdbPath(adbPath);
          context.messenger.showSnackBar(
            SnackBarFactory.getPositiveSnackBar(context,
                text: context.strings.pathFound),
          );
        } else {
          InfoDialog.showError(
            context,
            content: context.strings.adbNotFound,
          );
        }
      },
      icon: Icon(context.icons.search),
    );
  }

  Widget _adbDeviceSettings() {
    return BlocBuilder<SessionCubit, SessionState>(
      buildWhen: (oldState, state) => oldState.adbDevice != state.adbDevice,
      builder: (context, state) {
        return MultiActionSetting(
          name: context.strings.adbDeviceSettings,
          description: state.adbDevice,
          actions: [
            DropdownMenu<String>(
              key: Key(state.adbDevice),
              width: 250,
              initialSelection: state.adbDevice,
              requestFocusOnTap: false,
              onSelected: (s) => s != null
                  ? context.read<SessionCubit>().setAdbDevice(s)
                  : null,
              dropdownMenuEntries: state.adbDevices
                  .map((d) => DropdownMenuEntry<String>(value: d, label: d))
                  .toList(),
            ),
            // Scan for devices
            IconButton(
              onPressed: () => context.read<SessionCubit>().loadAdbDevices(),
              icon: Icon(context.icons.reload),
            ),
          ],
        );
      },
    );
  }

  Widget _tsharkPathSettings() {
    return BlocBuilder<SettingsCubit, SettingsState>(
      buildWhen: (oldState, state) => oldState.tsharkPath != state.tsharkPath,
      builder: (context, state) {
        return MultiActionSetting(
          name: context.strings.tsharkSettings,
          description: state.tsharkPath,
          actions: [
            // Scan for file
            Optional.hidden(
                hide: Platform.isWindows, child: _tsharkLookupButton(context)),
            // pick file manually
            PathPickerButton(
              dialogTitle: context.strings.pickTsharkPath,
              onPathSelected: (path) {
                context.settings.setTsharkPath(path);
                context.session.loadNetworkInterfaces();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _tsharkLookupButton(BuildContext context) {
    return IconButton(
      onPressed: () async {
        String? tsharkPath = await Tshark.lookupPath();
        if (!context.mounted) return;
        if (tsharkPath != null && tsharkPath.isNotEmpty) {
          context.settings.setTsharkPath(tsharkPath);
          context.messenger.showSnackBar(
            SnackBarFactory.getPositiveSnackBar(context,
                text: context.strings.pathFound),
          );
        } else {
          InfoDialog.showError(
            context,
            content: context.strings.tsharkNotFound,
          );
        }
      },
      icon: Icon(context.icons.search),
    );
  }

  Widget _recorderSettings() {
    return BlocBuilder<SettingsCubit, SettingsState>(
      buildWhen: (oldState, state) =>
          oldState.recorderVersion != state.recorderVersion,
      builder: (context, state) {
        return SimpleSetting(
          name: "Device Architecture",
          description: "Select the version that matches your target device (Android)",
          action:
          DropdownMenu<String>(
            key: Key(state.recorderVersion),
            width: 250,
            initialSelection: state.recorderVersion,
            requestFocusOnTap: false,
            onSelected: (r) => r != null
                ? context.settings.setRecorder(r)
                : null,
            dropdownMenuEntries: SettingsState.recorderVersions
                .map((d) => DropdownMenuEntry<String>(value: d, label: d))
                .toList(),
          ),
        );
      },
    );
  }
}
