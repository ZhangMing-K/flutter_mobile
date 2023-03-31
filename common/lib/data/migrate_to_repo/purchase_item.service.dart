import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../iris_common.dart';

class PurcahseItemService extends GetxService {
  PurcahseItemService();
  IGraphqlProvider iGraphqlProvider = Get.find();

  Future<PurchaseItem?> purchaseItemCheckout(
      {required int purchaseItemPriceKey, bool? autoRenew}) async {
    const document = '''
    mutation purchaseItemCheckout(\$input:PurchaseItemCheckoutInput!) {
        purchaseItemCheckout(input:\$input) {
          purchaseItem {
            authUserSubscription {
              latestPaymentTransaction {
                paymentSecret
              }
            }
          }
        }
      }
    ''';

    final Map<String, dynamic> variables = {
      'input': {
        'purchaseItemPriceKey': purchaseItemPriceKey,
        'autoRenew': autoRenew,
      }
    };

    final mutationOptions = iGraphqlProvider.createMutationOptions(
        document: document, variables: variables);
    try {
      final res = await iGraphqlProvider.mutateWithOptions(mutationOptions);
      if (res.data!['purchaseItemCheckout']['purchaseItem'] == null) {
        return null;
      }
      return PurchaseItem.fromJson(
          res.data!['purchaseItemCheckout']['purchaseItem']);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
