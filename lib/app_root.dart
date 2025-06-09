import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/common/keys.dart';
import 'package:permission_analyzer_gui/l10n/l10n.dart';

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
        buildWhen: (oldState, state) =>
            oldState.isDarkMode != state.isDarkMode ||
            oldState.colorScheme != state.colorScheme ||
            oldState.language != state.language,
        builder: (context, state) {
          return MaterialApp(
            title: title,
            scaffoldMessengerKey: messengerKey,
            debugShowCheckedModeBanner: false,
            debugShowMaterialGrid: false,
            theme: getTheme(false, flexScheme: state.colorScheme),
            darkTheme: getTheme(true, flexScheme: state.colorScheme),
            themeMode: state.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: AppLocalizations.supportedLocales
                .firstWhere((l) => l.languageCode == state.language),
            navigatorObservers: [Modular.get<RouteObserver>()],
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
        BlocProvider(create: (ctx) => SessionCubit(ctx.settings)),
      ],
      child: child,
    );
  }
}
