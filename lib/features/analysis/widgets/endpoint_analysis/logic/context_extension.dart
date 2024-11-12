import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'endpoint_analysis_cubit.dart';

extension CtxEndpointAnalysisCubit on BuildContext {
  EndpointAnalysisCubit get endpointAnalysisCubit =>
      read<EndpointAnalysisCubit>();
}
