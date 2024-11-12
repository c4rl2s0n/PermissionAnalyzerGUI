import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_analyzer_gui/features/test_application/logic/test_application_cubit.dart';

extension TestApplicationContextExtension on BuildContext {
  TestApplicationCubit get testApplicationCubit => read<TestApplicationCubit>();
}
