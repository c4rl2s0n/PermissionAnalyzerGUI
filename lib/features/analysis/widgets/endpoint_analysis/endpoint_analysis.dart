import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_analyzer_gui/data/models/models.dart' as models;
import 'package:permission_analyzer_gui/features/analysis/widgets/endpoint_analysis/logic/endpoint_analysis_cubit.dart';

import 'widgets/widgets.dart';

class EndpointAnalysis extends StatelessWidget {
  const EndpointAnalysis({required this.analysis, super.key});

  final models.EndpointAnalysis analysis;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EndpointAnalysisCubit(model: analysis),
      child: BlocBuilder<EndpointAnalysisCubit, EndpointAnalysisState>(
        builder: (context, state) => const EndpointGraph(),
      ),
    );
  }
}
