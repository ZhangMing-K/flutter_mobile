import 'dart:ui';

import 'package:flutter/material.dart';

// ignore_for_file: public_member_api_docs
class FloatingSearchAppBarStyle {
  final Color? accentColor;
  final Color? backgroundColor;
  final Color? shadowColor;
  final Color? iconColor;
  final Color? colorOnScroll;
  final EdgeInsets? padding;
  final EdgeInsets? insets;
  final double? height;
  final double? elevation;
  final double? liftOnScrollElevation;
  final TextStyle? hintStyle;
  final TextStyle? queryStyle;
  const FloatingSearchAppBarStyle({
    required this.accentColor,
    required this.backgroundColor,
    required this.shadowColor,
    required this.iconColor,
    required this.colorOnScroll,
    required this.padding,
    required this.insets,
    required this.height,
    required this.elevation,
    required this.liftOnScrollElevation,
    required this.hintStyle,
    required this.queryStyle,
  });

  FloatingSearchAppBarStyle scaleTo(FloatingSearchAppBarStyle b, double t) {
    return FloatingSearchAppBarStyle(
      height: lerpDouble(height, b.height, t),
      elevation: lerpDouble(elevation, b.elevation, t),
      liftOnScrollElevation:
          lerpDouble(liftOnScrollElevation, b.liftOnScrollElevation, t),
      accentColor: Color.lerp(accentColor, b.accentColor, t),
      backgroundColor: Color.lerp(backgroundColor, b.backgroundColor, t),
      colorOnScroll: Color.lerp(colorOnScroll, b.colorOnScroll, t),
      shadowColor: Color.lerp(shadowColor, b.shadowColor, t),
      iconColor: Color.lerp(iconColor, b.iconColor, t),
      insets: EdgeInsetsGeometry.lerp(insets, b.insets, t) as EdgeInsets?,
      padding: EdgeInsetsGeometry.lerp(padding, b.padding, t) as EdgeInsets?,
      hintStyle: TextStyle.lerp(hintStyle, b.hintStyle, t),
      queryStyle: TextStyle.lerp(queryStyle, b.queryStyle, t),
    );
  }

  @override
  String toString() {
    return 'FloatingSearchAppBarStyle(accentColor: $accentColor, backgroundColor: $backgroundColor, shadowColor: $shadowColor, iconColor: $iconColor, colorOnScroll: $colorOnScroll, padding: $padding, insets: $insets, height: $height, elevation: $elevation, liftOnScrollElevation: $liftOnScrollElevation, hintStyle: $hintStyle, queryStyle: $queryStyle)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is FloatingSearchAppBarStyle &&
        o.accentColor == accentColor &&
        o.backgroundColor == backgroundColor &&
        o.shadowColor == shadowColor &&
        o.iconColor == iconColor &&
        o.colorOnScroll == colorOnScroll &&
        o.padding == padding &&
        o.insets == insets &&
        o.height == height &&
        o.elevation == elevation &&
        o.liftOnScrollElevation == liftOnScrollElevation &&
        o.hintStyle == hintStyle &&
        o.queryStyle == queryStyle;
  }

  @override
  int get hashCode {
    return accentColor.hashCode ^
        backgroundColor.hashCode ^
        shadowColor.hashCode ^
        iconColor.hashCode ^
        colorOnScroll.hashCode ^
        padding.hashCode ^
        insets.hashCode ^
        height.hashCode ^
        elevation.hashCode ^
        liftOnScrollElevation.hashCode ^
        hintStyle.hashCode ^
        queryStyle.hashCode;
  }
}
