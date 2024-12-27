import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/data/data.dart';
import 'package:permission_analyzer_gui/features/project_overview/widgets/new_application_dialog/logic/context_extension.dart';
import 'package:permission_analyzer_gui/features/project_overview/widgets/new_application_dialog/logic/new_application_dialog_cubit.dart';

class NewApplicationDialog extends StatelessWidget {
  const NewApplicationDialog({
    required this.applications,
    super.key,
  });

  final List<String> applications;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewApplicationDialogCubit(
        context.settings,
        context.session,
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
              _loadIconButton(),
              _createButton(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _applicationSelection(),
        _applicationName(),
      ].insertBetweenItems(() => Margin.vertical(context.constants.spacing)),
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
          oldState.applicationId != state.applicationId ||
          oldState.name != state.name ||
          oldState.iconPath != state.iconPath,
      builder: (context, state) {
        return IconTextButton(
          text: "Create",
          icon: Icon(context.icons.add),
          onTap: () => context.navigator.pop(state.application),
        );
      },
    );
  }

  Widget _loadIconButton() {
    return BlocBuilder<NewApplicationDialogCubit, NewApplicationDialogState>(
      buildWhen: (oldState, state) =>
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

  Widget _applicationSelection() {
    return BlocBuilder<NewApplicationDialogCubit, NewApplicationDialogState>(
      buildWhen: (oldState, state) =>
          oldState.applicationId != state.applicationId,
      builder: (context, state) {
        return DropdownMenu(
          label: const Text("Select the application"),
          onSelected: (a) => a != null
              ? context.newApplicationDialogCubit.selectApplication(a)
              : null,
          requestFocusOnTap: false,
          initialSelection: state.applicationId,
          dropdownMenuEntries: applications
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
    List<String> applications =
        await Adb(context.settings, device: context.session.state.adbDevice)
            .getApplications();
    List<String> newApplications = applications
        .where((a) => !existingApplications.any((ea) => ea.id == a))
        .toList();
    if (context.mounted) {
      return showDialog<TestApplication?>(
          context: context,
          builder: (context) =>
              NewApplicationDialog(applications: newApplications));
    }
    return null;
  }
}
