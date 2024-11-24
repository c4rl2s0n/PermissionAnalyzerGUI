import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_analyzer_gui/features/analysis/widgets/endpoint_analysis/logic/analysis_traffic_group_cubit.dart';

import 'endpoint_analysis_cubit.dart';

extension CtxEndpointAnalysisCubit on BuildContext {
  AnalysisTrafficGroupCubit get analysisTrafficGroupCubit =>
      read<AnalysisTrafficGroupCubit>();
  EndpointAnalysisCubit get endpointAnalysisCubit =>
      read<EndpointAnalysisCubit>();
}
