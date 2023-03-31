import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql/client.dart';

class EventIGraphqlProvider extends GetxService {
  EventIGraphqlProvider({required this.graphqlUrl}) {
    authLink = AuthLink(
      getToken: () {
        return authToken;
      },
    );

    // GraphQLClient client;
    GraphQLClient gqlClient() {
      httpLink = HttpLink(
        graphqlUrl!,
      );
      link = authLink.concat(httpLink);
      return GraphQLClient(
        link: link,
        cache: GraphQLCache(),
      );
    }

    client = gqlClient(); // GraphQLClient(link: link, cache: InMemoryCache());

    notifierClient = ValueNotifier(client);
  }

  String? graphqlUrl;

  late HttpLink httpLink;
  late AuthLink authLink;
  late Link link;
  GraphQLClient? client;
  ValueNotifier<GraphQLClient?>? notifierClient;

  String? authToken = ''; // be sure to set and remove at login and logout.

  QueryOptions createQueryOptions({
    String? document,
    required Map<String, dynamic> variables,
    List<String>? fragments,
    FetchPolicy fetchPolicy = FetchPolicy.networkOnly,
  }) {
    if (fragments != null) {
      for (var fragment in fragments) {
        if (document != null) document = document + fragment;
      }
    }

    return QueryOptions(
      document: gql(document!),
      variables: variables,
      fetchPolicy: fetchPolicy,
      errorPolicy: ErrorPolicy.all,
    );
  }

  MutationOptions createMutationOptions({
    String? document,
    required Map<String, dynamic> variables,
    List<String>? fragments,
    FetchPolicy? fetchPolicy,
    Function? onError,
    bool errorLogging = false,
  }) {
    if (fragments != null) {
      for (var fragment in fragments) {
        if (document != null) document = document + fragment;
      }
    }

    fetchPolicy ??= FetchPolicy.networkOnly;
    return MutationOptions(
        document: gql(document!),
        variables: variables,
        fetchPolicy: fetchPolicy,
        errorPolicy: ErrorPolicy.all,
        onError: (_) {
          if (onError != null) {
            onError(_);
          }
          if (errorLogging) {
            debugPrint(_.toString());
          }
          // throw _!.graphqlErrors;
        });
  }

  Future<QueryResult?> queryWithOptions(QueryOptions queryOptions) async {
    try {
      final res = await client!.query(queryOptions);

      return res;
    } catch (err) {
      return null;
    }
  }

  Future<QueryResult> mutate(String document) {
    return client!.mutate(MutationOptions(
      document: gql(document),
    ));
  }

  Future<QueryResult> mutateWithOptions(MutationOptions options) {
    return client!.mutate(options);
  }
}
