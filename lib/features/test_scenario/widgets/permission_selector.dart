import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_analyzer_gui/common/common.dart';

import '../logic/logic.dart';

class PermissionSelector extends StatelessWidget {
  const PermissionSelector({super.key});

  @override
  Widget build(BuildContext context) {

      return BlocBuilder<TestScenarioCubit, TestScenarioState>(
        buildWhen: (oldState, state) => oldState.permissions != state.permissions
            || oldState.canConfigure != state.canConfigure,
        builder: (context, state) => AbsorbPointer(
          absorbing: !state.canConfigure,
          child: InfoContainer(
            title: "Optional Permissions (${state.permissions.length})",
            scrollable: true,
            child: Column(
              children: state.permissions
                  .map(
                    (p) => TapContainer(
                      backgroundColor: Colors.transparent,
                  onTap: () => context.testScenarioCubit
                      .togglePermissionState(p.permission),
                  padding: EdgeInsets.symmetric(
                      horizontal: context.constants.smallSpacing),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    child: Row(
                      children: [
                        Expanded(child: Text(p.permission)),
                        context.permissionStateIcon(p.state),
                      ],
                    ),
                  ),
                ) as Widget,
              ).toList()
            ),
          ),
        ),
      );
    }

}
