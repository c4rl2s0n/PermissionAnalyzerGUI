import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_analyzer_gui/features/project_overview/logic/project_overview_cubit.dart';

extension ProjectOverviewContextExtension on BuildContext {
  ProjectOverviewCubit get projectOverviewCubit => read<ProjectOverviewCubit>();
}
