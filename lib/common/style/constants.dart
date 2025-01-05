import 'dart:ui';

import 'package:flutter/material.dart';

class ThemeConstants extends ThemeExtension<ThemeConstants> {
  ThemeConstants({
    this.roundedCornerRadius = const Radius.circular(12),
    this.largeSpacing = 16,
    this.spacing = 12,
    this.smallSpacing = 8,
    this.infoContainerActionButtonPadding = 2,
    this.lightColorOpacity = 0.7,
    this.mediumColorOpacity = 0.5,
    this.strongColorOpacity = 0.3,
    this.statusMarkerSize = 20,
    this.listTileHeight = 60,
    this.listTileImageMargin = 10,
    this.scrollbarThickness = 10,
    this.dividerHeight = 5,
  });
  final Radius roundedCornerRadius;
  final double largeSpacing;
  final double spacing;
  final double smallSpacing;
  final double infoContainerActionButtonPadding;
  final double lightColorOpacity;
  final double mediumColorOpacity;
  final double strongColorOpacity;
  final double statusMarkerSize;
  final double listTileHeight;
  final double listTileImageMargin;
  final double scrollbarThickness;
  final double dividerHeight;

  @override
  ThemeExtension<ThemeConstants> copyWith({
    Radius? roundedCornerRadius,
    double? largeSpacing,
    double? spacing,
    double? smallSpacing,
    double? infoContainerActionButtonPadding,
    double? subtleColorOpacity,
    double? strongColorOpacity,
    double? statusMarkerSize,
    double? listTileHeight,
    double? listTileImageMargin,
    double? scrollbarThickness,
    double? dividerHeight,
  }) {
    return ThemeConstants(
      roundedCornerRadius: roundedCornerRadius ?? this.roundedCornerRadius,
      largeSpacing: largeSpacing ?? this.largeSpacing,
      spacing: spacing ?? this.spacing,
      smallSpacing: smallSpacing ?? this.smallSpacing,
      infoContainerActionButtonPadding: infoContainerActionButtonPadding ?? this.infoContainerActionButtonPadding,
      lightColorOpacity: subtleColorOpacity ?? this.lightColorOpacity,
      strongColorOpacity: strongColorOpacity ?? this.strongColorOpacity,
      statusMarkerSize: statusMarkerSize ?? this.statusMarkerSize,
      listTileHeight: listTileHeight ?? this.listTileHeight,
      listTileImageMargin: listTileImageMargin ?? this.listTileImageMargin,
      scrollbarThickness: scrollbarThickness ?? this.scrollbarThickness,
      dividerHeight: dividerHeight ?? this.dividerHeight,
    );
  }

  @override
  ThemeExtension<ThemeConstants> lerp(
      covariant ThemeExtension<ThemeConstants>? other, double t) {
    if (other == null) return this;
    other = other as ThemeConstants;
    return ThemeConstants(
      roundedCornerRadius: Radius.elliptical(
          lerpDouble(other.roundedCornerRadius.x, roundedCornerRadius.x, t)!,
          lerpDouble(other.roundedCornerRadius.y, roundedCornerRadius.y, t)!),
      largeSpacing: lerpDouble(other.largeSpacing, largeSpacing, t)!,
      spacing: lerpDouble(other.spacing, spacing, t)!,
      smallSpacing: lerpDouble(other.smallSpacing, smallSpacing, t)!,
      lightColorOpacity:
          lerpDouble(other.lightColorOpacity, lightColorOpacity, t)!,
      strongColorOpacity:
          lerpDouble(other.strongColorOpacity, strongColorOpacity, t)!,
      statusMarkerSize:
          lerpDouble(other.statusMarkerSize, statusMarkerSize, t)!,
      listTileHeight: lerpDouble(other.listTileHeight, listTileHeight, t)!,
      listTileImageMargin:
          lerpDouble(other.listTileImageMargin, listTileImageMargin, t)!,
      scrollbarThickness:
          lerpDouble(other.scrollbarThickness, scrollbarThickness, t)!,
      dividerHeight: lerpDouble(other.dividerHeight, dividerHeight, t)!,
    );
  }
}
