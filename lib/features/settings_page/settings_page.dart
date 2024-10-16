import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/common/common.dart';
import 'package:flutter_template/l10n/flutter_template_localizations.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageComponentFactory.getScaffold(
      context,
      appBar: PageComponentFactory.getAppBar(context,
          title: context.strings.settings),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _themeSettings(context),
            _languageSettings(context),
          ].insertBetweenItems(() => const Divider())
           .insertBetweenItems(() => Margin.vertical(context.constants.largeSpacing)),
        ),
      ),
    );
  }

  Widget _settingsGroup(
    BuildContext context, {
    required String title,
    required List<Widget> settings,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: context.textTheme.headlineSmall),
        ...settings.insertBetweenItems(() => Margin.vertical(context.constants.spacing)),
      ],
    );
  }

  Widget _simpleSetting(
    BuildContext context, {
    required String name,
    String? description,
    Widget? action,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Text(
              name,
              style: context.textTheme.labelMedium,
            ),
            if (description != null) ...[
              Text(
                description,
                style: context.textTheme.bodyMedium,
              )
            ],
          ],
        ),
        if (action != null) ...[action],
      ],
    );
  }

  Widget _themeSettings(BuildContext context) {
    return _settingsGroup(
      context,
      title: context.strings.themeSettings,
      settings: [
        _simpleSetting(
          context,
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

  Widget _languageSettings(BuildContext context) {
    return _settingsGroup(
      context,
      title: context.strings.languageSettings,
      settings: [
        _simpleSetting(
          context,
          name: context.strings.selectedLanguage,
          action: BlocBuilder<SettingsCubit, SettingsState>(
            buildWhen: (oldState, state) =>
                oldState.language != state.language,
            builder: (context, state) {
              return DropdownMenu<String>(
                onSelected: (locale) => locale != null
                    ? context.settings.setLanguage(locale)
                    : null,
                initialSelection: FlutterTemplateLocalizations.supportedLocales
                    .map((l) => l.languageCode)
                    .firstWhere((l) => l == state.language,
                        orElse: () => context.strings.localeName),
                requestFocusOnTap: false,
                dropdownMenuEntries:
                    FlutterTemplateLocalizations.supportedLocales
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
