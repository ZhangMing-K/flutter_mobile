import 'package:iris_common/iris_common.dart';

extension PurchaseItemExt on PurchaseItem {
  List<PurchaseItemPrice> paymentPlans() {
    final List<PurchaseItemPrice> plans = [];
    if (dayPurchaseItemPrice != null) {
      plans.add(dayPurchaseItemPrice!);
    }

    if (purchaseItemPrice != null) {
      plans.add(purchaseItemPrice!);
    }

    if (threeMonthPurchaseItemPrice != null) {
      plans.add(threeMonthPurchaseItemPrice!);
    }

    if (yearPurchaseItemPrice != null) {
      plans.add(yearPurchaseItemPrice!);
    }

    return plans;
  }
}
