
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_analyzer_gui/features/analysis/widgets/screen_record_overview/logic/screen_recorder_overview_cubit.dart';

extension ScreenRecorderCubitExtension on BuildContext{
  ScreenRecorderOverviewCubit get overviewCubit => read<ScreenRecorderOverviewCubit>();
}