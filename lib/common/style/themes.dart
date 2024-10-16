import 'package:flutter/material.dart';
import 'style.dart';

ThemeData getTheme(bool dark) {
  ThemeConstants constants = ThemeConstants();

  // Colors
  CustomColors colors;
  if (dark) {
    colors = MyDarkColors(constants);
  } else {
    colors = MyBrightColors(constants);
  }

  // Icons
  CustomIcons icons = const CustomIcons();

  // Text Styles
  TextStyle defaultTextStyle =
      TextStyle(fontSize: 15, color: colors.onBackground);
  TextTheme textTheme = TextTheme(
    titleLarge:
        defaultTextStyle.copyWith(fontSize: 24, fontWeight: FontWeight.w700),
    titleMedium:
        defaultTextStyle.copyWith(fontSize: 20, fontWeight: FontWeight.w700),
    headlineSmall:
        defaultTextStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 19),
    labelLarge:
        defaultTextStyle.copyWith(fontWeight: FontWeight.w600, fontSize: 18),
    labelMedium:
        defaultTextStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 16),
    labelSmall:
        defaultTextStyle.copyWith(fontWeight: FontWeight.w400, fontSize: 15),
    bodyMedium:
        defaultTextStyle.copyWith(fontSize: 14, color: colors.onSurface),
    bodySmall: defaultTextStyle.copyWith(fontSize: 12, color: colors.onSurface),
  );

  // Theme Data
  ButtonThemeData buttonTheme =
      ButtonThemeData(buttonColor: colors.onBackground);
  DialogTheme dialogTheme = DialogTheme(
    backgroundColor: colors.surface,
    titleTextStyle: textTheme.titleLarge
        ?.copyWith(fontWeight: FontWeight.w700, color: colors.onSurface),
    contentTextStyle: textTheme.bodyMedium?.copyWith(color: colors.onSurface),
  );
  IconThemeData iconTheme = IconThemeData(color: colors.onBackground);
  DropdownMenuThemeData dropdownMenuTheme = DropdownMenuThemeData(
      textStyle: textTheme.bodyMedium,
      inputDecorationTheme: InputDecorationTheme(
        fillColor: Colors.transparent,
        hoverColor: colors.highlight,
        border: OutlineInputBorder(borderSide: BorderSide(color: colors.onBackground)),
        outlineBorder: BorderSide(color: colors.onBackground),
        activeIndicatorBorder: BorderSide(color: Colors.green, width: 5),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: colors.onBackground)),
      ));
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: colors.primary),
    extensions: [colors, icons, constants],
    textTheme: textTheme,
    iconTheme: iconTheme,
    buttonTheme: buttonTheme,
    dialogTheme: dialogTheme,
    dropdownMenuTheme: dropdownMenuTheme,
    useMaterial3: true,
  );
}
