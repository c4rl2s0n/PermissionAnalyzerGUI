
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_analyzer_gui/features/project_overview/widgets/new_application_dialog/logic/new_application_dialog_cubit.dart';


extension NewApplicationDialogContextExtension on BuildContext{
  NewApplicationDialogCubit get newApplicationDialogCubit => read<NewApplicationDialogCubit>();
}