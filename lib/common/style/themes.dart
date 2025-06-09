import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'style.dart';


ThemeData getTheme(
    bool dark, {
      FlexScheme? flexScheme,
      String? fontFamily,
      ThemeConstants constants = const ThemeConstants(),
      CustomColors defaultColors = const CustomColors(),
      CustomIcons icons = const CustomIcons(),
      Iterable<ThemeExtension<dynamic>>? extensions,
    }) {
  FlexSubThemesData subThemesData = FlexSubThemesData(
    dropdownMenuTextStyle: TextStyle(fontSize: 25),
    menuButtonTextStyle: WidgetStatePropertyAll(TextStyle(fontSize: 12)),
  );
  ThemeData theme =
      (dark
          ? FlexColorScheme.dark(
        scheme: flexScheme,
        subThemesData: subThemesData,
        fontFamily: fontFamily,
      )
          : FlexColorScheme.light(
        scheme: flexScheme,
        subThemesData: subThemesData,
        fontFamily: fontFamily,
      ))
          .toTheme;
  ColorAccessor colors = ColorAccessor(theme.colorScheme, defaultColors: defaultColors);
  var textTheme = theme.textTheme;
  TextStyle? menuItemTextStyle = textTheme.labelLarge;
  var menuButtonTheme = MenuButtonThemeData(
    style: theme.menuButtonTheme.style?.copyWith(
      textStyle: WidgetStateProperty.all(menuItemTextStyle),
    ),
  );
  var dropdownMenuTheme = theme.dropdownMenuTheme.copyWith(
    textStyle: menuItemTextStyle,
  );
  var pageTransitionsTheme = PageTransitionsTheme(
      builders: {
        TargetPlatform.linux: ZoomPageTransitionsBuilder(),
        TargetPlatform.windows: FadeForwardsPageTransitionsBuilder(),
        TargetPlatform.android: FadeForwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
      }
  );
  return theme.copyWith(
    menuButtonTheme: menuButtonTheme,
    dropdownMenuTheme: dropdownMenuTheme,
    pageTransitionsTheme: pageTransitionsTheme,
    extensions: [
      defaultColors,
      icons,
      constants,
      if (extensions != null) ...extensions,
    ],
  );
}

// ThemeData getTheme(bool dark) {
//   ThemeConstants constants = ThemeConstants();
//
//   // Colors
//   CustomColors colors;
//   if (dark) {
//     colors = MyDarkColors(constants);
//   } else {
//     colors = MyBrightColors(constants);
//   }
//
//   // Icons
//   CustomIcons icons = const CustomIcons();
//
//   // Text Styles
//   TextStyle defaultTextStyle =
//       TextStyle(fontSize: 15, color: colors.onBackground);
//   TextTheme textTheme = TextTheme(
//     titleLarge:
//         defaultTextStyle.copyWith(fontSize: 24, fontWeight: FontWeight.w700),
//     titleMedium:
//         defaultTextStyle.copyWith(fontSize: 20, fontWeight: FontWeight.w700),
//     titleSmall:
//         defaultTextStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w700),
//     headlineSmall:
//         defaultTextStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 19),
//     labelLarge:
//         defaultTextStyle.copyWith(fontWeight: FontWeight.w600, fontSize: 18),
//     labelMedium:
//         defaultTextStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 16),
//     labelSmall:
//         defaultTextStyle.copyWith(fontWeight: FontWeight.w400, fontSize: 15),
//     bodyMedium:
//         defaultTextStyle.copyWith(fontSize: 14, color: colors.onSurface),
//     bodySmall: defaultTextStyle.copyWith(fontSize: 12, color: colors.onSurface),
//   );
//   TextSelectionThemeData textSelectionTheme = TextSelectionThemeData(
//     selectionColor: colors.highlight,
//   );
//
//   // Theme Data
//   ButtonThemeData buttonTheme =
//       ButtonThemeData(buttonColor: colors.onBackground);
//
//   DialogTheme dialogTheme = DialogTheme(
//     backgroundColor: colors.surface,
//     titleTextStyle: textTheme.titleLarge
//         ?.copyWith(fontWeight: FontWeight.w700, color: colors.onSurface),
//     contentTextStyle: textTheme.bodyMedium?.copyWith(color: colors.onSurface),
//   );
//   IconThemeData iconTheme = IconThemeData(color: colors.onBackground);
//   DropdownMenuThemeData dropdownMenuTheme = DropdownMenuThemeData(
//     textStyle: textTheme.labelSmall,
//     inputDecorationTheme: InputDecorationTheme(
//       labelStyle: textTheme.labelMedium?.copyWith(
//           color: textTheme.labelMedium?.color
//               ?.withOpacity(constants.lightColorOpacity)),
//       suffixIconColor: colors.onBackground,
//       fillColor: colors.surface,
//       hoverColor: colors.highlight,
//       enabledBorder: UnderlineInputBorder(
//         borderSide: BorderSide(color: colors.onBackground),
//       ),
//       focusedBorder: OutlineInputBorder(
//           borderSide: BorderSide(color: colors.onBackground)),
//     ),
//     menuStyle: MenuStyle(
//         backgroundColor: WidgetStateProperty.resolveWith((state) {
//           if (state.any((s) => s == WidgetState.hovered)) return colors.surface;
//           return colors.secondary;
//         }), //All<Color>(colors.surface),
//         shape: WidgetStatePropertyAll(RoundedRectangleBorder(
//             borderRadius: BorderRadius.all(constants.roundedCornerRadius)))),
//   );
//
//   ScrollbarThemeData scrollbarTheme = ScrollbarThemeData(
//     thickness: const WidgetStatePropertyAll(10),
//     radius: constants.roundedCornerRadius,
//     thumbColor: WidgetStatePropertyAll(
//         colors.onBackground.withOpacity(constants.lightColorOpacity)),
//     trackColor: WidgetStatePropertyAll(
//         colors.onBackground.withOpacity(constants.strongColorOpacity)),
//   );
//   return ThemeData(
//     colorScheme: ColorScheme.fromSeed(seedColor: colors.primary),
//     extensions: [colors, icons, constants],
//     textTheme: textTheme,
//     textSelectionTheme: textSelectionTheme,
//     iconTheme: iconTheme,
//     buttonTheme: buttonTheme,
//     dialogTheme: dialogTheme,
//     dropdownMenuTheme: dropdownMenuTheme,
//     scrollbarTheme: scrollbarTheme,
//     useMaterial3: true,
//   );
// }
