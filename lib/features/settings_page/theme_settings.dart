import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_analyzer_gui/common/common.dart';

class ThemeSettings extends StatelessWidget {
  const ThemeSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsGroup(
      title: context.strings.themeSettings,
      settings: [
        _darkMode(context),
        _colorScheme(),
      ],
    );
  }

  Widget _darkMode(BuildContext context) {
    return SimpleSetting(
      name: context.strings.darkMode,
      action: BlocBuilder<SettingsCubit, SettingsState>(
        buildWhen: (oldState, state) => oldState.isDarkMode != state.isDarkMode,
        builder: (context, state) {
          return Switch(
            value: state.isDarkMode,
            onChanged: (_) => context.read<SettingsCubit>().toggleDarkMode(),
          );
        },
      ),
    );
  }

  Widget _colorScheme() {
    return BlocBuilder<SettingsCubit, SettingsState>(
      buildWhen: (oldState, state) => oldState.colorScheme != state.colorScheme,
      builder: (context, state) {
        return SimpleSetting(
          name: "Color Scheme",
          description: "Select a color scheme",
          action: DropdownMenu<FlexScheme>(
            key: Key(state.colorScheme.name),
            width: 250,
            initialSelection: state.colorScheme,
            requestFocusOnTap: false,
            onSelected: (c) =>
                c != null ? context.settings.setColorScheme(c) : null,
            dropdownMenuEntries: FlexScheme.values
                .map((d) =>
                    DropdownMenuEntry<FlexScheme>(value: d, label: d.name))
                .toList(),
          ),
        );
      },
    );
  }
}
