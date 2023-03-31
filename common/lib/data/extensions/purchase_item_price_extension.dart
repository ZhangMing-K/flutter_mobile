import 'package:flutter/foundation.dart';

import '../../iris_common.dart';

extension PurchaseItemPriceExt on PurchaseItemPrice {
  String? get intervalString {
    return intervalCount?.toString();
  }

  String? get intervalUnitString {
    String? unitString = describeEnum(interval!);
    if (intervalCount != null) {
      if (intervalCount! > 1) {
        unitString = unitString + 's';
      }
    }
    return unitString.toLowerCase();
  }
}
