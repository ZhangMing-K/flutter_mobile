import 'package:flutter/foundation.dart';
import 'package:graphql/client.dart';

import '../../../iris_common.dart';

class PaymentMethodRepository extends IPaymentMethodRepository {
  final IGraphqlProvider remoteProvider;
  final BaseRepository repository;
  PaymentMethodRepository({
    required this.remoteProvider,
    required this.repository,
  });

  @override
  Future<PaymentMethodSetupResponse?> paymentMethodSetup({
    required int userKey,
    required Function(dynamic error) onError,
  }) async {
    const document = '''
    mutation paymentMethodSetup(\$input:PaymentMethodSetupInput) {
        paymentMethodSetup(input:\$input) {
          clientSecret
          user {
            userKey
            customerRemoteId
            goldConnection {
              isGoldMember
              autoRenew
              interval
              userPayingPrice
              intervalCount
              subscription {
                endAt
                subscriptionKey
                status
                latestPaymentTransaction {
                  status
                  paymentSecret
                }
              }
            }
          }
        }
      }
    ''';

    final Map<String, dynamic> input = {
      'userKey': userKey,
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
        final data = PaymentMethodSetupResponse.fromJson(
            res.data?['paymentMethodSetup'] ?? {});
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

  @override
  Future<SubscriptionSetPaymentMethodToUserDefaultResponse?>
      setPaymentMethodToUserDefault({
    required int userKey,
    required int subscriptionKey,
    required Function(dynamic error) onError,
  }) async {
    const document = '''
mutation subscriptionSetPaymentMethodToUserDefault(\$input: SubscriptionSetPaymentMethodToUserDefaultInput){
  subscriptionSetPaymentMethodToUserDefault(input: \$input) {
    subscription {
      paymentMethodKey
      paymentMethod {
        previewText
        paymentMethodKey
      }
      subscriptionKey
    }
  }
}
    ''';

    final Map<String, dynamic> input = {
      'subscriptionKey': subscriptionKey,
      'userKey': userKey
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
        final data = SubscriptionSetPaymentMethodToUserDefaultResponse.fromJson(
            res.data?['subscriptionSetPaymentMethodToUserDefault'] ?? {});
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
