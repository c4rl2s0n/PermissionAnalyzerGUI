import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/features/analysis/logic/logic.dart';

import 'logic/logic.dart';
import 'widgets/widgets.dart';

class ConnectionOverview extends StatefulWidget {
  const ConnectionOverview({super.key});

  @override
  State<ConnectionOverview> createState() => _ConnectionOverviewState();
}

class _ConnectionOverviewState extends State<ConnectionOverview> {
  int? lastSelected;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnalysisCubit, AnalysisState>(
      buildWhen: (oldState, state) => oldState.connections != state.connections,
      builder: (context, state) {
        return BlocProvider(
          create: (context) => ConnectionOverviewCubit(
            state.connections,
            selectedIndex: lastSelected,
          ),
          child: _buildContent(context),
        );
      },
    );
  }

  Widget _buildContent(BuildContext context) {
    return BlocBuilder<ConnectionOverviewCubit, ConnectionOverviewState>(
      buildWhen: (oldState, state) =>
          oldState.selectedConnection != state.selectedConnection,
      builder: (context, state) {
        lastSelected = state.selectedIndex;
        return Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 3,
            child: Column(
              children: [Expanded(child: ConnectionOverviewTable(initialSelectionIndex: lastSelected,))],
            ),
          ),
          if (state.selectedConnection != null) ...[
            Margin.horizontal(context.constants.spacing),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Expanded(
                    child: GroupSeparationDiagram(
                      connection: state.selectedConnection!,
                    ),
                  ),
                  Expanded(
                    child: ConnectionTrafficOverview(
                      state.selectedConnection!,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      );},
    );
  }
}
