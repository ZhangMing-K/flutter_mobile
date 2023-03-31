import 'package:get/get.dart';
import 'package:graphql/client.dart';

abstract class IGraphqlProvider extends GetxService {
  @override
  void onInit() async {
    getClient();
    super.onInit();
  }

  Future<void> getClient();

  GraphQLClient gqlClient();

  GraphQLClient? setSubcriptionClient();

  SubscriptionOptions createSubscriptionOptions({
    required String document,
    required Map<String, dynamic> variables,
    List<String>? fragments,
    FetchPolicy? fetchPolicy = FetchPolicy.networkOnly,
  });

  QueryOptions createQueryOptions({
    required String document,
    Map<String, dynamic> variables = const <String, dynamic>{},
    List<String>? fragments,
    FetchPolicy? fetchPolicy = FetchPolicy.networkOnly,
  });

  MutationOptions createMutationOptions({
    required String document,
    Map<String, dynamic>? variables,
    List<String>? fragments,
    FetchPolicy? fetchPolicy = FetchPolicy.networkOnly,
    Function? onError,
    bool errorLogging = false,
  });

  Future<QueryResult?> queryWithOptions(QueryOptions queryOptions);

  Stream<QueryResult>? subscribeWithOptions(SubscriptionOptions options);

  Future<QueryResult> mutate(String document);

  Future<QueryResult> mutateWithOptions(MutationOptions options);
}
