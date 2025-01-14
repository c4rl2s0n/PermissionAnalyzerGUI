import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_analyzer_gui/common/common.dart';


class BehaviorSettings extends StatelessWidget {
  const BehaviorSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsGroup(
      title: "Behavior",
      settings: [
        _ignoreLocalTraffic(),
      ],
    );
  }

  Widget _ignoreLocalTraffic() {
    return SimpleSetting(
      name: "Ignore Local Traffic",
      description: "Ignore connections to 127.0.0.1 and 10.0.0.0/16",
      action: BlocBuilder<SettingsCubit, SettingsState>(
        buildWhen: (oldState, state) =>
            oldState.ignoreLocalTraffic != state.ignoreLocalTraffic,
        builder: (context, state) {
          return Switch(
            value: state.ignoreLocalTraffic,
            onChanged: (_) => context.settings.toggleIgnoreLocalTraffic(),
          );
        },
      ),
    );
  }
}
