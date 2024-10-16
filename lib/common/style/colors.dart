import 'package:flutter/material.dart';

import 'style.dart';

class CustomColors extends ThemeExtension<CustomColors> {
  const CustomColors(
    this._themeConstants, {
    this.background = CustomColors._black,
    this.primary = const Color(0xff16697a),
    this.secondary = const Color(0xff489fb5),
    this.surface = const Color(0xff444444),
    this.highlight = const Color(0xffffa62b),
    this.favorite = Colors.yellowAccent,
    this.warning = Colors.orange,
    this.positive = const Color(0xff409c18),
    this.negative = const Color(0xff8e1818),
  });

  final ThemeConstants _themeConstants;

  static const Color _black = Colors.black;
  static const Color _white = Colors.white;

  final Color _onDark = CustomColors._white;
  final Color _onBright = CustomColors._black;

  final Color background;
  final Color primary;
  final Color secondary;
  final Color surface;
  final Color highlight;

  final Color favorite;
  final Color warning;
  final Color positive;
  final Color negative;

  Color get black => _black;
  Color get white => _white;

  Color get onPrimary => _onDark;
  Color get onSecondary => _onBright;
  Color get onHighlight => _onBright;
  Color get onBackground => _onDark;
  Color get onSurface => _onDark;
  Color get divider => _onDark.withOpacity(_themeConstants.subtleColorOpacity);
  Color get border =>
      onBackground.withOpacity(_themeConstants.strongColorOpacity);
  Color get disabled => _onDark.withOpacity(_themeConstants.strongColorOpacity);
  Color get error => negative;
  Color get onError => _onBright;

  @override
  ThemeExtension<CustomColors> copyWith({
    ThemeConstants? themeConstants,
    Color? background,
    Color? primary,
    Color? secondary,
    Color? surface,
    Color? highlight,
    Color? favorite,
    Color? warning,
    Color? positive,
    Color? negative,
  }) {
    return CustomColors(
      themeConstants ?? _themeConstants,
      background: background ?? this.background,
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      surface: surface ?? this.surface,
      highlight: highlight ?? this.highlight,
      favorite: favorite ?? this.favorite,
      warning: warning ?? this.warning,
      positive: positive ?? this.positive,
      negative: negative ?? this.negative,
    );
  }

  @override
  ThemeExtension<CustomColors> lerp(
      covariant ThemeExtension<CustomColors>? other, double t) {
    other = other as CustomColors;
    return CustomColors(
      _themeConstants.lerp(other._themeConstants, t) as ThemeConstants,
      background: Color.lerp(background, other.background, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      highlight: Color.lerp(highlight, other.highlight, t)!,
      favorite: Color.lerp(favorite, other.favorite, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      positive: Color.lerp(positive, other.positive, t)!,
      negative: Color.lerp(negative, other.negative, t)!,
    );
  }
}

class MyBrightColors extends CustomColors {
  const MyBrightColors(super._themeConstants)
      : super(
          background: CustomColors._white,
          primary: const Color(0xff8d5d0d),
          secondary: const Color(0xff938311),
          surface: const Color(0xffd7cfcf),
          highlight: const Color(0xff54a611),
        );

  @override
  Color get onPrimary => _onDark;
  @override
  Color get onSecondary => _onDark;
  @override
  Color get onHighlight => _onBright;
  @override
  Color get onBackground => _onBright;
  @override
  Color get onSurface => _onBright;
}

class MyDarkColors extends CustomColors {
  const MyDarkColors(super._themeConstants)
      : super(
          background: CustomColors._black,
          primary: const Color(0xff16697a),
          secondary: const Color(0xff489fb5),
          surface: const Color(0xff444444),
          highlight: const Color(0xffffa62b),
        );
  @override
  Color get onPrimary => _onDark;
  @override
  Color get onSecondary => _onBright;
  @override
  Color get onHighlight => _onBright;
  @override
  Color get onBackground => _onDark;
  @override
  Color get onSurface => _onDark;
}
