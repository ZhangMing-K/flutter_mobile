import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:iris_common/iris_common.dart';

import 'easy_rich_text_pattern.dart';

class EasyRichText extends StatelessWidget {
  ///Iscut or original Text
  final String? text;

  ///The orginal text
  final String? originalText;

  ///The list of target strings and their styles.
  final List<EasyRichTextPattern>? patternList;

  ///The default text style.
  final TextStyle? defaultStyle;

  /// How the text should be aligned horizontally.
  final TextAlign textAlign;

  /// The directionality of the text.
  ///
  /// This decides how [textAlign] values like [TextAlign.start] and
  /// [TextAlign.end] are interpreted.
  ///
  /// This is also used to disambiguate how to render bidirectional text. For
  /// example, if the [text] is an English phrase followed by a Hebrew phrase,
  /// in a [TextDirection.ltr] context the English phrase will be on the left
  /// and the Hebrew phrase to its right, while in a [TextDirection.rtl]
  /// context, the English phrase will be on the right and the Hebrew phrase on
  /// its left.
  ///
  /// Defaults to the ambient [Directionality], if any. If there is no ambient
  /// [Directionality], then this must not be null.
  final TextDirection? textDirection;

  /// Whether the text should break at soft line breaks.
  ///
  /// If false, the glyphs in the text will be positioned as if there was unlimited horizontal space.
  final bool softWrap;

  /// How visual overflow should be handled.
  final TextOverflow overflow;

  /// The number of font pixels for each logical pixel.
  ///
  /// For example, if the text scale factor is 1.5, text will be 50% larger than
  /// the specified font size.
  final double textScaleFactor;

  /// An optional maximum number of lines for the text to span, wrapping if necessary.
  /// If the text exceeds the given number of lines, it will be truncated according
  /// to [overflow].
  ///
  /// If this is 1, text will not wrap. Otherwise, text will be wrapped at the
  /// edge of the box.
  final int? maxLines;

  /// Used to select a font when the same Unicode character can
  /// be rendered differently, depending on the locale.
  ///
  /// It's rarely necessary to set this property. By default its value
  /// is inherited from the enclosing app with `Localizations.localeOf(context)`.
  ///
  /// See [RenderParagraph.locale] for more information.
  final Locale? locale;

  /// {@macro flutter.painting.textPainter.strutStyle}
  final StrutStyle? strutStyle;

  /// {@macro flutter.widgets.text.DefaultTextStyle.textWidthBasis}
  final TextWidthBasis textWidthBasis;

  ///case sensitive match
  ///default true
  final bool caseSensitive;

  ///selectable text, default false
  final bool selectable;

  const EasyRichText(
    this.text,
    this.originalText, {
    Key? key,
    this.patternList,
    this.defaultStyle,
    this.textAlign = TextAlign.start,
    this.textDirection,
    this.softWrap = true,
    this.overflow = TextOverflow.clip,
    this.textScaleFactor = 1.0,
    this.maxLines,
    this.locale,
    this.strutStyle,
    this.textWidthBasis = TextWidthBasis.parent,
    this.caseSensitive = true,
    this.selectable = false,
  }) : super(key: key);

  _launchURL(String str) async {
    final String url = str;
    UrlUtils.open(url);
  }

  List<String> specialCharacters() {
    return '\\~[]{}#%^*+=_|<>£€•.,!’()?-\$'.split('');
  }

  TapGestureRecognizer? tapGestureRecognizerForUrls(
      String? str, String urlType) {
    TapGestureRecognizer? tapGestureRecognizer;
    switch (urlType) {
      case 'web':
        if (str!.substring(0, 4) != 'http') {
          str = 'https://$str';
        }
        tapGestureRecognizer = TapGestureRecognizer()
          ..onTap = () {
            _launchURL(str!);
          };
        break;
      case 'email':
        tapGestureRecognizer = TapGestureRecognizer()
          ..onTap = () {
            _launchURL('mailto:$str');
          };
        break;
      case 'tel':
        tapGestureRecognizer = TapGestureRecognizer()
          ..onTap = () {
            _launchURL('tel:$str');
          };
        break;
      default:
    }
    return tapGestureRecognizer;
  }

  List<String> processStrList(
      List<EasyRichTextPattern> patternList, String temText) {
    final List<String> strList = [];
    final List<List<int>> positions = [];

    patternList.asMap().forEach((index, pattern) {
      String thisRegExPattern;
      final String targetString = pattern.targetString;
      final String stringBeforeTarget = pattern.stringBeforeTarget;
      final String stringAfterTarget = pattern.stringAfterTarget;

      final bool matchLeftWordBoundary = pattern.matchLeftWordBoundary;
      final bool matchRightWordBoundary = pattern.matchRightWordBoundary;
      bool matchWordBoundaries = pattern.matchWordBoundaries;
      //if hasSpecialCharacters then unicode is
      final bool unicode = !pattern.hasSpecialCharacters;

      String wordBoundaryStringBeforeTarget1 = '\\b';
      String wordBoundaryStringBeforeTarget2 = '\\s';
      String wordBoundaryStringAfterTarget1 = '\\s';
      String wordBoundaryStringAfterTarget2 = '\\b';

      String leftBoundary = '(?<!\\w)';
      String rightBoundary = '(?!\\w)';

      ///if any of matchWordBoundaries or matchLeftWordBoundary is false
      ///set leftBoundary = ""
      if (!matchWordBoundaries || !matchLeftWordBoundary) {
        leftBoundary = '';
        wordBoundaryStringBeforeTarget1 = '';
        wordBoundaryStringAfterTarget1 = '';
      }

      if (!matchWordBoundaries || !matchRightWordBoundary) {
        rightBoundary = '';
        wordBoundaryStringBeforeTarget2 = '';
        wordBoundaryStringAfterTarget2 = '';
      }

      final bool isHan = RegExp(r'[\u4e00-\u9fa5]+',
              caseSensitive: caseSensitive, unicode: unicode)
          .hasMatch(targetString);

      final bool isArabic = RegExp(r'[\u0621-\u064A]+',
              caseSensitive: caseSensitive, unicode: unicode)
          .hasMatch(targetString);

      /// if target string is Han or Arabic character
      /// set matchWordBoundaries = false
      /// set wordBoundaryStringBeforeTarget = ""
      if (isHan || isArabic) {
        matchWordBoundaries = false;
        leftBoundary = '';
        rightBoundary = '';
        wordBoundaryStringBeforeTarget1 = '';
        wordBoundaryStringBeforeTarget2 = '';
        wordBoundaryStringAfterTarget1 = '';
        wordBoundaryStringAfterTarget2 = '';
      }

      String stringBeforeTargetRegex = '';
      if (stringBeforeTarget != '') {
        stringBeforeTargetRegex =
            '(?<=$wordBoundaryStringBeforeTarget1$stringBeforeTarget$wordBoundaryStringBeforeTarget2)';
      }
      String stringAfterTargetRegex = '';
      if (stringAfterTarget != '') {
        stringAfterTargetRegex =
            '(?=$wordBoundaryStringAfterTarget1$stringAfterTarget$wordBoundaryStringAfterTarget2)';
      }

      //modify targetString by matchWordBoundaries and wordBoundaryStringBeforeTarget settings
      thisRegExPattern =
          '($stringBeforeTargetRegex$leftBoundary$targetString$rightBoundary$stringAfterTargetRegex)';
      final RegExp exp = RegExp(thisRegExPattern,
          caseSensitive: caseSensitive, unicode: unicode);
      final allMatches = exp.allMatches(temText);

      //check matchOption ['all','first','last', 0, 1, 2, 3, 10]

      final int matchesLength = allMatches.length;
      List<int> matchIndexList = [];
      final matchOption = pattern.matchOption;
      if (matchOption is String) {
        switch (matchOption) {
          case 'all':
            matchIndexList = List<int>.generate(matchesLength, (i) => i);
            break;
          case 'first':
            matchIndexList = [0];
            break;
          case 'last':
            matchIndexList = [matchesLength - 1];
            break;
          default:
            matchIndexList = List<int>.generate(matchesLength, (i) => i);
        }
      } else if (matchOption is List<dynamic>) {
        for (var option in matchOption) {
          switch (option) {
            case 'all':
              matchIndexList = List<int>.generate(matchesLength, (i) => i);
              break;
            case 'first':
              matchIndexList.add(0);
              break;
            case 'last':
              matchIndexList.add(matchesLength - 1);
              break;
            default:
              if (option is int) matchIndexList.add(option);
          }
        }
      }

      ///eg. positions = [[7,11],[26,30],]
      allMatches.toList().asMap().forEach((index, match) {
        if (matchIndexList.contains(index)) {
          positions.add([match.start, match.end]);
        }
      });
    });
    positions.sort((a, b) => a[0].compareTo(b[0]));
    //remove invalid positions
    final List<List<int>> postionsToRemove = [];
    for (var i = 1; i < positions.length; i++) {
      if (positions[i][0] <= positions[i - 1][1] - 1) {
        postionsToRemove.add(positions[i]);
      }
    }
    for (var position in postionsToRemove) {
      positions.remove(position);
    }

    //convert positions to 1d list
    final List<int> splitPositions = [0];
    for (var position in positions) {
      splitPositions.add(position[0]);
      splitPositions.add(position[1]);
    }
    splitPositions.add(temText.length);

    splitPositions.asMap().forEach((index, splitPosition) {
      if (index != 0) {
        if (splitPositions[index - 1] <= splitPosition) {
          //note from Brian Schardt this needs to be checked out

          strList
              .add(temText.substring(splitPositions[index - 1], splitPosition));
        } else {
          // debugPrint('error with split positions');
        }
      }
    });

    return strList;
  }

  String replaceSpecialCharacters(str) {
    String tempStr = str;
    //\[]()^*+?.$-{}|!
    specialCharacters().forEach((chr) {
      tempStr = tempStr.replaceAll(chr, '\\$chr');
    });

    return tempStr;
  }

  @override
  Widget build(BuildContext context) {
    final String? temText = text;
    final String? temOriginalText = originalText;
    final List<EasyRichTextPattern>? tempPatternList = patternList;
    List<String?> strList = [];
    List<String?> strOriginalList = [];
    bool unicode = true;

    if (tempPatternList == null) {
      strList = [temText];
      strOriginalList = [temOriginalText];
    } else {
      tempPatternList.asMap().forEach((index, pattern) {
        if (pattern.hasSpecialCharacters) {
          unicode = false;
          final String newTargetString =
              replaceSpecialCharacters(pattern.targetString);
          final EasyRichTextPattern tempPattern =
              pattern.copyWith(targetString: newTargetString);
          tempPatternList[index] = tempPattern;
        }
      });
      strList = processStrList(tempPatternList, temText!);
      strOriginalList = processStrList(tempPatternList, temOriginalText ?? '');
    }

    final List<InlineSpan> textSpanList = [];
    int _index = 0;
    for (var str in strList) {
      InlineSpan inlineSpan;
      int targetIndex = -1;
      RegExpMatch? match;

      if (tempPatternList != null) {
        tempPatternList.asMap().forEach((index, pattern) {
          final String targetString = pattern.targetString;

          //\$, match end
          final RegExp targetStringExp = RegExp(
            '^$targetString\$',
            caseSensitive: caseSensitive,
            unicode: unicode,
          );

          match = targetStringExp.firstMatch(str!);

          if (match is RegExpMatch) {
            targetIndex = index;
          }
        });
      }

      ///If str is targetString
      if (targetIndex > -1) {
        //if str is url
        final pattern = tempPatternList![targetIndex];
        final urlType = pattern.urlType;
        if (null != pattern.matchBuilder && match is RegExpMatch) {
          inlineSpan = pattern.matchBuilder!(context, match);
        } else if (urlType != null) {
          if (strOriginalList.length > _index) {
            final String? clickableStr = strOriginalList[
                _index]; // if it's web links need to open the original url
            //change the target string to superscript
            inlineSpan = TextSpan(
              text: str,
              recognizer: tapGestureRecognizerForUrls(clickableStr, urlType),
              style: pattern.style ?? DefaultTextStyle.of(context).style,
            );
          } else {
            inlineSpan = TextSpan(
              text: str,
              recognizer: pattern.recognizer,
              style: pattern.style ?? DefaultTextStyle.of(context).style,
            );
          }
        } else {
          inlineSpan = TextSpan(
            text: str,
            recognizer: pattern.recognizer,
            style: pattern.style ?? DefaultTextStyle.of(context).style,
          );
        }
      } else {
        inlineSpan = TextSpan(
          text: str,
        );
      }
      textSpanList.add(inlineSpan);
      _index++;
    }
    if (selectable) {
      return SelectableText.rich(
        TextSpan(
            style: defaultStyle ?? DefaultTextStyle.of(context).style,
            children: textSpanList),
        maxLines: maxLines,
        strutStyle: strutStyle,
        textAlign: textAlign,
        textDirection: textDirection,
        textScaleFactor: textScaleFactor,
        textWidthBasis: textWidthBasis,
      );
    } else {
      return Text.rich(
        TextSpan(
            style: defaultStyle ?? DefaultTextStyle.of(context).style,
            children: textSpanList),
        maxLines: maxLines,
        strutStyle: strutStyle,
        textAlign: textAlign,
        textDirection: textDirection,
        textScaleFactor: textScaleFactor,
        textWidthBasis: textWidthBasis,
      );
    }
  }
}
