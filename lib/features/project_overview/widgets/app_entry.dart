import 'dart:io';

import 'package:flutter/material.dart';
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
      onSecondaryTapDown: (details) {
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
      },
      child: SizedBox(
        width: width,
        height: height,
        child: TapContainer(
          onTap: () => context.navigator
              .navigateTo(feature.TestApplication(application: application)),
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
              Margin.vertical(context.constants.smallSpacing),
            ],
          ),
        ),
      ),
    );
  }
}
