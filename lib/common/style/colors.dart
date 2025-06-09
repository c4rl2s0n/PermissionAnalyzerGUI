import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

import 'style.dart';

part 'colors.tailor.dart';

/// Class to make access to colors uniform.
/// It references the material ColorScheme, as well as some DefaultColors and can be extended to provide more app-specific colors.
///
/// The roles of material colors are described [here](https://m3.material.io/styles/color/roles).
///
class ColorAccessor{
  const ColorAccessor(this.material, {this.defaultColors});
  final ColorScheme material;
  final CustomColors? defaultColors;

  // Static default values
  static const Color black = Color(0xff0d1b2a);
  static const Color white = Color(0xffe0e1dd);

  // Material ColorScheme fields
  Color get primary => material.primary;
  Color get onPrimary => material.onPrimary;
  Color get primaryContainer => material.primaryContainer;
  Color get onPrimaryContainer => material.onPrimaryContainer;

  Color get secondary => material.secondary;
  Color get onSecondary => material.onSecondary;
  Color get secondaryContainer => material.secondaryContainer;
  Color get onSecondaryContainer => material.onSecondaryContainer;

  Color get tertiary => material.tertiary;
  Color get onTertiary => material.onTertiary;
  Color get tertiaryContainer => material.tertiaryContainer;
  Color get onTertiaryContainer => material.onTertiaryContainer;

  Color get error => material.error;
  Color get onError => material.onError;
  Color get errorContainer => material.errorContainer;
  Color get onErrorContainer => material.onErrorContainer;

  Color get surface => material.surface;
  Color get onSurface => material.onSurface;
  Color get surfaceVariant => material.surfaceVariant;
  Color get onSurfaceVariant => material.onSurfaceVariant;
  Color get surfaceContainerLowest => material.surfaceContainerLowest;
  Color get surfaceContainerLow => material.surfaceContainerLow;
  Color get surfaceContainer => material.surfaceContainer;
  Color get surfaceContainerHigh => material.surfaceContainerHigh;
  Color get surfaceContainerHighest => material.surfaceContainerHighest;

  Color get outline => material.outline;
  Color get outlineVariant => material.outlineVariant;

  Color get shadow => material.shadow;
  Color get scrim => material.scrim;

  Color get inverseSurface => material.inverseSurface;
  Color get onInverseSurface => material.onInverseSurface;
  Color get inversePrimary => material.inversePrimary;

  Color get surfaceTint => material.surfaceTint;

  // Derived colors
  Color get disabledContent => onSurface.withAlpha(Color.getAlphaFromOpacity(0.38));
  Color get disabledContainer => onSurface.withAlpha(Color.getAlphaFromOpacity(0.12));
  Color get background => surfaceContainerLowest;
  Color get onBackground => onSurface;
  Color get controlBorder => outline;
  Color get divider => outlineVariant;

  Color get appBar => primary;
  Color get onAppBar => onPrimary;


  // Custom colors
  Color get favorite => defaultColors?.favorite ?? Colors.yellowAccent;
  Color get warning => defaultColors?.warning ?? Colors.orange;
  Color get onWarning => defaultColors?.onWarning ?? black;
  Color get positive => defaultColors?.positive ?? Colors.lightGreen;
  Color get onPositive => defaultColors?.onPositive ?? black;
  Color get negative => defaultColors?.negative ?? Colors.red;
  Color get onNegative => defaultColors?.onNegative ?? black;

}

@TailorMixin(themeGetter: ThemeGetter.none)
class CustomColors extends ThemeExtension<CustomColors> with _$CustomColorsTailorMixin{
  const CustomColors({
    this.favorite = Colors.yellowAccent,
    this.warning = Colors.orange,
    this.onWarning = ColorAccessor.black,
    this.positive = const Color(0xff409c18),
    this.onPositive = ColorAccessor.black,
    this.negative = const Color(0xff8e1818),
    this.onNegative = ColorAccessor.white,
  });

  final Color favorite;
  final Color warning;
  final Color onWarning;
  final Color positive;
  final Color onPositive;
  final Color negative;
  final Color onNegative;

}
