import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_template/common/common.dart';
import 'package:flutter_template/l10n/l10n.dart';

extension IsRootDirectory on Directory {
  bool get isRoot => parent.absolute.path == absolute.path;
}

extension ContextSettingsAccessorExtension on BuildContext {
  NavigationService get navigator => NavigationService(this);
  ScaffoldMessengerState get messenger => ScaffoldMessenger.of(this);
  SettingsCubit get settings => read<SettingsCubit>();

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

extension ListExtensions<T> on List<T>{
  List<T> get distinct => toSet().toList();

  List<T> insertBetweenItems(T Function() getObject) {
    if(isEmpty) return [];
    return [
      for (int i = 0; i < length - 1; i++) ...[this[i], getObject()],
      last,
    ];
  }

}

