import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/features/analysis/logic/logic.dart';

import 'widgets/widgets.dart';

class TrafficGroupOverview extends StatelessWidget {
  const TrafficGroupOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
            flex: 3,
            child: Column(
              children: <Widget>[
                const Flexible(child: TrafficGroupOverviewTable()),
                //const Flexible(child: EndpointOverviewTable()),
              ].insertBetweenItems(
                  () => Margin.vertical(context.constants.spacing)),
            )),
        Flexible(
          flex: 1,
          child: Column(
            children: [
              const Expanded(child: TrafficGroupSelector()),
              Margin.vertical(context.constants.spacing),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _reAnalyzeButton(context),
                ],
              ),
            ],
          ),
        ),
      ].insertBetweenItems(() => Margin.horizontal(context.constants.spacing)),
    );
  }

  Widget _reAnalyzeButton(BuildContext context) {
    return BlocBuilder<AnalysisCubit, AnalysisState>(
      buildWhen: (oldState, state) =>
          oldState.analyzingTraffic != state.analyzingTraffic,
      builder: (context, state) {
        return state.analyzingTraffic
            ? const CircularProgressIndicator()
            : IconTextButton(
                text: "Re-Analyze",
                icon: Icon(context.icons.reload),
                onTap: () => context.analysisCubit.rerunAnalysis(),
              );
      },
    );
  }
}
