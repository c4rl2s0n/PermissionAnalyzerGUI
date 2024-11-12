import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_analyzer_gui/common/common.dart';

import 'widgets/widgets.dart';

class ThemeSettings extends StatelessWidget {
  const ThemeSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsGroup(
      title: context.strings.themeSettings,
      settings: [
        SimpleSetting(
          name: context.strings.darkMode,
          action: BlocBuilder<SettingsCubit, SettingsState>(
            buildWhen: (oldState, state) =>
                oldState.isDarkMode != state.isDarkMode,
            builder: (context, state) {
              return Switch(
                value: state.isDarkMode,
                onChanged: (_) =>
                    context.read<SettingsCubit>().toggleDarkMode(),
              );
            },
          ),
        ),
      ],
    );
  }
}
