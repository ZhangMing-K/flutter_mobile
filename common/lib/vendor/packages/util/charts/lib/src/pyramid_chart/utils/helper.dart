part of charts;

/// Method for checking if point is within polygon
bool _isPointInPolygon(List<Offset> polygon, dynamic point) {
  bool p = false;
  num i = -1;
  final num l = polygon.length;
  num j;
  for (j = l - 1; ++i < l; j = i) {
    ((polygon[i as int].dy <= point.dy && point.dy < polygon[j as int].dy) ||
            (polygon[j as int].dy <= point.dy && point.dy < polygon[i].dy)) &&
        (point.dx <
            (polygon[j].dx - polygon[i].dx) *
                    (point.dy - polygon[i].dy) /
                    (polygon[j].dy - polygon[i].dy) +
                polygon[i].dx) &&
        // ignore: unnecessary_statements
        (p = !p);
  }
  return p;
}

/// To add chart templates
void _findTemplates(dynamic _chartState) {
  Offset? labelLocation;
  const num lineLength = 10;
  PointInfo<dynamic>? point;
  Widget? labelWidget;
  _chartState._templates = <_ChartTemplateInfo>[];
  _chartState._dataLabelTemplateRegions = <Rect>[];
  dynamic series;
  for (int k = 0;
      k < _chartState._chartSeries.visibleSeriesRenderers.length;
      k++) {
    final dynamic seriesRenderer =
        _chartState._chartSeries.visibleSeriesRenderers[k];
    series = seriesRenderer._series;
    if (series.dataLabelSettings.isVisible &&
        series.dataLabelSettings.builder != null) {
      for (int i = 0; i < seriesRenderer._renderPoints.length; i++) {
        point = seriesRenderer._renderPoints[i];
        ChartAlignment labelAlign;
        if (point!.isVisible) {
          labelWidget = series.dataLabelSettings
              .builder(series.dataSource[i], point, series, i, k);
          if (series.dataLabelSettings.labelPosition ==
              ChartDataLabelPosition.inside) {
            labelLocation = point.symbolLocation;
            labelAlign = ChartAlignment.center;
          } else {
            labelLocation = point.symbolLocation;
            labelLocation = Offset(
                point.dataLabelPosition == Position.right
                    ? labelLocation!.dx + lineLength + 5
                    : labelLocation!.dx - lineLength - 5,
                labelLocation.dy);
            labelAlign = point.dataLabelPosition == Position.left
                ? ChartAlignment.far
                : ChartAlignment.near;
          }
          _chartState._templates.add(_ChartTemplateInfo(
              key: GlobalKey(),
              templateType: 'DataLabel',
              pointIndex: i,
              seriesIndex: k,
              needMeasure: true,
              clipRect: _chartState._chartAreaRect,
              animationDuration: 500,
              widget: labelWidget,
              horizontalAlignment: labelAlign,
              verticalAlignment: ChartAlignment.center,
              location: labelLocation));
        }
      }
    }
  }
}

/// To render a template
void _renderTemplates(dynamic _chartState) {
  if (_chartState._templates.isNotEmpty) {
    for (int i = 0; i < _chartState._templates.length; i++) {
      final _ChartTemplateInfo chartTemplateInfo = _chartState._templates[i];
      chartTemplateInfo.animationDuration =
          !_chartState._initialRender ? 0 : chartTemplateInfo.animationDuration;
    }
    _chartState._chartTemplate = _ChartTemplate(
        templates: _chartState._templates,
        render: _chartState._animateCompleted,
        chartState: _chartState);
    _chartState._chartWidgets.add(_chartState._chartTemplate);
  }
}

///To get pyramid series data label saturation color
Color _getPyramidFunnelColor(PointInfo<dynamic> currentPoint,
    dynamic seriesRenderer, dynamic _chartState) {
  Color color;
  final dynamic series = seriesRenderer._series;
  final DataLabelSettings? dataLabel = series.dataLabelSettings;
  final DataLabelSettingsRenderer? dataLabelSettingsRenderer =
      seriesRenderer._dataLabelSettingsRenderer;
  if (currentPoint.renderPosition == null ||
      currentPoint.renderPosition == ChartDataLabelPosition.inside &&
          !currentPoint.saturationRegionOutside) {
    color = _innerColor(dataLabelSettingsRenderer!._color, currentPoint.fill,
        _chartState._chartTheme);
  } else {
    color = _outerColor(
        dataLabelSettingsRenderer!._color,
        dataLabel!.useSeriesColor
            ? currentPoint.fill
            : (_chartState._chart.backgroundColor != null
                ? _chartState._chartTheme.plotAreaBackgroundColor
                : null),
        _chartState._chartTheme);
  }

  return _getSaturationColor(color);
}

///To get inner data label color
Color _innerColor(
        Color? dataLabelColor, Color? pointColor, SfChartThemeData? theme) =>
    dataLabelColor ?? pointColor ?? Colors.black;

///To get outer data label color
Color _outerColor(Color? dataLabelColor, Color? backgroundColor,
        SfChartThemeData? theme) =>
    // ignore: prefer_if_null_operators
    dataLabelColor != null
        ? dataLabelColor
        // ignore: prefer_if_null_operators
        : backgroundColor != null
            ? backgroundColor
            : theme!.brightness == Brightness.light
                ? const Color.fromRGBO(255, 255, 255, 1)
                : Colors.black;

///To get outer data label text style
TextStyle _getDataLabelTextStyle(
    dynamic seriesRenderer, PointInfo<dynamic> point, dynamic chartState,
    [double? animateOpacity]) {
  final dynamic series = seriesRenderer._series;
  final DataLabelSettings dataLabel = series.dataLabelSettings;
  final Color fontColor = dataLabel.textStyle.color ??
      _getPyramidFunnelColor(point, seriesRenderer, chartState);
  final TextStyle textStyle = TextStyle(
      color: fontColor.withOpacity(animateOpacity ?? 1),
      fontSize: dataLabel.textStyle.fontSize,
      fontFamily: dataLabel.textStyle.fontFamily,
      fontStyle: dataLabel.textStyle.fontStyle,
      fontWeight: dataLabel.textStyle.fontWeight,
      inherit: dataLabel.textStyle.inherit,
      backgroundColor: dataLabel.textStyle.backgroundColor,
      letterSpacing: dataLabel.textStyle.letterSpacing,
      wordSpacing: dataLabel.textStyle.wordSpacing,
      textBaseline: dataLabel.textStyle.textBaseline,
      height: dataLabel.textStyle.height,
      locale: dataLabel.textStyle.locale,
      foreground: dataLabel.textStyle.foreground,
      background: dataLabel.textStyle.background,
      shadows: dataLabel.textStyle.shadows,
      fontFeatures: dataLabel.textStyle.fontFeatures,
      decoration: dataLabel.textStyle.decoration,
      decorationColor: dataLabel.textStyle.decorationColor,
      decorationStyle: dataLabel.textStyle.decorationStyle,
      decorationThickness: dataLabel.textStyle.decorationThickness,
      debugLabel: dataLabel.textStyle.debugLabel,
      fontFamilyFallback: dataLabel.textStyle.fontFamilyFallback);
  return textStyle;
}

/// To check the point explosion
bool? _isNeedExplode(int pointIndex, dynamic series, dynamic _chartState) {
  bool? isNeedExplode = false;
  if (series.explode) {
    if (_chartState._initialRender) {
      if (pointIndex == series.explodeIndex) {
        _chartState._explodedPoints.add(pointIndex);
        isNeedExplode = true;
      }
    } else if (_chartState._widgetNeedUpdate || _chartState._isLegendToggled) {
      isNeedExplode = _chartState._explodedPoints.contains(pointIndex);
    }
  }
  return isNeedExplode;
}

/// To return data label rect calculation method based on position
Rect? _getDataLabelRect(Position? position, ConnectorType connectorType,
    EdgeInsets margin, Path connectorPath, Offset endPoint, Size textSize) {
  Rect? rect;
  const int lineLength = 10;
  switch (position!) {
    case Position.right:
      connectorType == ConnectorType.line
          ? connectorPath.lineTo(endPoint.dx + lineLength, endPoint.dy)
          : connectorPath.quadraticBezierTo(
              endPoint.dx, endPoint.dy, endPoint.dx + lineLength, endPoint.dy);
      rect = Rect.fromLTWH(
          endPoint.dx + lineLength,
          endPoint.dy - (textSize.height / 2) - margin.top,
          textSize.width + margin.left + margin.right,
          textSize.height + margin.top + margin.bottom);
      break;
    case Position.left:
      connectorType == ConnectorType.line
          ? connectorPath.lineTo(endPoint.dx - lineLength, endPoint.dy)
          : connectorPath.quadraticBezierTo(
              endPoint.dx, endPoint.dy, endPoint.dx - lineLength, endPoint.dy);
      rect = Rect.fromLTWH(
          endPoint.dx -
              lineLength -
              margin.right -
              textSize.width -
              margin.left,
          endPoint.dy - (textSize.height / 2) - margin.top,
          textSize.width + margin.left + margin.right,
          textSize.height + margin.top + margin.bottom);
      break;
  }
  return rect;
}
