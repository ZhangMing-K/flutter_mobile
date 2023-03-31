import 'package:flutter/material.dart';
import 'package:iris_common/iris_common.dart';

extension QuoteExt on Quote {
  String? get changeDifferential {
    if (change == 0 || change == null) {
      return null;
    }

    final List<String>? array = change?.abs().toString().split('');

    if (array == null || array.isEmpty) {
      return null;
    }

    if (array[0] == '0') {
      array.removeAt(0);
    }

    return array.join();
  }

  String? get changePercentDifferential {
    if (changePercent == 0 || changePercent == null) {
      return null;
    }

    return changePercent!.formatAbsolutePercentage();
  }

  Color? get quoteColor {
    return Colors.white;

    //may want this logic later
    // if(change != null) {
    //   if(change! >= 0)
    //     return IrisColor.positiveChange;
    //   else
    //     return IrisColor.negativeChange;
    // } else if(changePercent != null) {
    //    if(changePercent! >= 0)
    //     return IrisColor.positiveChange;
    //   else
    //     return IrisColor.negativeChange;
    // }
    // else return IrisColor.backgroundColor;
  }
}
