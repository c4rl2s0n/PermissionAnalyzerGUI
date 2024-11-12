import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/l10n/l10n.dart';

import 'widgets/widgets.dart';

class LanguageSettings extends StatelessWidget {
  const LanguageSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsGroup(
      title: context.strings.languageSettings,
      settings: [
        SimpleSetting(
          name: context.strings.selectedLanguage,
          action: BlocBuilder<SettingsCubit, SettingsState>(
            buildWhen: (oldState, state) => oldState.language != state.language,
            builder: (context, state) {
              return DropdownMenu<String>(
                onSelected: (locale) => locale != null
                    ? context.settings.setLanguage(locale)
                    : null,
                initialSelection: AppLocalizations.supportedLocales
                    .map((l) => l.languageCode)
                    .firstWhere((l) => l == state.language,
                        orElse: () => context.strings.localeName),
                requestFocusOnTap: false,
                dropdownMenuEntries: AppLocalizations.supportedLocales
                    .map((l) => DropdownMenuEntry<String>(
                          value: l.languageCode,
                          label: l.languageCode,
                        ))
                    .toList(),
              );
            },
          ),
        ),
      ],
    );
  }
}
