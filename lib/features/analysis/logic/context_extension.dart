import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'analysis_cubit.dart';

extension CtxAnalysisCubit on BuildContext {
  AnalysisCubit get testScenarioCubit => read<AnalysisCubit>();
}
