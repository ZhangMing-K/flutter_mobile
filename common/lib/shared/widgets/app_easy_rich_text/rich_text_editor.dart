import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import 'easy_rich_text.dart';
import 'easy_rich_text_pattern.dart';
import 'patterns.dart';

enum RICH_TEXT_STYLE { NO_COLOR, LIGHT_COLOR, NORMAL, GREY }

class RichTextEditor extends StatefulWidget {
  final String? text;

  final String? originalText;
  final TextStyle? style;
  final int? maxLines;
  final Function? showMore;
  final bool selectable;
  final RICH_TEXT_STYLE richTextStyleType;
  final bool disableOnTap;
  const RichTextEditor({
    Key? key,
    this.text,
    this.originalText,
    this.style,
    this.maxLines,
    this.showMore,
    this.selectable = false,
    this.richTextStyleType = RICH_TEXT_STYLE.NORMAL,
    this.disableOnTap =
        false, //this is here for the inbox where we show rich text but we dont want the users tap interactions to route any where else
  }) : super(key: key);

  @override
  _RichTextEditorState createState() => _RichTextEditorState();
}

class RichTextStyle {
  Color negativeChangeColor;
  Color positiveChangeColor;
  FontWeight percentFontWeight;
  Color mentionColor;
  Color cashTagColor;
  Color? linkColor;
  RichTextStyle(
      {required this.negativeChangeColor,
      required this.positiveChangeColor,
      required this.mentionColor,
      this.linkColor,
      this.percentFontWeight = FontWeight.w500,
      this.cashTagColor = Colors.white});
}

class _RichTextEditorState extends State<RichTextEditor> {
  bool isExpanded = false;

  RichTextStyle get richTextStyle {
    switch (widget.richTextStyleType) {
      case RICH_TEXT_STYLE.NORMAL:
        return RichTextStyle(
            negativeChangeColor: IrisColor.negativeChange,
            positiveChangeColor: IrisColor.positiveChange,
            mentionColor: Colors.blue);
      case RICH_TEXT_STYLE.LIGHT_COLOR:
        return RichTextStyle(
            negativeChangeColor: const Color.fromRGBO(255, 172, 172, 1),
            positiveChangeColor: const Color.fromRGBO(161, 250, 181, 1),
            mentionColor: Colors.white,
            linkColor: Colors.white,
            percentFontWeight: FontWeight.bold);
      case RICH_TEXT_STYLE.NO_COLOR:
        return RichTextStyle(
          negativeChangeColor: Colors.white,
          positiveChangeColor: Colors.white,
          mentionColor: Colors.white,
        );
      case RICH_TEXT_STYLE.GREY:
        return RichTextStyle(
            negativeChangeColor: const Color.fromRGBO(255, 172, 172, 1),
            positiveChangeColor: const Color.fromRGBO(161, 250, 181, 1),
            mentionColor: Colors.grey.shade500,
            cashTagColor: Colors.grey.shade500,
            linkColor: Colors.grey.shade500);
      default:
        return RichTextStyle(
            negativeChangeColor: IrisColor.negativeChange,
            positiveChangeColor: IrisColor.positiveChange,
            mentionColor: Colors.blue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return EasyRichText(
      isExpanded ? widget.originalText : widget.text ?? '',
      widget.originalText,
      defaultStyle: widget.style,
      maxLines: widget.maxLines,
      softWrap: false,
      overflow: TextOverflow.ellipsis,
      patternList: [
        EasyRichTextPattern(
          targetString: EasyRegexPattern.webPattern,
          matchWordBoundaries: false,
          urlType: 'web',
          style: TextStyle(
            decoration: TextDecoration.underline,
            color:
                richTextStyle.linkColor ?? context.theme.colorScheme.secondary,
          ),
        ),
        EasyRichTextPattern(
            targetString: EasyRegexPattern.emailPattern,
            urlType: 'email',
            style: const TextStyle(decoration: TextDecoration.underline)),
        EasyRichTextPattern(
            targetString: EasyRegexPattern.telPattern,
            urlType: 'tel',
            style: const TextStyle(decoration: TextDecoration.underline)),
        EasyRichTextPattern(
          targetString: EasyRegexPattern.richTextPattern,
          matchWordBoundaries: false,
          style: const TextStyle(color: Colors.green),
          matchBuilder: (context, match) {
            final str = match![0]!;
            const String endKey = r'</C>';
            final originalText = str.substring(0, str.length - endKey.length) +
                endKey.substring(endKey.length - 1, endKey.length);
            final List array = originalText.split(r'}>');
            final String data = array[0].substring(3, array[0].length) + '}';
            final json = jsonDecode(data);
            Color? color;
            FontWeight? fontWeight;
            double? fontSize;
            String? valueText;

            if (json['type'] == 'asset') {
              color =
                  widget.style!.color ?? context.theme.colorScheme.secondary;
              if (widget.richTextStyleType == RICH_TEXT_STYLE.GREY) {
                color = Colors.grey.shade500;
              }
              fontWeight = FontWeight.bold;
              valueText = json['value'];
            } else if (json['type'] == 'percent') {
              fontWeight = richTextStyle.percentFontWeight;

              final double value = json['value'];
              fontSize = 10;
              valueText = value.formatPercentage();
              if (value < 0) {
                color = richTextStyle.negativeChangeColor;
              } else {
                color = richTextStyle.positiveChangeColor;
                valueText = '+$valueText';
              }
            } else if (json['type'] == 'showMore') {
              color = Colors.grey;
              fontSize = widget.style!.fontSize! + 1;
              valueText = ' see more';
            } else if (json['type'] == 'user') {
              valueText = array[1].substring(0, array[1].length - 1);
              color = richTextStyle.mentionColor;
              fontWeight = FontWeight.bold;
            }

            final TextStyle textStyle = TextStyle(
                fontWeight: fontWeight, color: color, fontSize: fontSize);
            return TextSpan(
                text: valueText,
                style: textStyle,
                recognizer: (widget.disableOnTap == false)
                    ? (TapGestureRecognizer()
                      ..onTap = () {
                        if (json['type'] == 'asset') {
                          final int? assetKey = json['assetKey'];
                          if (assetKey != null &&
                              widget.disableOnTap == false) {
                            // Get.toNamed(Paths.Asset,
                            //     parameters: {'assetKey': assetKey.toString()});
                          }
                        } else if (json['type'] == 'showMore') {
                          // showMore!();
                          setExpanded();
                          if (widget.showMore != null) {
                            widget.showMore!();
                          }
                        } else if (json['type'] == 'user' &&
                            widget.disableOnTap == false) {
                          Get.toNamed(
                            Paths.Feed + Paths.Home + Paths.Profile,
                            parameters: {
                              'profileUserKey': json['userKey'].toString()
                            },
                            id: 1,
                          );
                        }
                      })
                    : null);
          },
        ),
      ],
      selectable: widget.selectable,
    );
  }

  @override
  void initState() {
    super.initState();
  }

  void setExpanded() {
    setState(() {
      isExpanded = true;
    });
  }
}
