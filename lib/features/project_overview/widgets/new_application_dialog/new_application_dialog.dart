import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/data/data.dart';
import 'package:permission_analyzer_gui/features/project_overview/widgets/new_application_dialog/logic/context_extension.dart';
import 'package:permission_analyzer_gui/features/project_overview/widgets/new_application_dialog/logic/new_application_dialog_cubit.dart';

class NewApplicationDialog extends StatelessWidget {
  const NewApplicationDialog({
    required this.existingApplications,
    super.key,
  });

  final List<String> existingApplications;

  static const double dialogWidth = 420;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewApplicationDialogCubit(
        context.settings,
        context.session,
        existingApplications,
      ),
      child: BlocBuilder<NewApplicationDialogCubit, NewApplicationDialogState>(
        buildWhen: (oldState, state) => oldState.searching != state.searching,
        builder: (context, state) {
          return CustomDialog(
            expand: false,
            title: "New Application",
            titleTrailing:
                state.searching ? const CircularProgressIndicator() : null,
            content: _buildContent(context),
            actions: [
              _cancelButton(context),
              Optional.hidden(
                hide: Platform.isWindows,
                child: _loadIconButton(),
              ),
              _createButton(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return SizedBox(
      width: dialogWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          _deviceSelection(context),
          _applicationSelection(),
          _applicationName(),
        ].insertBetweenItems(() => Margin.vertical(context.constants.spacing)),
      ),
    );
  }

  Widget _cancelButton(BuildContext context) {
    return IconTextButton(
        text: "Cancel",
        icon: Icon(context.icons.cancel),
        onTap: () {
          context.newApplicationDialogCubit.cleanup();
          context.navigator.pop(null);
        });
  }

  Widget _createButton() {
    return BlocBuilder<NewApplicationDialogCubit, NewApplicationDialogState>(
      buildWhen: (oldState, state) =>
          oldState.searching != state.searching ||
          oldState.adbDevice != state.adbDevice ||
          oldState.applicationId != state.applicationId ||
          oldState.name != state.name ||
          oldState.iconPath != state.iconPath,
      builder: (context, state) {
        bool isEnabled = !state.searching &&
            state.adbDevice.isNotEmpty &&
            state.applicationId.isNotEmpty &&
            state.name.isNotEmpty;
        return Optional.tooltip(
          tooltip: state.searching
              ? "Wait for icon lookup to finish..."
              : state.adbDevice.isEmpty
                  ? "No device is selected."
                  : state.applicationId.isEmpty
                      ? "No application selected."
                      : state.name.isEmpty
                          ? "Please enter a name for the application."
                          : "",
          show: !isEnabled,
          child: IconTextButton(
            text: "Create",
            enabled: isEnabled,
            icon: Icon(context.icons.add),
            onTap: () => context.navigator.pop(state.application),
          ),
        );
      },
    );
  }

  Widget _loadIconButton() {
    return BlocBuilder<NewApplicationDialogCubit, NewApplicationDialogState>(
      buildWhen: (oldState, state) =>
          oldState.name != state.name ||
          oldState.searching != state.searching ||
          oldState.iconFound != state.iconFound ||
          oldState.applicationId != state.applicationId,
      builder: (context, state) {
        return IconTextButton(
          text: "Load Icon",
          icon: Icon(context.icons.search),
          onTap:
              state.searching || state.iconFound || state.applicationId.isEmpty
                  ? null
                  : () => context.newApplicationDialogCubit.extractAppIcon(),
        );
      },
    );
  }

  Widget _deviceSelection(BuildContext context) {
    return BlocBuilder<NewApplicationDialogCubit, NewApplicationDialogState>(
      buildWhen: (oldState, state) => oldState.adbDevice != state.adbDevice,
      builder: (context, state) {
        return DropdownMenu(
          label: const Text("Select a device"),
          width: dialogWidth,
          onSelected: (dev) => dev != null
              ? context.newApplicationDialogCubit.selectAdbDevice(dev)
              : null,
          requestFocusOnTap: false,
          initialSelection: state.adbDevice,
          dropdownMenuEntries: context.session.state.adbDevices
              .map((dev) => DropDownMenuFactory.dropdownMenuEntry(
                    context,
                    value: dev,
                    label: dev,
                  ))
              .toList(),
        );
      },
    );
  }

  Widget _applicationSelection() {
    return BlocBuilder<NewApplicationDialogCubit, NewApplicationDialogState>(
      buildWhen: (oldState, state) =>
          oldState.applications != state.applications ||
          oldState.applicationId != state.applicationId,
      builder: (context, state) {
        return DropdownMenu(
          label: const Text("Select an application"),
          width: dialogWidth,
          onSelected: (a) => a != null
              ? context.newApplicationDialogCubit.selectApplication(a)
              : null,
          requestFocusOnTap: false,
          initialSelection: state.applicationId,
          dropdownMenuEntries: state.applications
              .map((a) => DropDownMenuFactory.dropdownMenuEntry(context,
                  value: a, label: a))
              .toList(),
        );
      },
    );
  }

  Widget _applicationName() {
    return BlocBuilder<NewApplicationDialogCubit, NewApplicationDialogState>(
      buildWhen: (oldState, state) =>
          oldState.applicationId != state.applicationId,
      builder: (context, state) => SimpleTextField(
        initialValue: state.name,
        labelText: "Application Name",
        onChanged: (n) => context.newApplicationDialogCubit.selectName(n),
      ),
    );
  }

  static Future<TestApplication?> newApplication(
    BuildContext context,
    List<TestApplication> existingApplications,
  ) async {
    if (context.mounted) {
      return showDialog<TestApplication?>(
          context: context,
          builder: (context) => NewApplicationDialog(
              existingApplications:
                  existingApplications.map((a) => a.id).toList()));
    }
    return null;
  }
}
