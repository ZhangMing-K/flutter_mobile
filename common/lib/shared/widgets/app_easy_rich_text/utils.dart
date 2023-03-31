import 'dart:convert';

import 'patterns.dart';

class RichEditTextUtils {
  static String richTextPattern = EasyRegexPattern.richTextPattern;
  static String showMoreTag =
      '... <C {"type":"showMore","value":"see"}>SEE</C>';

  static needShowMore(text, maxLength) {
    var textLength = text?.length;
    final matchExp = RegExp(richTextPattern);
    if (text == null) return false;
    final matched = matchExp.allMatches(text);
    for (final match in matched) {
      final str = match[0]!;
      final matchLength = str.length;
      const String endKey = r'</C>';
      final originalText = str.substring(0, str.length - endKey.length) +
          endKey.substring(endKey.length - 1, endKey.length);
      final List array = originalText.split(r'}>');
      final String data = array[0].substring(3, array[0].length) + '}';
      final json = jsonDecode(data);
      String? valueText = '';
      if (json['type'] == 'asset') {
        valueText = json['value'];
      } else if (json['type'] == 'percent') {
        valueText = (json['value'] * 100).toStringAsFixed(2) + '%';
      }
      final diff = (valueText?.length ?? 0) - matchLength;
      textLength += diff;
    }
    if (textLength > maxLength) {
      return true;
    }
    return false;
  }

  static bool isLastWordUnicode(String text, int length) {
    final String lastWord = text.substring(length - 1, length);
    return lastWord.codeUnits[0] > 128;
  }

  static getCutText(text, maxLength) {
    int? _maxLength = maxLength;
    final textRunes = text?.runes;
    String? cutText = String.fromCharCodes(textRunes, 0,
        textRunes.length > maxLength ? maxLength : textRunes.length);
    final matchExp = RegExp(richTextPattern);
    final matched = matchExp.allMatches(text);
    if (matched.isEmpty) {
      return cutText;
    }

    int index = 0;
    for (final match in matched) {
      final strStart = match.start;
      final strEnd = match.end;
      final matchLength = strEnd - strStart;
      if (index == 0 && strStart > maxLength) {
        break;
      }
      if (strStart > _maxLength!) {
        break;
      }
      final str = match[0]!;
      const String endKey = r'</C>';
      final originalText = str.substring(0, str.length - endKey.length) +
          endKey.substring(endKey.length - 1, endKey.length);
      final List array = originalText.split(r'}>');
      final String data = array[0].substring(3, array[0].length) + '}';
      final json = jsonDecode(data);
      String? valueText = '';
      if (json['type'] == 'asset') {
        valueText = json['value'];
      } else if (json['type'] == 'percent') {
        valueText = (json['value'] * 100).toStringAsFixed(2) + '%';
      }
      final diff = matchLength - (valueText?.length ?? 0);
      _maxLength += diff;
      index++;
    }

    if (_maxLength! > text.length) {
      cutText = text;
      return cutText;
    }
    for (final match in matched) {
      final strStart = match.start;
      final strEnd = match.end;
      if (_maxLength! > strStart) {
        _maxLength =
            text.runes.length > _maxLength ? _maxLength : text.runes.length;
        if (isLastWordUnicode(text, _maxLength!)) {
          cutText = String.fromCharCodes(text.runes, 0, _maxLength);
        } else {
          cutText = text.substring(0, _maxLength);
        }
      }
      if (_maxLength >= strStart && _maxLength <= strEnd) {
        if (isLastWordUnicode(text, strEnd)) {
          cutText = String.fromCharCodes(text.runes, 0, strEnd);
        } else {
          cutText = text.substring(0, strEnd);
        }
        break;
      }
    }

    return cutText;
  }
}
