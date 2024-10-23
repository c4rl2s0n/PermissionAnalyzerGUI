import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:permission_analyzer_gui/l10n/l10n.dart';
import 'package:permission_analyzer_gui/common/common.dart';

extension ContextSettingsAccessorExtension on BuildContext {
  // BLoC
  SessionCubit get session => read<SessionCubit>();
  SettingsCubit get settings => read<SettingsCubit>();

  // Services
  ScaffoldMessengerState get messenger => ScaffoldMessenger.of(this);
  NavigationService get navigator => NavigationService(this);

  // Theme
  ThemeData get themeData => Theme.of(this);
  CustomColors get colors => themeData.extension<CustomColors>()!;
  CustomIcons get icons => themeData.extension<CustomIcons>()!;
  AppLocalizations get strings => AppLocalizations.of(this)!;
  ThemeConstants get constants => themeData.extension<ThemeConstants>()!;
  PopupMenuThemeData get popupMenuTheme => themeData.popupMenuTheme;
  TextTheme get textTheme => themeData.textTheme;
  IconThemeData get iconTheme => themeData.iconTheme;
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
}
