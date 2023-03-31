import 'package:flutter/foundation.dart';
import 'package:graphql/client.dart';

import '../../../iris_common.dart';

class PurcahseItemRepository extends IPurchaseItemRepository {
  final IGraphqlProvider remoteProvider;
  final BaseRepository repository;
  PurcahseItemRepository({
    required this.remoteProvider,
    required this.repository,
  });

  @override
  Future<void> loadPurchaseitems({
    int limit = 10,
    int? offset = 10,
    QueryType queryType = QueryType.loadCache,
    required Function(dynamic data) callback,
    required Function(OperationException error) onError,
  }) {
    var document = '''
      query purchaseItemsGet(\$input: PurchaseItemsGetInput) 
    ''';
    document += '''
    {
        purchaseItemsGet(input: \$input) {
          purchaseItems{
            purchaseItemKey
            description
            name
            authUserSubscription {
              userKey
            }
            purchaseItemPrice {
              purchaseItemPriceKey
              interval
              intervalCount
              price
              purchaseItemKey
            }
            dayPurchaseItemPrice {
              purchaseItemPriceKey
              interval
              intervalCount
              price
              purchaseItemKey
            }
            threeMonthPurchaseItemPrice {
              purchaseItemPriceKey
              interval
              intervalCount
              price
              purchaseItemKey
            }
            yearPurchaseItemPrice {
              purchaseItemPriceKey
              interval
              intervalCount
              price
              purchaseItemKey
            }
          }
        }
      }
    ''';

    final input = {'limit': limit, 'offset': offset};
    final variables = {'input': input};

    return repository.query(
      type: CacheType.searchStocks,
      id: 'subscriptions',
      document: document,
      variables: variables,
      queryType: queryType,
      callback: (data) {
        if (data == null) {
          callback(<PurchaseItem>[]);
        }

        final assetListData = data['purchaseItemsGet']['purchaseItems'];
        final List<PurchaseItem> assetList = List<PurchaseItem>.from(
            assetListData.map((i) => PurchaseItem.fromJson(i)));
        callback(assetList);
      },
      onError: onError,
    );
  }

  @override
  Future<PurchaseItemCheckoutResponse?> purchaseItemCheckout({
    required List<int?> purchaseItemPriceKeys,
    bool? autoRenew,
    required Function(dynamic error) onError,
  }) async {
    const document = '''
    mutation purchaseItemCheckout(\$input:PurchaseItemCheckoutInput) {
        purchaseItemCheckout(input:\$input) {
          purchaseItems {
            purchaseItemKey
          }
          subscription {
            endAt
            latestPaymentTransaction {
              paymentSecret
            }
            startAt
            autoRenew
            status
            userKey
          }
          user {
            customerRemoteId
          }
        }
      }
    ''';

    final Map<String, dynamic> input = {
      'purchaseItemPriceKeys': [...purchaseItemPriceKeys],
      'autoRenew': true
    };
    final mutationOptions = remoteProvider.createMutationOptions(
        document: document,
        variables: {'input': input},
        fetchPolicy: FetchPolicy.noCache);
    try {
      final res = await remoteProvider.mutateWithOptions(mutationOptions);

      if (res.exception != null) {
        if (res.exception!.graphqlErrors.isNotEmpty) {
          onError(res.exception?.graphqlErrors.first.message);
          return null;
        }
      }
      if (res.data != null) {
        final data = PurchaseItemCheckoutResponse.fromJson(
            res.data?['purchaseItemCheckout'] ?? {});
        return data;
      } else {
        onError('The server did not send a response.');
        return null;
      }
    } catch (e) {
      debugPrint(e.toString());
      onError(e);
      return null;
    }
  }
}
