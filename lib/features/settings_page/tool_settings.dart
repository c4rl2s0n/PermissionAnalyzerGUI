import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/features/settings_page/widgets/multi_action_setting.dart';

import 'widgets/widgets.dart';

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
        _recorderPathSettings(),
        _recorderDestinationPathSettings(),
        _inputRecordDestinationPathSettings(),
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
            IconButton(
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
            ),
            // pick file manually
            IconButton(
              onPressed: () async {
                FilePickerResult? file = await FilePickerFactory.getFilePicker()
                    .pickFiles(dialogTitle: context.strings.pickAdbPath);
                if (!context.mounted) return;
                String? adbPath = file?.files.firstOrNull?.path;
                if (adbPath != null && adbPath.isNotEmpty) {
                  context.settings.setAdbPath(adbPath);
                }
              },
              icon: Icon(context.icons.pickFile),
            ),
          ],
        );
      },
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
            BlocBuilder<SessionCubit, SessionState>(
              buildWhen: (oldState, state) =>
                  oldState.adbDevices != state.adbDevices,
              builder: (context, state) {
                return DropdownMenu<String>(
                  width: 250,
                  initialSelection: state.adbDevice,
                  requestFocusOnTap: false,
                  onSelected: (s) => s != null
                      ? context.read<SessionCubit>().setAdbDevice(s)
                      : null,
                  dropdownMenuEntries: state.adbDevices
                      .map((d) => DropdownMenuEntry<String>(value: d, label: d))
                      .toList(),
                );
              },
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
            IconButton(
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
            ),
            // pick file manually
            IconButton(
              onPressed: () async {
                FilePickerResult? file = await FilePickerFactory.getFilePicker()
                    .pickFiles(dialogTitle: context.strings.pickTsharkPath);
                if (!context.mounted) return;
                String? tsharkPath = file?.files.firstOrNull?.path;
                if (tsharkPath != null && tsharkPath.isNotEmpty) {
                  context.settings.setTsharkPath(tsharkPath);
                }
              },
              icon: Icon(context.icons.pickFile),
            ),
          ],
        );
      },
    );
  }

  Widget _recorderPathSettings() {
    return BlocBuilder<SettingsCubit, SettingsState>(
      buildWhen: (oldState, state) =>
          oldState.recorderPath != state.recorderPath,
      builder: (context, state) {
        return SimpleSetting(
          name: context.strings.recorderLocalSettings,
          description: state.recorderPath,
          action: IconButton(
            onPressed: () async {
              FilePickerResult? file = await FilePickerFactory.getFilePicker()
                  .pickFiles(dialogTitle: context.strings.pickRecorderPath);
              if (!context.mounted) return;
              String? recorderPath = file?.files.firstOrNull?.path;
              if (recorderPath != null && recorderPath.isNotEmpty) {
                context.settings.setRecorderPath(recorderPath);
              }
            },
            icon: Icon(context.icons.pickFile),
          ),
        );
      },
    );
  }

  Widget _recorderDestinationPathSettings() {
    return BlocBuilder<SettingsCubit, SettingsState>(
      buildWhen: (oldState, state) =>
          oldState.recorderDestinationPath != state.recorderDestinationPath,
      builder: (context, state) {
        return SimpleSetting(
          name: context.strings.recorderDestinationSettings,
          description: context.strings.recorderDestinationSettingsDescription,
          action: SimpleTextField(
            initialValue: state.recorderDestinationPath,
            labelText: context.strings.path,
            onChanged: (s) => context.settings.setRecorderDestinationPath(s),
          ),
        );
      },
    );
  }

  Widget _inputRecordDestinationPathSettings() {
    return BlocBuilder<SettingsCubit, SettingsState>(
      buildWhen: (oldState, state) =>
          oldState.inputRecordDestinationPath !=
          state.inputRecordDestinationPath,
      builder: (context, state) {
        return SimpleSetting(
          name: "User Input Record Destination Path",
          description:
              "Location where the record of the user input will be stored on the test device",
          action: SimpleTextField(
            initialValue: state.inputRecordDestinationPath,
            labelText: context.strings.path,
            onChanged: (s) => context.settings.setInputRecordDestinationPath(s),
          ),
        );
      },
    );
  }
}
