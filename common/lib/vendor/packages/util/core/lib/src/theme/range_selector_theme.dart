import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../theme.dart';

/// Applies a theme to descendant Syncfusion range selector widgets.
class SfRangeSelectorTheme extends InheritedTheme {
  /// Applies the given theme [data] to [child].
  ///
  /// The [data] and [child] arguments must not be null.
  const SfRangeSelectorTheme({Key? key, this.data, required this.child})
      : super(key: key, child: child);

  /// Specifies the color and typography values for descendant
  /// range selector widgets.
  ///
  /// This snippet shows how to set value to the data property in
  /// [SfRangeSelectorTheme] and [SfRangeSliderTheme].
  ///
  /// ```dart
  /// SfRangeValues _initialValues = SfRangeValues(4.0, 7.0);
  ///
  /// Scaffold(
  ///   body: Center(
  ///       child: SfRangeSelectorTheme(
  ///           data: SfRangeSliderThemeData(
  ///               trackHeight: 3,
  ///           ),
  ///           child:  SfRangeSelector(
  ///               min: 2.0,
  ///               max: 10.0,
  ///               initialValues: _initialValues,
  ///               interval: 2,
  ///               showTicks: true,
  ///               showLabels: true,
  ///               child: Container(
  ///                   height: 200,
  ///                   color: Colors.green[100],
  ///               ),
  ///           )
  ///       ),
  ///    )
  /// )
  /// ```
  final SfRangeSelectorThemeData? data;

  /// Specifies a widget that can hold single child.
  ///
  ///
  /// This snippet shows how to set value to the child property in
  /// [SfRangeSliderTheme] and [SfRangeSelectorTheme].
  ///
  /// ```dart
  /// SfRangeValues _values = SfRangeValues(4.0, 7.0);
  ///
  /// Scaffold(
  ///   body: Center(
  ///       child: SfRangeSliderTheme(
  ///           data: SfRangeSliderThemeData(
  ///               trackHeight: 3,
  ///           ),
  ///           child:  SfRangeSlider(
  ///               min: 2.0,
  ///               max: 10.0,
  ///               values: _values,
  ///               interval: 2,
  ///               showTicks: true,
  ///               showLabels: true,
  ///               onChanged: (SfRangeValues newValues){
  ///                   setState(() {
  ///                       _values = newValues;
  ///                   });
  ///               },
  ///           )
  ///       ),
  ///    )
  /// )
  /// ```
  @override
  final Widget child;

  /// The data from the closest [SfRangeSelectorTheme]
  /// instance that encloses the given context.
  ///
  /// Defaults to [SfThemeData.rangeSelectorThemeData] if there is no
  /// [SfRangeSelectorTheme] in the given build context.
  static SfRangeSelectorThemeData of(BuildContext context) {
    final SfRangeSelectorTheme? rangeSelectorTheme =
        context.dependOnInheritedWidgetOfExactType<SfRangeSelectorTheme>();
    return rangeSelectorTheme?.data ??
        SfTheme.of(context).rangeSelectorThemeData;
  }

  @override
  bool updateShouldNotify(SfRangeSelectorTheme oldWidget) =>
      data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    final SfRangeSelectorTheme? ancestorTheme =
        context.findAncestorWidgetOfExactType<SfRangeSelectorTheme>();
    return identical(this, ancestorTheme)
        ? child
        : SfRangeSelectorTheme(data: data, child: child);
  }
}

/// Holds the color and typography values for a [SfRangeSelectorTheme].
/// Use this class to configure a [SfRangeSelectorTheme] widget, or to set the
/// [SfThemeData.rangeSelectorThemeData] for a [SfTheme] widget.
///
/// To obtain the current theme, use [SfRangeSelectorTheme.of].
///
/// The range selector elements are:
///
/// * The "track", which is the rounded rectangle in which
/// the thumbs are slides over.
/// * The "thumb", which is a shape that slides horizontally when
/// the user drags it.
/// * The "active" side of the range selector is between
/// the left and right thumbs.
/// * The "inactive" side of the range selector is between the [min] value and
/// the left thumb, and the right thumb and the [max] value.
/// For RTL, the inactive side of the range selector is between the [max] value
/// and the left thumb, and the right thumb and the [min] value.
/// * The "divisors", which is a shape that renders on the track based on the
/// given [interval] value.
/// * The "ticks", which is a shape that rendered based on
/// given [interval] value. Basically, it is rendered below the track.
/// It is also called “major ticks”.
/// * The "minor ticks", which is a shape that renders between two major ticks
/// based on given [minorTicksPerInterval] value.
/// Basically, it is rendered below the track.
/// * The "labels", which is a text that rendered based on
/// given [interval] value.
/// Basically, it is rendered below the track and the major ticks.
/// * The "child", which can be any type of framework widget or custom widget
/// like [SfChart](https://pub.dev/documentation/syncfusion_flutter_charts/latest/charts/charts-library.html) as a child.
///
/// The range selector will be disabled if [enabled] is false or
/// [min] is equal to [max].
///
/// See also:
///
/// * [SfTheme](https://pub.dev/documentation/syncfusion_flutter_core/latest/theme/SfTheme-class.html)
/// and [SfThemeData](https://pub.dev/documentation/syncfusion_flutter_core/latest/theme/SfThemeData-class.html),
/// for customizing the visual appearance of the range selector.
class SfRangeSelectorThemeData extends SfRangeSliderThemeData {
  /// Returns a new instance of [SfRangeSelectorThemeData.raw]
  /// for the given values.
  ///
  /// If any of the values are null, the default values will be set.
  factory SfRangeSelectorThemeData(
      {Brightness? brightness,
      double? activeTrackHeight,
      double? inactiveTrackHeight,
      Size? tickSize,
      Size? minorTickSize,
      Offset? tickOffset,
      Offset? labelOffset,
      TextStyle? inactiveLabelStyle,
      TextStyle? activeLabelStyle,
      TextStyle? tooltipTextStyle,
      Color? inactiveTrackColor,
      Color? activeTrackColor,
      Color? thumbColor,
      Color? activeTickColor,
      Color? inactiveTickColor,
      Color? disabledActiveTickColor,
      Color? disabledInactiveTickColor,
      Color? activeMinorTickColor,
      Color? inactiveMinorTickColor,
      Color? disabledActiveMinorTickColor,
      Color? disabledInactiveMinorTickColor,
      Color? overlayColor,
      Color? inactiveDivisorColor,
      Color? activeDivisorColor,
      Color? disabledActiveTrackColor,
      Color? disabledInactiveTrackColor,
      Color? disabledActiveDivisorColor,
      Color? disabledInactiveDivisorColor,
      Color? disabledThumbColor,
      Color? activeRegionColor,
      Color? inactiveRegionColor,
      Color? tooltipBackgroundColor,
      Color? overlappingTooltipStrokeColor,
      Color? thumbStrokeColor,
      Color? overlappingThumbStrokeColor,
      Color? activeDivisorStrokeColor,
      Color? inactiveDivisorStrokeColor,
      double? trackCornerRadius,
      double? overlayRadius,
      double? thumbRadius,
      double? activeDivisorRadius,
      double? inactiveDivisorRadius,
      double? thumbStrokeWidth,
      double? activeDivisorStrokeWidth,
      double? inactiveDivisorStrokeWidth}) {
    brightness = brightness ?? Brightness.light;
    final bool isLight = brightness == Brightness.light;
    activeTrackHeight ??= 6.0;
    inactiveTrackHeight ??= 4.0;
    tickSize ??= const Size(1.0, 8.0);
    minorTickSize ??= const Size(1.0, 5.0);
    overlayRadius ??= 24.0;
    thumbRadius ??= 10.0;
    activeTickColor ??= const Color.fromRGBO(158, 158, 158, 1);
    inactiveTickColor ??= const Color.fromRGBO(158, 158, 158, 1);
    activeMinorTickColor ??= const Color.fromRGBO(158, 158, 158, 1);
    inactiveMinorTickColor ??= const Color.fromRGBO(158, 158, 158, 1);
    disabledActiveTickColor ??= const Color.fromRGBO(189, 189, 189, 1);
    disabledInactiveTickColor ??= const Color.fromRGBO(189, 189, 189, 1);
    disabledActiveMinorTickColor ??= const Color.fromRGBO(189, 189, 189, 1);
    disabledInactiveMinorTickColor ??= const Color.fromRGBO(189, 189, 189, 1);
    disabledThumbColor ??= const Color.fromRGBO(158, 158, 158, 1);
    activeRegionColor ??= isLight
        ? const Color.fromRGBO(255, 255, 255, 1).withOpacity(0)
        : const Color.fromRGBO(255, 255, 255, 1).withOpacity(0);
    inactiveRegionColor ??= isLight
        ? const Color.fromRGBO(255, 255, 255, 1).withOpacity(0.75)
        : const Color.fromRGBO(48, 48, 48, 1).withOpacity(0.75);

    return SfRangeSelectorThemeData.raw(
        brightness: brightness,
        activeTrackHeight: activeTrackHeight,
        inactiveTrackHeight: inactiveTrackHeight,
        tickSize: tickSize,
        minorTickSize: minorTickSize,
        tickOffset: tickOffset,
        labelOffset: labelOffset,
        inactiveLabelStyle: inactiveLabelStyle,
        activeLabelStyle: activeLabelStyle,
        tooltipTextStyle: tooltipTextStyle,
        inactiveTrackColor: inactiveTrackColor,
        activeTrackColor: activeTrackColor,
        inactiveDivisorColor: inactiveDivisorColor,
        activeDivisorColor: activeDivisorColor,
        thumbColor: thumbColor,
        thumbStrokeColor: thumbStrokeColor,
        overlappingThumbStrokeColor: overlappingThumbStrokeColor,
        activeDivisorStrokeColor: activeDivisorStrokeColor,
        inactiveDivisorStrokeColor: inactiveDivisorStrokeColor,
        overlayColor: overlayColor,
        activeTickColor: activeTickColor,
        inactiveTickColor: inactiveTickColor,
        disabledActiveTickColor: disabledActiveTickColor,
        disabledInactiveTickColor: disabledInactiveTickColor,
        activeMinorTickColor: activeMinorTickColor,
        inactiveMinorTickColor: inactiveMinorTickColor,
        disabledActiveMinorTickColor: disabledActiveMinorTickColor,
        disabledInactiveMinorTickColor: disabledInactiveMinorTickColor,
        disabledActiveTrackColor: disabledActiveTrackColor,
        disabledInactiveTrackColor: disabledInactiveTrackColor,
        disabledActiveDivisorColor: disabledActiveDivisorColor,
        disabledInactiveDivisorColor: disabledInactiveDivisorColor,
        disabledThumbColor: disabledThumbColor,
        activeRegionColor: activeRegionColor,
        inactiveRegionColor: inactiveRegionColor,
        tooltipBackgroundColor: tooltipBackgroundColor,
        overlappingTooltipStrokeColor: overlappingTooltipStrokeColor,
        overlayRadius: overlayRadius,
        thumbRadius: thumbRadius,
        activeDivisorRadius: activeDivisorRadius,
        inactiveDivisorRadius: inactiveDivisorRadius,
        thumbStrokeWidth: thumbStrokeWidth,
        activeDivisorStrokeWidth: activeDivisorStrokeWidth,
        inactiveDivisorStrokeWidth: inactiveDivisorStrokeWidth,
        trackCornerRadius: trackCornerRadius);
  }

  /// Create a [SfRangeSelectorThemeData] given a set of exact values.
  /// All the values must be specified.
  ///
  /// This will rarely be used directly. It is used by [lerp] to
  /// create intermediate themes based on two themes created with the
  /// [SfRangeSelectorThemeData] constructor.
  const SfRangeSelectorThemeData.raw({
    required Brightness brightness,
    required double activeTrackHeight,
    required double inactiveTrackHeight,
    required Size tickSize,
    required Size minorTickSize,
    required Offset? tickOffset,
    required Offset? labelOffset,
    required TextStyle? inactiveLabelStyle,
    required TextStyle? activeLabelStyle,
    required TextStyle? tooltipTextStyle,
    required Color? inactiveTrackColor,
    required Color? activeTrackColor,
    required Color? thumbColor,
    required Color? thumbStrokeColor,
    required Color? overlappingThumbStrokeColor,
    required Color? activeDivisorStrokeColor,
    required Color? inactiveDivisorStrokeColor,
    required Color activeTickColor,
    required Color inactiveTickColor,
    required Color disabledActiveTickColor,
    required Color disabledInactiveTickColor,
    required Color activeMinorTickColor,
    required Color inactiveMinorTickColor,
    required Color disabledActiveMinorTickColor,
    required Color disabledInactiveMinorTickColor,
    required Color? overlayColor,
    required Color? inactiveDivisorColor,
    required Color? activeDivisorColor,
    required Color? disabledActiveTrackColor,
    required Color? disabledInactiveTrackColor,
    required Color? disabledActiveDivisorColor,
    required Color? disabledInactiveDivisorColor,
    required Color disabledThumbColor,
    required this.activeRegionColor,
    required this.inactiveRegionColor,
    required Color? tooltipBackgroundColor,
    required Color? overlappingTooltipStrokeColor,
    required double? trackCornerRadius,
    required double overlayRadius,
    required double thumbRadius,
    required double? activeDivisorRadius,
    required double? inactiveDivisorRadius,
    required double? thumbStrokeWidth,
    required double? activeDivisorStrokeWidth,
    required double? inactiveDivisorStrokeWidth,
  }) : super.raw(
            brightness: brightness,
            activeTrackHeight: activeTrackHeight,
            inactiveTrackHeight: inactiveTrackHeight,
            tickSize: tickSize,
            minorTickSize: minorTickSize,
            tickOffset: tickOffset,
            labelOffset: labelOffset,
            inactiveLabelStyle: inactiveLabelStyle,
            activeLabelStyle: activeLabelStyle,
            tooltipTextStyle: tooltipTextStyle,
            inactiveTrackColor: inactiveTrackColor,
            activeTrackColor: activeTrackColor,
            inactiveDivisorColor: inactiveDivisorColor,
            activeDivisorColor: activeDivisorColor,
            thumbColor: thumbColor,
            thumbStrokeColor: thumbStrokeColor,
            overlappingThumbStrokeColor: overlappingThumbStrokeColor,
            activeDivisorStrokeColor: activeDivisorStrokeColor,
            inactiveDivisorStrokeColor: inactiveDivisorStrokeColor,
            overlayColor: overlayColor,
            activeTickColor: activeTickColor,
            inactiveTickColor: inactiveTickColor,
            disabledActiveTickColor: disabledActiveTickColor,
            disabledInactiveTickColor: disabledInactiveTickColor,
            activeMinorTickColor: activeMinorTickColor,
            inactiveMinorTickColor: inactiveMinorTickColor,
            disabledActiveMinorTickColor: disabledActiveMinorTickColor,
            disabledInactiveMinorTickColor: disabledInactiveMinorTickColor,
            disabledActiveTrackColor: disabledActiveTrackColor,
            disabledInactiveTrackColor: disabledInactiveTrackColor,
            disabledActiveDivisorColor: disabledActiveDivisorColor,
            disabledInactiveDivisorColor: disabledInactiveDivisorColor,
            disabledThumbColor: disabledThumbColor,
            tooltipBackgroundColor: tooltipBackgroundColor,
            overlappingTooltipStrokeColor: overlappingTooltipStrokeColor,
            overlayRadius: overlayRadius,
            thumbRadius: thumbRadius,
            activeDivisorRadius: activeDivisorRadius,
            inactiveDivisorRadius: inactiveDivisorRadius,
            thumbStrokeWidth: thumbStrokeWidth,
            activeDivisorStrokeWidth: activeDivisorStrokeWidth,
            inactiveDivisorStrokeWidth: inactiveDivisorStrokeWidth,
            trackCornerRadius: trackCornerRadius);

  /// Specifies the color for the active region of the
  /// child in the [SfRangeSelector].
  ///
  /// The active side of the [SfRangeSlider] and [SfRangeSelector]
  /// is between start and end thumbs.
  ///
  /// This snippet shows how to set active region
  /// color in [SfRangeSliderThemeData].
  ///
  /// ```dart
  /// SfRangeValues _values = SfRangeValues(4.0, 8.0);
  ///
  /// Scaffold(
  ///     body: Center(
  ///         child: SfRangeSelectorTheme(
  ///             data: SfRangeSliderThemeData(
  ///                 activeRegionColor: Colors.blue[200],
  ///             ),
  ///             child:  SfRangeSelector(
  ///                min: 2.0,
  ///                max: 10.0,
  ///                interval: 1,
  ///                showLabels: true,
  ///                showTicks: true,
  ///                initialValues: _values,
  ///                child: Container(
  ///                   height: 200,
  ///                   color: Colors.pink,
  ///                ),
  ///            )
  ///        ),
  ///    )
  /// )
  /// ```
  final Color activeRegionColor;

  /// Specifies the color for the inactive region of the child
  /// in the [SfRangeSelector].
  ///
  /// The inactive side of the [SfRangeSlider] and [SfRangeSelector] is between
  /// the [min] value and the left thumb,
  /// and the right thumb and the [max] value.
  ///
  /// For RTL, the inactive side is between the [max] value and the left thumb,
  /// and the right thumb and the [min] value.
  ///
  /// This snippet shows how to set inactive region
  /// color in [SfRangeSliderThemeData].
  ///
  /// ```dart
  /// SfRangeValues _values = SfRangeValues(4.0, 8.0);
  ///
  /// Scaffold(
  ///     body: Center(
  ///         child: SfRangeSelectorTheme(
  ///             data: SfRangeSliderThemeData(
  ///                 inactiveRegionColor: Colors.blue[200],
  ///             ),
  ///             child:  SfRangeSelector(
  ///                min: 2.0,
  ///                max: 10.0,
  ///                interval: 1,
  ///                showLabels: true,
  ///                showTicks: true,
  ///                initialValues: _values,
  ///                child: Container(
  ///                   height: 200,
  ///                   color: Colors.pink,
  ///                ),
  ///            )
  ///        ),
  ///    )
  /// )
  /// ```
  final Color inactiveRegionColor;

  /// Creates a copy of this theme but with the given
  /// fields replaced with the new values.
  @override
  SfRangeSelectorThemeData copyWith({
    Brightness? brightness,
    double? activeTrackHeight,
    double? inactiveTrackHeight,
    Size? tickSize,
    Size? minorTickSize,
    Offset? tickOffset,
    Offset? labelOffset,
    TextStyle? inactiveLabelStyle,
    TextStyle? activeLabelStyle,
    TextStyle? tooltipTextStyle,
    Color? inactiveTrackColor,
    Color? activeTrackColor,
    Color? thumbColor,
    Color? thumbStrokeColor,
    Color? overlappingThumbStrokeColor,
    Color? activeDivisorStrokeColor,
    Color? inactiveDivisorStrokeColor,
    Color? activeTickColor,
    Color? inactiveTickColor,
    Color? disabledActiveTickColor,
    Color? disabledInactiveTickColor,
    Color? activeMinorTickColor,
    Color? inactiveMinorTickColor,
    Color? disabledActiveMinorTickColor,
    Color? disabledInactiveMinorTickColor,
    Color? overlayColor,
    Color? inactiveDivisorColor,
    Color? activeDivisorColor,
    Color? disabledActiveTrackColor,
    Color? disabledInactiveTrackColor,
    Color? disabledActiveDivisorColor,
    Color? disabledInactiveDivisorColor,
    Color? disabledThumbColor,
    Color? activeRegionColor,
    Color? inactiveRegionColor,
    Color? tooltipBackgroundColor,
    Color? overlappingTooltipStrokeColor,
    double? trackCornerRadius,
    double? overlayRadius,
    double? thumbRadius,
    double? activeDivisorRadius,
    double? inactiveDivisorRadius,
    double? thumbStrokeWidth,
    double? activeDivisorStrokeWidth,
    double? inactiveDivisorStrokeWidth,
  }) {
    return SfRangeSelectorThemeData.raw(
      brightness: brightness ?? this.brightness,
      activeTrackHeight: activeTrackHeight ?? this.activeTrackHeight,
      inactiveTrackHeight: inactiveTrackHeight ?? this.inactiveTrackHeight,
      tickSize: tickSize ?? this.tickSize,
      minorTickSize: minorTickSize ?? this.minorTickSize,
      tickOffset: tickOffset ?? this.tickOffset,
      labelOffset: labelOffset ?? this.labelOffset,
      inactiveLabelStyle: inactiveLabelStyle ?? this.inactiveLabelStyle,
      activeLabelStyle: activeLabelStyle ?? this.activeLabelStyle,
      tooltipTextStyle: tooltipTextStyle ?? this.tooltipTextStyle,
      inactiveTrackColor: inactiveTrackColor ?? this.inactiveTrackColor,
      activeTrackColor: activeTrackColor ?? this.activeTrackColor,
      thumbColor: thumbColor ?? this.thumbColor,
      thumbStrokeColor: thumbStrokeColor ?? this.thumbStrokeColor,
      overlappingThumbStrokeColor:
          overlappingThumbStrokeColor ?? this.overlappingThumbStrokeColor,
      activeDivisorStrokeColor:
          activeDivisorStrokeColor ?? this.activeDivisorStrokeColor,
      inactiveDivisorStrokeColor:
          inactiveDivisorStrokeColor ?? this.inactiveDivisorStrokeColor,
      activeTickColor: activeTickColor ?? this.activeTickColor,
      inactiveTickColor: inactiveTickColor ?? this.inactiveTickColor,
      disabledActiveTickColor:
          disabledActiveTickColor ?? this.disabledActiveTickColor,
      disabledInactiveTickColor:
          disabledInactiveTickColor ?? this.disabledInactiveTickColor,
      activeMinorTickColor: activeMinorTickColor ?? this.activeMinorTickColor,
      inactiveMinorTickColor:
          inactiveMinorTickColor ?? this.inactiveMinorTickColor,
      disabledActiveMinorTickColor:
          disabledActiveMinorTickColor ?? this.disabledActiveMinorTickColor,
      disabledInactiveMinorTickColor:
          disabledInactiveMinorTickColor ?? this.disabledInactiveMinorTickColor,
      overlayColor: overlayColor ?? this.overlayColor,
      inactiveDivisorColor: inactiveDivisorColor ?? this.inactiveDivisorColor,
      activeDivisorColor: activeDivisorColor ?? this.activeDivisorColor,
      disabledActiveTrackColor:
          disabledActiveTrackColor ?? this.disabledActiveTrackColor,
      disabledInactiveTrackColor:
          disabledInactiveTrackColor ?? this.disabledInactiveTrackColor,
      disabledActiveDivisorColor:
          disabledActiveDivisorColor ?? this.disabledActiveDivisorColor,
      disabledInactiveDivisorColor:
          disabledInactiveDivisorColor ?? this.disabledInactiveDivisorColor,
      disabledThumbColor: disabledThumbColor ?? this.disabledThumbColor,
      activeRegionColor: activeRegionColor ?? this.activeRegionColor,
      inactiveRegionColor: inactiveRegionColor ?? this.inactiveRegionColor,
      tooltipBackgroundColor:
          tooltipBackgroundColor ?? this.tooltipBackgroundColor,
      overlappingTooltipStrokeColor:
          overlappingTooltipStrokeColor ?? this.overlappingTooltipStrokeColor,
      trackCornerRadius: trackCornerRadius ?? this.trackCornerRadius,
      overlayRadius: overlayRadius ?? this.overlayRadius,
      thumbRadius: thumbRadius ?? this.thumbRadius,
      activeDivisorRadius: activeDivisorRadius ?? this.activeDivisorRadius,
      inactiveDivisorRadius:
          inactiveDivisorRadius ?? this.inactiveDivisorRadius,
      thumbStrokeWidth: thumbStrokeWidth ?? this.thumbStrokeWidth,
      activeDivisorStrokeWidth:
          activeDivisorStrokeWidth ?? this.activeDivisorStrokeWidth,
      inactiveDivisorStrokeWidth:
          inactiveDivisorStrokeWidth ?? this.inactiveDivisorStrokeWidth,
    );
  }

  /// Linearly interpolate between two themes.
  ///
  /// The arguments must not be null.
  static SfRangeSelectorThemeData? lerp(
      SfRangeSelectorThemeData a, SfRangeSelectorThemeData b, double t) {
    return SfRangeSelectorThemeData(
        activeTrackHeight:
            lerpDouble(a.activeTrackHeight, b.activeTrackHeight, t),
        inactiveTrackHeight:
            lerpDouble(a.inactiveTrackHeight, b.inactiveTrackHeight, t),
        tickSize: Size.lerp(a.tickSize, b.tickSize, t),
        minorTickSize: Size.lerp(a.minorTickSize, b.minorTickSize, t),
        tickOffset: Offset.lerp(a.tickOffset, b.tickOffset, t),
        labelOffset: Offset.lerp(a.labelOffset, b.labelOffset, t),
        inactiveLabelStyle:
            TextStyle.lerp(a.inactiveLabelStyle, b.inactiveLabelStyle, t),
        activeLabelStyle:
            TextStyle.lerp(a.activeLabelStyle, b.activeLabelStyle, t),
        tooltipTextStyle:
            TextStyle.lerp(a.tooltipTextStyle, b.tooltipTextStyle, t),
        inactiveTrackColor:
            Color.lerp(a.inactiveTrackColor, b.inactiveTrackColor, t),
        activeTrackColor: Color.lerp(a.activeTrackColor, b.activeTrackColor, t),
        thumbColor: Color.lerp(a.thumbColor, b.thumbColor, t),
        thumbStrokeColor: Color.lerp(a.thumbStrokeColor, b.thumbStrokeColor, t),
        overlappingThumbStrokeColor: Color.lerp(
            a.overlappingThumbStrokeColor, b.overlappingThumbStrokeColor, t),
        activeDivisorStrokeColor: Color.lerp(
            a.activeDivisorStrokeColor, b.activeDivisorStrokeColor, t),
        inactiveDivisorStrokeColor: Color.lerp(
            a.inactiveDivisorStrokeColor, b.inactiveDivisorStrokeColor, t),
        activeTickColor: Color.lerp(a.activeTickColor, b.activeTickColor, t),
        inactiveTickColor:
            Color.lerp(a.inactiveTickColor, b.inactiveTickColor, t),
        disabledActiveTickColor:
            Color.lerp(a.disabledActiveTickColor, b.disabledActiveTickColor, t),
        disabledInactiveTickColor: Color.lerp(
            a.disabledInactiveTickColor, b.disabledInactiveTickColor, t),
        activeMinorTickColor:
            Color.lerp(a.activeMinorTickColor, b.activeMinorTickColor, t),
        inactiveMinorTickColor:
            Color.lerp(a.inactiveMinorTickColor, b.inactiveMinorTickColor, t),
        disabledActiveMinorTickColor: Color.lerp(
            a.disabledActiveMinorTickColor, b.disabledActiveMinorTickColor, t),
        disabledInactiveMinorTickColor: Color.lerp(
            a.disabledInactiveMinorTickColor,
            b.disabledInactiveMinorTickColor,
            t),
        overlayColor: Color.lerp(a.overlayColor, b.overlayColor, t),
        inactiveDivisorColor:
            Color.lerp(a.inactiveDivisorColor, b.inactiveDivisorColor, t),
        activeDivisorColor:
            Color.lerp(a.activeDivisorColor, b.activeDivisorColor, t),
        disabledActiveTrackColor: Color.lerp(
            a.disabledActiveTrackColor, b.disabledActiveTrackColor, t),
        disabledInactiveTrackColor: Color.lerp(
            a.disabledInactiveTrackColor, b.disabledInactiveTrackColor, t),
        disabledActiveDivisorColor: Color.lerp(
            a.disabledActiveDivisorColor, b.disabledActiveDivisorColor, t),
        disabledInactiveDivisorColor: Color.lerp(
            a.disabledInactiveDivisorColor, b.disabledInactiveDivisorColor, t),
        disabledThumbColor:
            Color.lerp(a.disabledThumbColor, b.disabledThumbColor, t),
        activeRegionColor:
            Color.lerp(a.activeRegionColor, b.activeRegionColor, t),
        inactiveRegionColor:
            Color.lerp(a.inactiveRegionColor, b.inactiveRegionColor, t),
        tooltipBackgroundColor:
            Color.lerp(a.tooltipBackgroundColor, b.tooltipBackgroundColor, t),
        overlappingTooltipStrokeColor: Color.lerp(a.overlappingTooltipStrokeColor, b.overlappingTooltipStrokeColor, t),
        trackCornerRadius: lerpDouble(a.trackCornerRadius, b.trackCornerRadius, t),
        overlayRadius: lerpDouble(a.overlayRadius, b.overlayRadius, t),
        thumbRadius: lerpDouble(a.thumbRadius, b.thumbRadius, t),
        activeDivisorRadius: lerpDouble(a.activeDivisorRadius, b.activeDivisorRadius, t),
        inactiveDivisorRadius: lerpDouble(a.inactiveDivisorRadius, b.inactiveDivisorRadius, t),
        thumbStrokeWidth: lerpDouble(a.thumbStrokeWidth, b.thumbStrokeWidth, t),
        activeDivisorStrokeWidth: lerpDouble(a.activeDivisorStrokeWidth, b.activeDivisorStrokeWidth, t),
        inactiveDivisorStrokeWidth: lerpDouble(a.inactiveDivisorStrokeWidth, b.inactiveDivisorStrokeWidth, t));
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    final SfRangeSelectorThemeData otherData =
        other as SfRangeSelectorThemeData;
    return otherData.brightness == brightness &&
        otherData.activeTrackHeight == activeTrackHeight &&
        otherData.inactiveTrackHeight == inactiveTrackHeight &&
        otherData.tickSize == tickSize &&
        otherData.minorTickSize == minorTickSize &&
        otherData.tickOffset == tickOffset &&
        otherData.labelOffset == labelOffset &&
        otherData.inactiveLabelStyle == inactiveLabelStyle &&
        otherData.activeLabelStyle == activeLabelStyle &&
        otherData.tooltipTextStyle == tooltipTextStyle &&
        otherData.inactiveTrackColor == inactiveTrackColor &&
        otherData.activeTrackColor == activeTrackColor &&
        otherData.thumbColor == thumbColor &&
        otherData.thumbStrokeColor == thumbStrokeColor &&
        otherData.overlappingThumbStrokeColor == overlappingThumbStrokeColor &&
        otherData.activeDivisorStrokeColor == activeDivisorStrokeColor &&
        otherData.inactiveDivisorStrokeColor == inactiveDivisorStrokeColor &&
        otherData.activeTickColor == activeTickColor &&
        otherData.inactiveTickColor == inactiveTickColor &&
        otherData.disabledActiveTickColor == disabledActiveTickColor &&
        otherData.disabledInactiveTickColor == disabledInactiveTickColor &&
        otherData.activeMinorTickColor == activeMinorTickColor &&
        otherData.inactiveMinorTickColor == inactiveMinorTickColor &&
        otherData.disabledActiveMinorTickColor ==
            disabledActiveMinorTickColor &&
        otherData.disabledInactiveMinorTickColor ==
            disabledInactiveMinorTickColor &&
        otherData.overlayColor == overlayColor &&
        otherData.inactiveDivisorColor == inactiveDivisorColor &&
        otherData.activeDivisorColor == activeDivisorColor &&
        otherData.disabledActiveTrackColor == disabledActiveTrackColor &&
        otherData.disabledInactiveTrackColor == disabledInactiveTrackColor &&
        otherData.disabledActiveDivisorColor == disabledActiveDivisorColor &&
        otherData.disabledInactiveDivisorColor ==
            disabledInactiveDivisorColor &&
        otherData.disabledThumbColor == disabledThumbColor &&
        otherData.activeRegionColor == activeRegionColor &&
        otherData.inactiveRegionColor == inactiveRegionColor &&
        otherData.tooltipBackgroundColor == tooltipBackgroundColor &&
        otherData.overlappingTooltipStrokeColor ==
            overlappingTooltipStrokeColor &&
        otherData.trackCornerRadius == trackCornerRadius &&
        otherData.overlayRadius == overlayRadius &&
        otherData.thumbRadius == thumbRadius &&
        otherData.activeDivisorRadius == activeDivisorRadius &&
        otherData.inactiveDivisorRadius == inactiveDivisorRadius &&
        otherData.thumbStrokeWidth == thumbStrokeWidth &&
        otherData.activeDivisorStrokeWidth == activeDivisorStrokeWidth &&
        otherData.inactiveDivisorStrokeWidth == inactiveDivisorStrokeWidth;
  }

  @override
  int get hashCode {
    return hashList(<Object?>[
      brightness,
      activeTrackHeight,
      inactiveTrackHeight,
      tickSize,
      minorTickSize,
      tickOffset,
      labelOffset,
      inactiveLabelStyle,
      activeLabelStyle,
      tooltipTextStyle,
      inactiveTrackColor,
      activeTrackColor,
      thumbColor,
      thumbStrokeColor,
      overlappingThumbStrokeColor,
      activeDivisorStrokeColor,
      inactiveDivisorStrokeColor,
      activeTickColor,
      inactiveTickColor,
      disabledActiveTickColor,
      disabledInactiveTickColor,
      activeMinorTickColor,
      inactiveMinorTickColor,
      disabledActiveMinorTickColor,
      disabledInactiveMinorTickColor,
      overlayColor,
      inactiveDivisorColor,
      activeDivisorColor,
      disabledActiveTrackColor,
      disabledInactiveTrackColor,
      disabledActiveDivisorColor,
      disabledInactiveDivisorColor,
      disabledThumbColor,
      activeRegionColor,
      inactiveRegionColor,
      tooltipBackgroundColor,
      overlappingTooltipStrokeColor,
      trackCornerRadius,
      overlayRadius,
      activeDivisorRadius,
      inactiveDivisorRadius,
      thumbRadius,
      thumbStrokeWidth,
      activeDivisorStrokeWidth,
      inactiveDivisorStrokeWidth,
    ]);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    final SfRangeSelectorThemeData defaultData = SfRangeSelectorThemeData();
    properties.add(EnumProperty<Brightness>('brightness', brightness,
        defaultValue: defaultData.brightness));
    properties.add(DoubleProperty('activeTrackHeight', activeTrackHeight,
        defaultValue: defaultData.activeTrackHeight));
    properties.add(DoubleProperty('inactiveTrackHeight', inactiveTrackHeight,
        defaultValue: defaultData.inactiveTrackHeight));
    properties.add(DiagnosticsProperty<Size>('tickSize', tickSize,
        defaultValue: defaultData.tickSize));
    properties.add(DiagnosticsProperty<Size>('minorTickSize', minorTickSize,
        defaultValue: defaultData.minorTickSize));
    properties.add(DiagnosticsProperty<Offset>('tickOffset', tickOffset,
        defaultValue: defaultData.tickOffset));
    properties.add(DiagnosticsProperty<Offset>('labelOffset', labelOffset,
        defaultValue: defaultData.labelOffset));
    properties.add(DiagnosticsProperty<TextStyle>(
        'inactiveLabelStyle', inactiveLabelStyle,
        defaultValue: defaultData.inactiveLabelStyle));
    properties.add(DiagnosticsProperty<TextStyle>(
        'activeLabelStyle', activeLabelStyle,
        defaultValue: defaultData.activeLabelStyle));
    properties.add(DiagnosticsProperty<TextStyle>(
        'tooltipTextStyle', tooltipTextStyle,
        defaultValue: defaultData.tooltipTextStyle));
    properties.add(ColorProperty('inactiveTrackColor', inactiveTrackColor,
        defaultValue: defaultData.inactiveTrackColor));
    properties.add(ColorProperty('activeTrackColor', activeTrackColor,
        defaultValue: defaultData.activeTrackColor));
    properties.add(ColorProperty('thumbColor', thumbColor,
        defaultValue: defaultData.thumbColor));
    properties.add(ColorProperty('thumbStrokeColor', thumbStrokeColor,
        defaultValue: defaultData.thumbStrokeColor));
    properties.add(ColorProperty(
        'overlappingThumbStrokeColor', overlappingThumbStrokeColor,
        defaultValue: defaultData.overlappingThumbStrokeColor));
    properties.add(ColorProperty(
        'activeDivisorStrokeColor', activeDivisorStrokeColor,
        defaultValue: defaultData.activeDivisorStrokeColor));
    properties.add(ColorProperty(
        'inactiveDivisorStrokeColor', inactiveDivisorStrokeColor,
        defaultValue: defaultData.inactiveDivisorStrokeColor));
    properties.add(ColorProperty('activeTickColor', activeTickColor,
        defaultValue: defaultData.activeTickColor));
    properties.add(ColorProperty('inactiveTickColor', inactiveTickColor,
        defaultValue: defaultData.inactiveTickColor));
    properties.add(ColorProperty(
        'disabledActiveTickColor', disabledActiveTickColor,
        defaultValue: defaultData.disabledActiveTickColor));
    properties.add(ColorProperty(
        'disabledInactiveTickColor', disabledInactiveTickColor,
        defaultValue: defaultData.disabledInactiveTickColor));
    properties.add(ColorProperty('activeMinorTickColor', activeMinorTickColor,
        defaultValue: defaultData.activeMinorTickColor));
    properties.add(ColorProperty(
        'inactiveMinorTickColor', inactiveMinorTickColor,
        defaultValue: defaultData.inactiveMinorTickColor));
    properties.add(ColorProperty(
        'disabledActiveMinorTickColor', disabledActiveMinorTickColor,
        defaultValue: defaultData.disabledActiveMinorTickColor));
    properties.add(ColorProperty(
        'disabledInactiveMinorTickColor', disabledInactiveMinorTickColor,
        defaultValue: defaultData.disabledInactiveMinorTickColor));
    properties.add(ColorProperty('overlayColor', overlayColor,
        defaultValue: defaultData.overlayColor));
    properties.add(ColorProperty('inactiveDivisorColor', inactiveDivisorColor,
        defaultValue: defaultData.inactiveDivisorColor));
    properties.add(ColorProperty('activeDivisorColor', activeDivisorColor,
        defaultValue: defaultData.activeDivisorColor));
    properties.add(ColorProperty(
        'disabledActiveTrackColor', disabledActiveTrackColor,
        defaultValue: defaultData.disabledActiveTrackColor));
    properties.add(ColorProperty(
        'disabledInactiveTrackColor', disabledInactiveTrackColor,
        defaultValue: defaultData.disabledInactiveTrackColor));
    properties.add(ColorProperty(
        'disabledActiveDivisorColor', disabledActiveDivisorColor,
        defaultValue: defaultData.disabledActiveDivisorColor));
    properties.add(ColorProperty(
        'disabledInactiveDivisorColor', disabledInactiveDivisorColor,
        defaultValue: defaultData.disabledInactiveDivisorColor));
    properties.add(ColorProperty('disabledThumbColor', disabledThumbColor,
        defaultValue: defaultData.disabledThumbColor));
    properties.add(ColorProperty('activeRegionColor', activeRegionColor,
        defaultValue: defaultData.activeRegionColor));
    properties.add(ColorProperty('inactiveRegionColor', inactiveRegionColor,
        defaultValue: defaultData.inactiveRegionColor));
    properties.add(ColorProperty(
        'tooltipBackgroundColor', tooltipBackgroundColor,
        defaultValue: defaultData.tooltipBackgroundColor));
    properties.add(ColorProperty(
        'overlappingTooltipStrokeColor', overlappingTooltipStrokeColor,
        defaultValue: defaultData.overlappingTooltipStrokeColor));
    properties.add(DoubleProperty('trackCornerRadius', trackCornerRadius,
        defaultValue: defaultData.trackCornerRadius));
    properties.add(DoubleProperty('overlayRadius', overlayRadius,
        defaultValue: defaultData.overlayRadius));
    properties.add(DoubleProperty('thumbRadius', thumbRadius,
        defaultValue: defaultData.thumbRadius));
    properties.add(DoubleProperty('activeDivisorRadius', activeDivisorRadius,
        defaultValue: defaultData.activeDivisorRadius));
    properties.add(DoubleProperty(
        'inactiveDivisorRadius', inactiveDivisorRadius,
        defaultValue: defaultData.inactiveDivisorRadius));
    properties.add(DoubleProperty('thumbStrokeWidth', thumbStrokeWidth,
        defaultValue: defaultData.thumbStrokeWidth));
    properties.add(DoubleProperty(
        'activeDivisorStrokeWidth', activeDivisorStrokeWidth,
        defaultValue: defaultData.activeDivisorStrokeWidth));
    properties.add(DoubleProperty(
        'inactiveDivisorStrokeWidth', inactiveDivisorStrokeWidth,
        defaultValue: defaultData.inactiveDivisorStrokeWidth));
  }
}
