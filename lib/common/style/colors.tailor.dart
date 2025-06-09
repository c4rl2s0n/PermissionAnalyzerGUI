// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_element, unnecessary_cast

part of 'colors.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$CustomColorsTailorMixin on ThemeExtension<CustomColors> {
  Color get favorite;
  Color get warning;
  Color get onWarning;
  Color get positive;
  Color get onPositive;
  Color get negative;
  Color get onNegative;

  @override
  CustomColors copyWith({
    Color? favorite,
    Color? warning,
    Color? onWarning,
    Color? positive,
    Color? onPositive,
    Color? negative,
    Color? onNegative,
  }) {
    return CustomColors(
      favorite: favorite ?? this.favorite,
      warning: warning ?? this.warning,
      onWarning: onWarning ?? this.onWarning,
      positive: positive ?? this.positive,
      onPositive: onPositive ?? this.onPositive,
      negative: negative ?? this.negative,
      onNegative: onNegative ?? this.onNegative,
    );
  }

  @override
  CustomColors lerp(covariant ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) return this as CustomColors;
    return CustomColors(
      favorite: Color.lerp(favorite, other.favorite, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      onWarning: Color.lerp(onWarning, other.onWarning, t)!,
      positive: Color.lerp(positive, other.positive, t)!,
      onPositive: Color.lerp(onPositive, other.onPositive, t)!,
      negative: Color.lerp(negative, other.negative, t)!,
      onNegative: Color.lerp(onNegative, other.onNegative, t)!,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CustomColors &&
            const DeepCollectionEquality().equals(favorite, other.favorite) &&
            const DeepCollectionEquality().equals(warning, other.warning) &&
            const DeepCollectionEquality().equals(onWarning, other.onWarning) &&
            const DeepCollectionEquality().equals(positive, other.positive) &&
            const DeepCollectionEquality()
                .equals(onPositive, other.onPositive) &&
            const DeepCollectionEquality().equals(negative, other.negative) &&
            const DeepCollectionEquality()
                .equals(onNegative, other.onNegative));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(favorite),
      const DeepCollectionEquality().hash(warning),
      const DeepCollectionEquality().hash(onWarning),
      const DeepCollectionEquality().hash(positive),
      const DeepCollectionEquality().hash(onPositive),
      const DeepCollectionEquality().hash(negative),
      const DeepCollectionEquality().hash(onNegative),
    );
  }
}
