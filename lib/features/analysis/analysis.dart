import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/data/data.dart';
import 'package:permission_analyzer_gui/data/models/models.dart' as models;
import 'package:permission_analyzer_gui/features/features.dart';

import 'logic/logic.dart';
import 'widgets/widgets.dart';

class Analysis extends StatefulWidget {
  const Analysis(this.scenarios, {super.key});

  final List<models.TestScenario> scenarios;

  @override
  State<Analysis> createState() => _AnalysisState();
}

class _AnalysisState extends State<Analysis> {
  List<_NavigationRailEntry> navigationEntries = [];
  int selectedIndex = 0;

  Widget view(BuildContext context) {
    _NavigationRailEntry ne = navigationEntries[selectedIndex];
    Widget view = ne.getView(context);
    return ne.noPadding
        ? view
        : Padding(
            padding: EdgeInsets.all(context.constants.spacing),
            child: view,
          );
  }

  NavigationRailDestination _getNavigationRailDestination(
    BuildContext context, {
    required String label,
    required IconData icon,
  }) {
    Color iconColor = context.colors.onPrimary;
    return NavigationRailDestination(
      icon: Icon(
        icon,
        color: iconColor,
      ),
      selectedIcon: Icon(icon),
      label: Text(label),
    );
  }

  void initNavigationEntries(BuildContext context) {
    if (navigationEntries.isNotEmpty) return;
    navigationEntries = [
      _NavigationRailEntry(
        destination: _getNavigationRailDestination(
          context,
          label: "Groups",
          icon: context.icons.overview,
        ),
        getView: (c) => const TrafficGroupOverview(),
      ),
      _NavigationRailEntry(
        destination: _getNavigationRailDestination(
          context,
          label: "Connections",
          icon: context.icons.connections,
        ),
        getView: (c) => const ConnectionOverview(),
      ),
      _NavigationRailEntry(
        destination: _getNavigationRailDestination(
          context,
          label: "Graph",
          icon: context.icons.graph,
        ),
        getView: (c) => const EndpointGraph(),
        noPadding: true,
      ),
      _NavigationRailEntry(
        destination: _getNavigationRailDestination(
          context,
          label: "Geolocation",
          icon: context.icons.map,
        ),
        getView: (c) => const EndpointMap(),
        noPadding: true,
      ),
      _NavigationRailEntry(
        destination: _getNavigationRailDestination(
          context,
          label: "Recordings",
          icon: context.icons.recording,
        ),
        getView: (c) => const ScreenRecordOverview(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PageComponentFactory.scaffold(
      context,
      withPadding: false,
      appBar: PageComponentFactory.appBar(context, title: "Analysis", actions: [
        PageComponentFactory.navigationIconButton(
          context,
          () => const SettingsPage(),
          context.icons.settings,
        )
      ]),
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    initNavigationEntries(context);
    return BlocProvider<AnalysisCubit>(
        create: (context) => AnalysisCubit(
              scenarios: widget.scenarios,
              testScenarioRepository: Modular.get<ITestScenarioRepository>(),
              networkEndpointRepository:
                  Modular.get<INetworkEndpointRepository>(),
              settingsCubit: context.settings,
            ),
        child: BlocBuilder<AnalysisCubit, AnalysisState>(
            buildWhen: (oldState, state) =>
                oldState.configCubit != state.configCubit,
            builder: (context, state) =>
                BlocProvider<AnalysisConfigCubit>(
                    create: (context) => state.configCubit,
                    child: Row(
                      children: [
                        NavigationRail(
                          backgroundColor: context.colors.primary,
                          selectedLabelTextStyle: context.textTheme.labelSmall,
                          unselectedLabelTextStyle: context.textTheme.labelSmall
                              ?.copyWith(
                                  color: context.textTheme.labelSmall?.color
                                      ?.withOpacity(
                                          context.constants.lightColorOpacity)),
                          labelType: NavigationRailLabelType.all,
                          selectedIndex: selectedIndex,
                          onDestinationSelected: (i) => setState(() {
                            selectedIndex = i;
                          }),
                          destinations: navigationEntries
                              .map((ne) => ne.destination)
                              .toList(),
                        ),
                        Expanded(child: view(context)),
                      ],
                    ))));
  }
}

class _NavigationRailEntry {
  _NavigationRailEntry({
    required this.destination,
    required this.getView,
    this.noPadding = false,
  });
  NavigationRailDestination destination;
  Widget Function(BuildContext) getView;
  bool noPadding;
}
