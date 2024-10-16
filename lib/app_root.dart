import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:flutter_template/common/common.dart';
import 'package:flutter_template/l10n/flutter_template_localizations.dart';

import 'data/data.dart';
import 'features/features.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  final String title = "Flutter Template";

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return _registerGlobalBlocs(
      child: BlocBuilder<SettingsCubit, SettingsState>(
        buildWhen: (oldState, state) => oldState.isDarkMode != state.isDarkMode
            || oldState.language != state.language,
        builder: (context, state) {
          return MaterialApp(
            title: title,
            debugShowCheckedModeBanner: false,
            debugShowMaterialGrid: false,
            theme: getTheme(false),
            darkTheme: getTheme(true),
            themeMode: state.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            localizationsDelegates:FlutterTemplateLocalizations.localizationsDelegates,
            supportedLocales: FlutterTemplateLocalizations.supportedLocales,
            locale: FlutterTemplateLocalizations.supportedLocales.firstWhere((l) => l.languageCode == state.language),
            home: Builder(
              builder: (context) => const SplashScreen(),
            ),
          );
        },
      ),
    );
  }

  Widget _registerGlobalBlocs({required Widget child}) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => SettingsCubit(Modular.get<ISettingsRepository>()),
        ),
      ],
      child: child,
    );
  }
}
