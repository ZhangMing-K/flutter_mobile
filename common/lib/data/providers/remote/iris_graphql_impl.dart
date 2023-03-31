import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql/client.dart';
import 'package:http/io_client.dart';

import '../../../iris_common.dart';

class GraphqlProvider extends IGraphqlProvider {
  String graphqlUrl = ENV.GRAPHQL_API_URL!;
  String graphqlSubscriptionUrl = ENV.GRAPHQL_SUBSCRIBE_URL!;
  IAuthUserService authUserStore;
  late HttpLink httpLink;
  late IrisWSLink websocketLink;
  late IrisAuthLink authLink;
  late Link link;
  late Link subLink;
  GraphQLClient? subClient;
  GraphQLClient? client;
  ValueNotifier<GraphQLClient?>? notifierClient;
  GraphqlProvider({required this.authUserStore});

  @override
  MutationOptions createMutationOptions({
    required String document,
    Map<String, dynamic>? variables,
    List<String>? fragments,
    FetchPolicy? fetchPolicy = FetchPolicy.networkOnly,
    Function? onError,
    bool errorLogging = false,
  }) {
    if (fragments != null) {
      for (var fragment in fragments) {
        document += fragment;
      }
    }

    return MutationOptions(
        document: gql(document),
        variables: variables ?? const {},
        fetchPolicy: fetchPolicy,
        onError: (err) {
          onError?.call(err);
          if (errorLogging) {
            debugPrint(err.toString());
          }
          // throw err!.graphqlErrors;
        });
  }

  @override
  QueryOptions createQueryOptions({
    required String document,
    Map<String, dynamic> variables = const <String, dynamic>{},
    List<String>? fragments,
    FetchPolicy? fetchPolicy = FetchPolicy.networkOnly,
  }) {
    if (fragments != null) {
      for (final fragment in fragments) {
        document += fragment;
      }
    }

    return QueryOptions(
      document: gql(document),
      variables: variables,
      fetchPolicy: fetchPolicy,
      errorPolicy: ErrorPolicy.all,
      cacheRereadPolicy: CacheRereadPolicy.mergeOptimistic,
    );
  }

  @override
  SubscriptionOptions createSubscriptionOptions({
    required String document,
    required Map<String, dynamic> variables,
    List<String>? fragments,
    FetchPolicy? fetchPolicy = FetchPolicy.networkOnly,
  }) {
    if (fragments != null) {
      for (var fragment in fragments) {
        document += fragment;
      }
    }

    return SubscriptionOptions(
      document: gql(document),
      variables: variables,
      fetchPolicy: fetchPolicy,
      errorPolicy: ErrorPolicy.all,
    );
  }

  @override
  Future<void> getClient() async {
    authLink = IrisAuthLink(
        getToken: () => authUserStore.authToken,
        getHeaders: () async {
          final coordinate = await getCoordinate();
          return {'coordinate': coordinate};
        });
    client = gqlClient();
    notifierClient = ValueNotifier(client);
  }

  @override
  GraphQLClient gqlClient() {
    if (ENV.GRAPHQL_API_URL!.contains('localhost') ||
        ENV.GRAPHQL_API_URL!.contains('10.0.2.2')) {
      // INFO: Workaround for self-signed certificate execption (to be used in local env only)
      final HttpClient _httpClient = HttpClient();
      _httpClient.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final IOClient _ioClient = IOClient(_httpClient);

      // Link to the GraphQL Endpoint
      httpLink = HttpLink(graphqlUrl, httpClient: _ioClient);
      link = authLink.concat(httpLink);

      setSubcriptionClient();
      return GraphQLClient(cache: GraphQLCache(), link: link);
    } else {
      httpLink = HttpLink(graphqlUrl);
      link = authLink.concat(httpLink);

      setSubcriptionClient();
      return GraphQLClient(
          link: link.concat(websocketLink), cache: GraphQLCache());
    }
  }

  @override
  Future<QueryResult> mutate(String document) {
    return client!.mutate(MutationOptions(
      document: gql(document),
    ));
  }

  @override
  Future<QueryResult> mutateWithOptions(MutationOptions options) {
    return client!.mutate(options);
  }

  @override
  void onInit() {
    getClient();
    super.onInit();
  }

  @override
  Future<QueryResult?> queryWithOptions(QueryOptions queryOptions) async {
    try {
      final res = await client!.query(
        queryOptions,
      );
      if (res.hasException) {
        final linkException = res.exception?.linkException;
        if (linkException != null) {
          if (linkException is HttpLinkParserException) {
            if (linkException.response.statusCode == 429) {
              return null;
            }
          }

          /// cannot connect to server
          Future.microtask(() {
            if (!Get.isSnackbarOpen) {
              // IrisSnackbar.trigger(
              //     title: 'Error: Your connection is slow or unavailable',
              //     body:
              //         'Try connecting to the internet and then refresh this page');
            }
          });

          return null;
        }

        //so if the signature is not correct it will log out.
        for (final i in res.exception!.graphqlErrors) {
          if (i.toString().contains('invalid signature')) {
            final IAuthUserService authUserStore = Get.find();
            authUserStore.logout(
                isAutoLogout: true, description: 'invalid signature 1');
            //Navigator.pushNamed(Get.overlayContext, LoginScreen.routeName());
          }
        }
      }

      return res;
    } catch (err) {
      return null;
    }
  }

  @override
  GraphQLClient? setSubcriptionClient() {
    websocketLink = IrisWSLink(graphqlSubscriptionUrl,
        config: SocketClientConfig(
            autoReconnect: true,
            inactivityTimeout: const Duration(seconds: 29),
            delayBetweenReconnectionAttempts: const Duration(seconds: 1),
            initialPayload: () {
              return {'Authorization': authUserStore.authToken};
            }),
        getToken: () => authUserStore.authToken);
    subLink =
        Link.split((request) => request.isSubscription, websocketLink, link);
    subClient = GraphQLClient(link: subLink, cache: GraphQLCache());
    return subClient;
  }

  @override
  Stream<QueryResult>? subscribeWithOptions(SubscriptionOptions options) {
    if (subClient == null) {
      return null;
    }
    try {
      final subscription = subClient!.subscribe(options);
      return subscription;
    } catch (err) {
      return null;
    }
  }

  static Future<String> getCoordinate() async {
    final code = ENV.IRIS_API_KEY ?? ''; // insert code here
    final decryptedData = await IrisCryptr(secret: code, iterations: 1)
        .encrypt(DateTime.now().toUtc().toIso8601String());
    return decryptedData;
  }
}
