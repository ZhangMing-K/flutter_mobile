import 'package:graphql/client.dart';

import '../../../iris_common.dart';

abstract class IPurchaseItemRepository {
  Future<void> loadPurchaseitems({
    int limit = 10,
    int? offset,
    QueryType queryType = QueryType.loadCache,
    required Function(dynamic data) callback,
    required Function(OperationException error) onError,
  });
  Future<PurchaseItemCheckoutResponse?> purchaseItemCheckout({
    required List<int?> purchaseItemPriceKeys,
    bool? autoRenew,
    required Function(dynamic error) onError,
  });
}
