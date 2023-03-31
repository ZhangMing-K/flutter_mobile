import 'package:intl/intl.dart';

extension DoubleExtension on double? {
  /// returns a String value of the given double formatted to the closest whole number.
  ///
  /// If 'roundedNumber' is greater than the absolute value of this double, the percentage will include one decimal place.
  /// If `nullDisplayNA` is true, and this is null, `N/A` will be returned
  ///
  /// EXAMPLES:
  /// 0.12.formatPercentage() == '12%'
  /// 0.125.formatPercentage() == '13%'
  /// 0.125.formatPercentage(roundedNumber: 0.3) == '12.5%'   NOTE: any value greater than 0.125 passed as roundedNumber will yeild the same result
  ///
  String formatPercentage(
      {double roundedNumber = 0.03, bool nullDisplayNA = false}) {
    if (this == null) {
      if (nullDisplayNA) {
        return 'N/A';
      } else {
        return '0%';
      }
    }
    if (this! < roundedNumber && this! > -roundedNumber) {
      return NumberFormat.decimalPercentPattern(decimalDigits: 1).format(this);
    }
    return NumberFormat.decimalPercentPattern(decimalDigits: 0).format(this);
  }

  String formatPercentageSensitive(
      {double roundedNumber = 0.03, double dontShowLessthan = 0.5}) {
    if (this == null) {
      return 'N/A';
    }
    if (this! < dontShowLessthan) {
      return '<' +
          NumberFormat.decimalPercentPattern(decimalDigits: 0)
              .format(dontShowLessthan);
    }
    if (this! < roundedNumber && this! > -roundedNumber) {
      return NumberFormat.decimalPercentPattern(decimalDigits: 1).format(this);
    }
    return NumberFormat.decimalPercentPattern(decimalDigits: 0).format(this);
  }

  String formatAbsolutePercentage({double roundedNumber = 0.1}) {
    if (this == null) {
      return '0%';
    }
    final double absoluteValue = this!.abs();
    String? formattedString;

    if (absoluteValue < 0.01) {
      formattedString = NumberFormat.decimalPercentPattern(decimalDigits: 2)
          .format(absoluteValue);
    } else if (absoluteValue < roundedNumber) {
      formattedString = NumberFormat.decimalPercentPattern(decimalDigits: 1)
          .format(absoluteValue);
    } else {
      formattedString = NumberFormat.decimalPercentPattern(decimalDigits: 0)
          .format(absoluteValue);
    }

    final List<String?> array = formattedString.split('');
    int positionToPop = array.length - 2;

    if (array[positionToPop] == '0') array.removeAt(positionToPop);

    positionToPop = array.length - 2;
    if (array[positionToPop] == '.') array.removeAt(positionToPop);

    return array.join();
  }

  /// Returns a configurable String value of the double.
  ///
  /// if `noDecimalAfterInt` is less than this double, then all decimal points are removed
  ///
  /// `decimalDigits` determines the number of decimals to be included
  ///
  String formatNumber({int? noDecimalAfterInt, int? decimalDigits = 0}) {
    if (this == null) {
      return '0.00';
    }
    String number = NumberFormat.decimalPattern().format(this);
    if (noDecimalAfterInt != null && this! > noDecimalAfterInt) {
      final numbers = number.split('.');
      number = numbers[0];
    }

    return number;
  }

  String formatAssetPrice() {
    if (this == null) {
      return '.0';
    }
    String price = this!.abs().toStringAsFixed(2);
    if (this! < 1) {
      final numbers = price.split('.');
      price = '.' + numbers[1];
    }
    return price;
  }

  String formatCurrency() {
    if (this == null) {
      return r'$0.00';
    } else if (this! > 0 && this! < .01) {
      return NumberFormat.simpleCurrency(decimalDigits: 4).format(this);
    } else if (this! > 500) {
      return NumberFormat.simpleCurrency(decimalDigits: 0).format(this);
    } else {
      return NumberFormat.simpleCurrency(decimalDigits: 2).format(this);
    }
  }

  /// Returns A number format for compact representations, e.g. "1.2M" instead of "1,200,000".
  String formatCompact({String nullSign = '-'}) {
    if (this == null) {
      return nullSign;
    }
    return NumberFormat.compact().format(this ?? 0);
  }

  String formatDollar() {
    if (this == null) {
      return r'$';
    } else if (this! > 0 && this! < 1000) {
      return r'$';
    } else if (this! > 1000 && this! < 10000) {
      return r'$$';
    } else {
      return r'$$$';
    }
  }
}
