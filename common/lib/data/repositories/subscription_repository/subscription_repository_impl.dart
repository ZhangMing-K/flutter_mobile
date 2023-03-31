import 'package:flutter/foundation.dart';
import 'package:graphql/client.dart';

import '../../../iris_common.dart';

class SubscriptionRepository extends ISubscriptionRepository {
  final IGraphqlProvider remoteProvider;
  final BaseRepository repository;
  SubscriptionRepository({
    required this.remoteProvider,
    required this.repository,
  });

  @override
  Future<UserSubscription?> subscriptionUpdate({
    required int subscriptionKey,
    bool? autoRenew,
    required Function(dynamic error) onError,
  }) async {
    const document = '''
    mutation subscriptionUpdate(\$input:SubscriptionUpdateInput) {
        subscriptionUpdate(input:\$input) {
          subscription {
            endAt
            autoRenew
            subscriptionKey
            status
            latestPaymentTransaction {
              status
              paymentSecret
            }
          }
        }
      }
    ''';

    final Map<String, dynamic> input = {
      'subscriptionKey': subscriptionKey,
      'autoRenew': autoRenew
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
        final data = UserSubscription.fromJson(
            res.data?['subscriptionUpdate']['subscription'] ?? {});
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
