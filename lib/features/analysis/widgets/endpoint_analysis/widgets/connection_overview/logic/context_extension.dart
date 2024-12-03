import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'connection_overview_cubit.dart';


extension CtxEndpointOverviewCubit on BuildContext {
ConnectionOverviewCubit get connectionOverviewCubit => read<ConnectionOverviewCubit>();
}
