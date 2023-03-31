import 'package:flutter/services.dart';

class IrisCodeInputFormatter extends TextInputFormatter {
  IrisCodeInputFormatter();

  String apply(String oldVal, String newVal) {
    // the format is xxx-xxx, and only 6 characters
    String result = newVal.length > 7 ? newVal.substring(0, 7) : newVal;
    if (oldVal.length == 2 && newVal.length == 3) {
      result += '-';
    }
    if (oldVal.length == 4 && newVal.length == 3) {
      final lastCharacter = oldVal.substring(3);
      if (lastCharacter == '-') {
        result = newVal.substring(0, newVal.length - 1);
      }
    }

    return result;
  }

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final val = apply(oldValue.text, newValue.text);

    return TextEditingValue(
      selection: TextSelection.collapsed(offset: val.length),
      text: val,
    );
  }
}
