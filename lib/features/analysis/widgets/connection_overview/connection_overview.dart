import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/features/analysis/widgets/config_builder.dart';

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
    return ConfigBuilder(
        buildWhenAnalysis: (oldState, state) => oldState.visibleConnections != state.visibleConnections,
        buildWhenAnalysisConfig: (oldState, state) =>
            oldState.groupConnections != state.groupConnections,
        builder: (context, analysisState, configState) => BlocProvider(
              key: Key(
                  "ConnectionOverviewCubitProvider_${configState.groupConnections}"),
              create: (context) => ConnectionOverviewCubit(
                analysisState.visibleConnections,
                //selectedIndex: lastSelected,
              ),
              child: _buildContent(context),
            ));
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
                children: [
                  Expanded(
                      child: ConnectionOverviewTable(
                    initialSelectionIndex: lastSelected,
                  ))
                ],
              ),
            ),
            if (state.selectedConnection != null) ...[
              Margin.horizontal(context.constants.spacing),
              SizedBox(
                width: 400,
                child: Column(
                  children: [
                    TrafficDistributionChart(
                        connection: state.selectedConnection!),
                    ProtocolDistributionChart(
                        connection: state.selectedConnection!),
                    // Expanded(
                    //   child: ConnectionTrafficOverview(
                    //     state.selectedConnection!,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
