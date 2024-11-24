import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/data/repositories/repositories.dart';
import 'package:permission_analyzer_gui/data/models/models.dart' as model;
import 'package:permission_analyzer_gui/features/features.dart';
import 'package:permission_analyzer_gui/features/project_overview/logic/context_extension.dart';
import 'package:permission_analyzer_gui/features/project_overview/logic/project_overview_cubit.dart';
import 'package:permission_analyzer_gui/features/project_overview/widgets/widgets.dart';

class ProjectOverview extends StatelessWidget {
  const ProjectOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return PageComponentFactory.scaffold(
      context,
      appBar:
          PageComponentFactory.appBar(context, title: "Applications", actions: [
        PageComponentFactory.navigationIconButton(
          context,
          () => Analysis(Modular.get<ITestScenarioRepository>().getAll()),
          context.icons.analysis,
        ),
        PageComponentFactory.navigationIconButton(
          context,
          () => const SettingsPage(),
          context.icons.settings,
        ),
      ]),
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return BlocProvider<ProjectOverviewCubit>(
        create: (context) =>
            ProjectOverviewCubit(Modular.get<ITestApplicationRepository>()),
        child: Builder(builder: (context) {
          return Column(
            children: [
              Expanded(child: _overview()),
              _actions(context),
            ].insertBetweenItems(
                () => Margin.vertical(context.constants.spacing)),
          );
        }));
  }

  Widget _actions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _newApplicationButton(),
      ],
    );
  }

  Widget _newApplicationButton() {
    return BlocBuilder<ProjectOverviewCubit, ProjectOverviewState>(
      buildWhen: (oldState, state) =>
          oldState.applications != state.applications,
      builder: (context, state) => IconTextButton(
          text: "New Application",
          icon: Icon(context.icons.add),
          onTap: () async {
            model.TestApplication? newApplication =
                await NewApplicationDialog.newApplication(
              context,
              state.applications,
            );
            if (context.mounted && newApplication != null) {
              context.projectOverviewCubit.createApplication(newApplication);
            }
          }),
    );
  }

  Widget _overview() {
    return BlocBuilder<ProjectOverviewCubit, ProjectOverviewState>(
      buildWhen: (oldState, state) =>
          oldState.applications != state.applications,
      builder: (context, state) {
        double tileWidth = 130;
        double tileHeight = tileWidth * 1.2;
        return LayoutBuilder(
          builder: (context, constraints) => GridView.count(
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.all(context.constants.spacing),
              shrinkWrap: true,
              crossAxisSpacing: context.constants.largeSpacing,
              mainAxisSpacing: context.constants.largeSpacing,
              childAspectRatio: tileWidth / tileHeight,
              crossAxisCount: (constraints.maxWidth / tileWidth).floor(),
              children: state.applications
                  .map((a) => AppEntry(
                        application: a,
                        width: tileWidth,
                        height: tileHeight,
                      ))
                  .toList()),
        );
      },
    );
  }
}
