import 'package:get/get.dart';

import '../../iris_common.dart';

class CheckoutArgs {
  final RxList<PurchaseItem>? purchaseItems;
  const CheckoutArgs({
    required this.purchaseItems,
  });
}
