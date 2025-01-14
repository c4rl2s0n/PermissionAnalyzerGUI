import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_analyzer_gui/features/analysis/logic/analysis_config_cubit.dart';

import 'analysis_cubit.dart';
import 'analysis_traffic_group_cubit.dart';

extension CtxAnalysisCubit on BuildContext {
  AnalysisTrafficGroupCubit get analysisTrafficGroupCubit =>
      read<AnalysisTrafficGroupCubit>();
  AnalysisCubit get analysisCubit => read<AnalysisCubit>();
  AnalysisConfigCubit get analysisConfigCubit => read<AnalysisConfigCubit>();
}
