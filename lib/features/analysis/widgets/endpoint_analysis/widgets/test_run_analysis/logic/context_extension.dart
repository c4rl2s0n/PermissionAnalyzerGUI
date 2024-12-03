import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'test_run_analysis_cubit.dart';


extension CtxTestRunAnalysisCubit on BuildContext {
  TestRunAnalysisCubit get testRunAnalysisCubit => read<TestRunAnalysisCubit>();
}
