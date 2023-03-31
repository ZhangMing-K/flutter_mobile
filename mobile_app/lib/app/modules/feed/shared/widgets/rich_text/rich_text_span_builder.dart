import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

class AssetText extends SpecialText {
  static const String startKey = r'<C';
  static const String endKey = r'</C>';
  final int? start;
  @override
  TextStyle textStyle;
  final SPAN_BUILDER_TYPE spanBuilderType;
  BuildContext context;

  AssetText(
      {this.start,
      required this.textStyle,
      required this.context,
      this.spanBuilderType = SPAN_BUILDER_TYPE.TEXT})
      : super(
          startKey,
          endKey,
          textStyle,
        );

  @override
  InlineSpan finishText() {
    final String originalText = this.originalText();
    final List array = originalText.split(r'}>');
    final String data = array[0].substring(3, array[0].length) + '}';
    final String displayText =
        array[1].substring(0, array[1].length - endKey.length);
    final json = jsonDecode(data);
    final RichTextInfo info =
        RichTextInfo(json: json, preTextStyle: textStyle, context: context);
    return SpecialTextSpan(
        text: displayText,
        actualText: originalText,
        start: start!,
        style: info.textStyle,
        recognizer: (TapGestureRecognizer()
          ..onTap = () {
            if (spanBuilderType == SPAN_BUILDER_TYPE.TEXT) {
              info.onTap();
            }
          }));
  }

  originalText() {
    final String str = toString();
    return str;
  }
}

class CashTagText extends SpecialText {
  static const String startKey = r'$';
  static const String endKey = ' ';
  final int? start;
  @override
  TextStyle textStyle;
  final SPAN_BUILDER_TYPE spanBuilderType;
  BuildContext context;

  CashTagText(
      {this.start,
      required this.textStyle,
      required this.context,
      this.spanBuilderType = SPAN_BUILDER_TYPE.TEXT})
      : super(
          startKey,
          endKey,
          textStyle,
        );

  @override
  InlineSpan finishText() {
    final String text = toString();
    return SpecialTextSpan(
      deleteAll: false,
      text: text,
      actualText: text,
      start: start!,
      style: textStyle,
    );
  }
}

class HttpText extends SpecialText {
  static const String startKey = 'http';
  static const String endKey = ' ';
  final int? start;
  @override
  TextStyle textStyle;
  final SPAN_BUILDER_TYPE spanBuilderType;
  BuildContext context;

  HttpText(
      {this.start,
      required this.textStyle,
      required this.context,
      this.spanBuilderType = SPAN_BUILDER_TYPE.TEXT})
      : super(
          startKey,
          endKey,
          textStyle,
        );

  @override
  InlineSpan finishText() {
    final String text = toString();
    const TextStyle textStyle =
        // TextStyle(color: Colors.blue, decoration: TextDecoration.underline);
        TextStyle(color: Colors.blue);
    return SpecialTextSpan(
        text: text,
        actualText: text,
        start: start!,
        style: textStyle,
        deleteAll: false,
        recognizer: (TapGestureRecognizer()
          ..onTap = () async {
            if (spanBuilderType == SPAN_BUILDER_TYPE.TEXT) {
              final url = text.trim();
              UrlUtils.open(url);
            }
          }));
  }
}

class RichTextInfo {
  Map<String, dynamic>? json;
  TextStyle preTextStyle;
  BuildContext context;

  RichTextInfo(
      {required this.json, required this.preTextStyle, required this.context});

  TextStyle get textStyle {
    Color? color;
    FontWeight? fontWeight;
    double? fontSize;
    if (json!['type'] == 'asset') {
      color = context.theme.colorScheme.secondary;
      fontWeight = FontWeight.bold;
    } else if (json!['type'] == 'percent') {
      fontWeight = FontWeight.w500;
      final double value = json!['value'];
      fontSize = 10;
      if (value < 0) {
        color = IrisColor.negativeChange;
      } else {
        color = IrisColor.positiveChange;
      }
    } else if (json!['type'] == 'user') {
      fontWeight = FontWeight.bold;
      color = Colors.blue;
    }

    return TextStyle(fontWeight: fontWeight, color: color, fontSize: fontSize);
  }

  onTap() {
    if (json!['type'] == 'asset') {
      final int? assetKey = json!['assetKey'];
      if (assetKey != null) {
        // AssetViewBottomSheet.open(assetKey: assetKey);
      }
    }
  }
}

class RichTextSpanBuilder extends SpecialTextSpanBuilder {
  /// whether show background for @somebody
  final bool showAtBackground;
  final SPAN_BUILDER_TYPE spanBuilderType;
  BuildContext context;

  late String textData;

  RichTextSpanBuilder({
    this.showAtBackground = false,
    this.spanBuilderType = SPAN_BUILDER_TYPE.TEXT,
    required this.context,
  });

  @override
  TextSpan build(String data, {TextStyle? textStyle, onTap}) {
    if (spanBuilderType == SPAN_BUILDER_TYPE.TEXT_FIELD) {
      textData = data;
    }

    final textSpan = super.build(data, textStyle: textStyle, onTap: onTap);
    return textSpan;
  }

  @override
  SpecialText? createSpecialText(String flag,
      {TextStyle? textStyle,
      SpecialTextGestureTapCallback? onTap,
      int? index}) {
    if (flag == '') return null;
    if (isStart(flag, AssetText.startKey)) {
      return AssetText(
        textStyle: textStyle!,
        context: context,
        spanBuilderType: spanBuilderType,
        start: index! - (AssetText.startKey.length - 1),
      );
    } else if (isStart(flag, HttpText.startKey)) {
      return HttpText(
          context: context,
          spanBuilderType: spanBuilderType,
          textStyle: textStyle!,
          start: index! - (HttpText.startKey.length - 1));
    }
    return null;
  }

  getValueAfterFlag(String flagValue) {
    final List<String> list = textData.split(flagValue);
    final String value = list[list.length - 1];
    return value;
  }
}

enum SPAN_BUILDER_TYPE { TEXT_FIELD, TEXT }
