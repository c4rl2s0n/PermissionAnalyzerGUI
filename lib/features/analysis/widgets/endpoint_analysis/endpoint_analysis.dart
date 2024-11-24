import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/data/data.dart';
import 'package:permission_analyzer_gui/data/models/models.dart' as models;
import 'package:permission_analyzer_gui/features/analysis/widgets/endpoint_analysis/logic/endpoint_analysis_cubit.dart';

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
  Widget view(BuildContext context) =>
      navigationEntries[selectedIndex].getView(context);

  NavigationRailDestination _getNavigationRailDestination(
    BuildContext context, {
    required String label,
    required IconData icon,
    required IconData selectedIcon,
  }) {
    Color iconColor = context.colors.onPrimary;
    return NavigationRailDestination(
      icon: Icon(
        icon,
        color: iconColor,
      ),
      selectedIcon: Icon(selectedIcon),
      label: Text(label),
    );
  }

  void initNavigationEntries(BuildContext context) {
    if (navigationEntries.isNotEmpty) return;
    navigationEntries = [
      _NavigationRailEntry(
        _getNavigationRailDestination(
          context,
          label: "Overview",
          icon: context.icons.overview,
          selectedIcon: context.icons.overviewSelected,
        ),
        (c) => const EndpointOverview(),
      ),
      _NavigationRailEntry(
        _getNavigationRailDestination(
          context,
          label: "Graph",
          icon: context.icons.graph,
          selectedIcon: context.icons.graphSelected,
        ),
        (c) => const EndpointGraph(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    initNavigationEntries(context);
    return BlocProvider(
      create: (context) => EndpointAnalysisCubit(
        widget.scenarios,
        Modular.get<ITestScenarioRepository>(),
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
  _NavigationRailEntry(this.destination, this.getView);
  NavigationRailDestination destination;
  Widget Function(BuildContext) getView;
}
