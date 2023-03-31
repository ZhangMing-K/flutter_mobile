import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:graphql/client.dart';

import '../../iris_common.dart';

class BaseRepository extends GetxService {
  final IGraphqlProvider graphqlProvider;

  final IrisCacheInterface cache;
  BaseRepository({required this.graphqlProvider, required this.cache});

  Future<void> query<T>({
    required String type,
    required String id,
    required String document,
    required Function(dynamic data) callback,
    required Function(OperationException error) onError,
    QueryType queryType = QueryType.loadCache,
    Map<String, dynamic> variables = const <String, dynamic>{},
    List<String>? fragments,
  }) async {
    if (fragments != null) {
      for (final fragment in fragments) {
        document += fragment;
      }
    }
    final queryOptions = QueryOptions(
      document: gql(document),
      variables: variables,
      fetchPolicy: FetchPolicy.noCache,
      errorPolicy: ErrorPolicy.all,
      cacheRereadPolicy: CacheRereadPolicy.mergeOptimistic,
    );

    final completer = Completer();

    if (queryType == QueryType.loadCache) {
      final initialData = cache.getFromCache(type, id);
      if (initialData != null) {
        if (callback is Future) {
          await callback(initialData);
        } else {
          callback(initialData);
        }
        completer.complete();
      }
    }

    // final removeListener = cache.watch(key, callback);

    graphqlProvider.queryWithOptions(queryOptions).then((res) async {
      if (res?.hasException ?? false) {
        for (final i in res!.exception!.graphqlErrors) {
          if (i.toString().contains('invalid signature')) {
            //TODO: IMPROVE IT
            Get.find<IAuthUserService>()
                .logout(isAutoLogout: true, description: 'invalid signature 2');
          }
        }
        onError(res.exception!);
        // if (queryType != QueryType.loadMore) {
        //   // write to cache in exception
        //   await cache.write(key: key, value: res.data);
        // }
        callback(res.data);
        if (!completer.isCompleted) completer.complete();
      } else if (res?.data != null) {
        if (queryType != QueryType.loadMore) {
          cache.putOnCache(type, CacheEntry(id: id, data: res?.data));
        }
        callback(res?.data);

        Future.microtask(() {
          if (!completer.isCompleted) completer.complete();
        });
      }
    });

    // .timeout(Duration(seconds: 7), onTimeout: () {
    //   onError(
    //     OperationException(
    //       graphqlErrors: [
    //         GraphQLError(message: PoorConnectionException().message)
    //       ],
    //     ),
    //   );
    //   //completer.complete();
    // });
    return completer.future;
  }
}

class DataList<T> {
  final List<T> list;
  final String cursor;
  const DataList({required this.list, required this.cursor});
}

class IrisCacheManager {}

enum QueryType {
  /// loadCache will immediately deliver the result of the cache,
  /// and will deliver the result whenever the cache changes.
  loadCache,

  /// loadMore will deliver the result without caching, and will not save the cached data.
  loadMore,

  // loadRemote will deliver data from the internet, and update the cache with the new result.
  loadRemote,
}

class Repository<T> {
  final Future<T> local;
  final Future<T> remote;
  Repository({required this.local, required this.remote});

  void getResponse(ValueChanged<T> onSuccess, {Function? onError}) {
    local.then((localValue) {
      if (localValue != null) {
        onSuccess(localValue);
      } else {
        debugPrint('GraphQL cache is null');
      }

      remote.then((remoteValue) {
        if (remoteValue is List || remoteValue is Map) {
          if (const DeepCollectionEquality().equals(remoteValue, localValue)) {
            return;
          }
        }
        if (remoteValue == localValue) {
          return;
        } else {
          onSuccess(remoteValue);
        }
        onSuccess(remoteValue);
      }, onError: onError);
    });
  }
}

class TopTraderData<T> {
  final List<T> list;
  final SEGMENT_TYPE type;
  const TopTraderData({required this.list, required this.type});
}
