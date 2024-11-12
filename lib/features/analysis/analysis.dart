import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/data/models/models.dart' as models;
import 'package:permission_analyzer_gui/features/features.dart';

import 'logic/logic.dart';
import 'widgets/endpoint_analysis/endpoint_analysis.dart';
import 'widgets/widgets.dart';

class Analysis extends StatelessWidget {
  const Analysis(this.model, {super.key});

  final models.Analysis model;

  @override
  Widget build(BuildContext context) {
    return PageComponentFactory.scaffold(
      context,
      appBar: PageComponentFactory.appBar(context,
          title: context.strings.testScenario,
          actions: [
            PageComponentFactory.navigationIconButton(
              context,
                  () => const SettingsPage(),
              context.icons.settings,
            )
          ]),
      body: BlocProvider(
        create: (context) =>
            AnalysisCubit(
              model: model,
            ),
        child: _buildContent(context),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(shape: BoxShape.rectangle),
      child:BlocBuilder<AnalysisCubit, AnalysisState>(
        buildWhen: (oldState, state) => oldState.endpointAnalysis != state.endpointAnalysis,
        builder: (context, state) {
          if(state.endpointAnalysis != null) {
            return EndpointAnalysis(analysis: state.endpointAnalysis!);
          }
          return const Placeholder();
        },
      ), //RadarChartSample1(),
    );
  }
}
