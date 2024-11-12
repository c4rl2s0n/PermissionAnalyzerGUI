import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/data/data.dart';

import 'test_scenario_cubit.dart';

extension CtxTestScenarioCubit on BuildContext {
  TestScenarioCubit get testScenarioCubit => read<TestScenarioCubit>();

  Icon permissionStateIcon(PermissionState state) {
    switch (state) {
      case PermissionState.granted:
        return Icon(icons.check, color: colors.positive);
      case PermissionState.revoked:
        return Icon(
          icons.cancel,
          color: colors.negative,
        );
      case PermissionState.test:
        return Icon(icons.test);
    }
  }
}
