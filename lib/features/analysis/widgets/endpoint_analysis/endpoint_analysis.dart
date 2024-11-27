import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/data/data.dart';
import 'package:permission_analyzer_gui/data/models/models.dart' as models;
import 'package:permission_analyzer_gui/features/analysis/widgets/endpoint_analysis/logic/endpoint_analysis_cubit.dart';
import 'package:permission_analyzer_gui/features/analysis/widgets/endpoint_analysis/widgets/test_run_analysis/test_run_analysis.dart';

import 'widgets/widgets.dart';

class EndpointAnalysis extends StatefulWidget {
  const EndpointAnalysis({
    required this.scenarios,
    super.key,
  });

  final List<models.TestScenario> scenarios;

  @override
  State<EndpointAnalysis> createState() => _EndpointAnalysisState();
}

class _EndpointAnalysisState extends State<EndpointAnalysis> {
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
          label: "Tests",
          icon: context.icons.tests,
        ),
        getView: (c) => const TestRunAnalysis(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    initNavigationEntries(context);
    return BlocProvider(
      create: (context) => EndpointAnalysisCubit(
        scenarios: widget.scenarios,
        testScenarioRepository: Modular.get<ITestScenarioRepository>(),
        settingsCubit: context.settings,
      ),
      child: Builder(builder: (context) {
        return Row(
          children: [
            NavigationRail(
              backgroundColor: context.colors.primary,
              selectedLabelTextStyle: context.textTheme.labelSmall,
              unselectedLabelTextStyle: context.textTheme.labelSmall?.copyWith(
                  color: context.textTheme.labelSmall?.color
                      ?.withOpacity(context.constants.subtleColorOpacity)),
              labelType: NavigationRailLabelType.all,
              selectedIndex: selectedIndex,
              onDestinationSelected: (i) => setState(() {
                selectedIndex = i;
              }),
              destinations:
                  navigationEntries.map((ne) => ne.destination).toList(),
            ),
            Expanded(child: view(context)),
          ],
        );
      }),
    );
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
