import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/data/data.dart';
import 'package:permission_analyzer_gui/features/features.dart' as feature;
import 'package:permission_analyzer_gui/features/project_overview/logic/context_extension.dart';

class AppEntry extends StatelessWidget {
  const AppEntry({
    required this.application,
    this.width = 50,
    this.height = 70,
    super.key,
  });

  final TestApplication application;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onSecondaryTapDown: (details) => _handleContextMenu(context, details),
      child: SizedBox(
        width: width,
        height: height,
        child: TapContainer(
          onTap: () => _onAppSelect(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Margin.vertical(context.constants.smallSpacing),
              if (application.iconPath != null &&
                  application.iconPath!.isNotEmpty) ...[
                Expanded(
                  child: Image.file(
                    File(application.iconPath!),
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ] else ...[
                Expanded(
                    child: Icon(
                  context.icons.question,
                  size: width / 2,
                )),
              ],
              Margin.vertical(context.constants.smallSpacing),
              Text(
                application.name,
                style:
                    context.textTheme.labelLarge?.copyWith(fontSize: width / 8),
              ),
              _deviceLabel(context),
              Margin.vertical(context.constants.smallSpacing),
            ],
          ),
        ),
      ),
    );
  }

  void _onAppSelect(BuildContext context)async{
    // select the correct device for the application, if connected
    if(context.session.state.deviceConnected(application.device)){
      context.session.setAdbDevice(application.device);
    }
    if(context.mounted) {
      context.navigator.navigateTo(
          feature.TestApplication(application: application));
    }
  }
  void _handleContextMenu(BuildContext context, TapDownDetails details){
      Map<String, void Function(BuildContext)> options = {
        'Delete': (context) =>
            context.projectOverviewCubit.delete(application)
      };
      showMenu(
        context: context,
        position: RelativeRect.fromLTRB(
          details.globalPosition.dx,
          details.globalPosition.dy,
          details.globalPosition.dx,
          details.globalPosition.dy,
        ),
        items: options.keys
            .map((name) => PopupMenuItem(
          child: Text(name),
          onTap: () => options[name]!(context),
        ))
            .toList(),
      );
  }

  // print the name of the device, indicating if it is currently connected
  Widget _deviceLabel(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(
      buildWhen: (oldState, state) => oldState.adbDevices != state.adbDevices,
      builder: (context, state) {
        bool deviceAvailable = state.deviceConnected(application.device);
        return Text(
          application.device,
          style: context.textTheme.labelLarge?.copyWith(
            fontSize: width / 12,
            color: deviceAvailable
                ? context.colors.positive
                : context.colors.negative,
          ),
        );
      },
    );
  }
}
