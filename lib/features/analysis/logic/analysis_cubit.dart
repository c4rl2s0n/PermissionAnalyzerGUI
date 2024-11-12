import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:permission_analyzer_gui/data/models/models.dart';

part 'analysis_cubit.freezed.dart';

class AnalysisCubit extends Cubit<AnalysisState> {
  AnalysisCubit({
    required this.model,
  }) : super(AnalysisState.fromAnalysis(model));

  final Analysis model;
}

@freezed
class AnalysisState with _$AnalysisState {
  const factory AnalysisState({
    required EndpointAnalysis? endpointAnalysis,
  }) = _AnalysisState;
  factory AnalysisState.fromAnalysis(Analysis analysis) =>
      AnalysisState(endpointAnalysis: analysis.endpointAnalysis);
}
