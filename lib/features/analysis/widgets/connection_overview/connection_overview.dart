import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/features/analysis/logic/logic.dart';

import 'logic/logic.dart';
import 'widgets/widgets.dart';

class ConnectionOverview extends StatelessWidget {
  const ConnectionOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnalysisCubit, AnalysisState>(
      builder: (context, state) {
        return BlocProvider(
          create: (context) => ConnectionOverviewCubit(
            state.connections,
            state.networkPackets,
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
      builder: (context, state) => Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          const Expanded(
            flex: 3,
            child: Column(
              children: [Expanded(child: ConnectionOverviewTable())],
            ),
          ),
          if (state.selectedConnection != null) ...[
            Margin.horizontal(context.constants.spacing),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Expanded(
                    child: ConnectionTrafficOverview(
                      state.selectedConnection!,
                      state.selectedConnectionPackets,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
