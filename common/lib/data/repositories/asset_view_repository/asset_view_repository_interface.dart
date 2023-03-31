import 'package:graphql/client.dart';

import '../../../iris_common.dart';

abstract class IAssetViewRepository {
  assetToWatchlist({required int assetKey, required bool watch});

  Future<List<Article>?> getArticles(
      {required List<int?> assetKeys, int? limit, int? offset});

  Repository<Map<String, dynamic>?> getAsset(
      {required List<int?> assetKeys, int? limit, int? offset});

  Future<void> getAssetMention({
    required int assetKey,
    int limit = 10,
    String? cursor,
    TEXT_TYPE textType = TEXT_TYPE.POST,
    QueryType queryType = QueryType.loadCache,
    required Function(dynamic data) callback,
    required Function(OperationException error) onError,
  });

  Future<void> getAssetStories({
    int limit = 15,
    QueryType queryType = QueryType.loadCache,
    required Function(List<Asset>? data) callback,
    required Function(OperationException error) onError,
  });

  Future<void> getAssetTopTraders({
    required int assetKey,
    int limit = 10,
    String? cursor,
    QueryType queryType = QueryType.loadCache,
    required Function(AssetTopTraderData<TopTraderData<User>> data) callback,
    required Function(OperationException error) onError,
  });

  Future<Historical?> getHistorical(
      {required List<int?> assetKeys,
      int? limit,
      int? offset,
      HISTORICAL_SPAN? span});
}

class AssetTopTraderData<T> {
  final Asset? asset;
  final List<T>? list;
  const AssetTopTraderData({this.asset, this.list});
}
