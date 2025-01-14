import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_analyzer_gui/features/analysis/logic/logic.dart';

class ConfigBuilder extends StatelessWidget {
  const ConfigBuilder({
    this.buildWhenAnalysis,
    this.buildWhenAnalysisConfig,
    required this.builder,
    super.key,
  });
  final bool Function(AnalysisState, AnalysisState)? buildWhenAnalysis;
  final bool Function(AnalysisConfigState, AnalysisConfigState)?
      buildWhenAnalysisConfig;
  final Widget Function(BuildContext, AnalysisState, AnalysisConfigState)
      builder;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnalysisCubit, AnalysisState>(
      buildWhen: buildWhenAnalysis,
      builder: (context, analysisState) => BlocBuilder<AnalysisConfigCubit, AnalysisConfigState>(
        buildWhen: buildWhenAnalysisConfig,
        builder: (context, configState) =>
            builder(context, analysisState, configState),
      ),
    );
  }
}
