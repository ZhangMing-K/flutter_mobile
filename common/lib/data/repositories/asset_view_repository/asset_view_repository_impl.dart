import 'package:flutter/foundation.dart';
import 'package:graphql/client.dart';

import '../../../iris_common.dart';

class AssetViewRepository implements IAssetViewRepository {
  final IGraphqlProvider remoteProvider;
  final BaseRepository repository;
  String historicalResponseFragment = '''
    span
    returnAmount
    returnPercentage
    openAmount
    closeAmount
    historicalType
    points{
      beginsAt
      openAmount
      closeAmount
      spanReturnAmount
      spanReturnPercentage
      volume
    }
  ''';

  AssetViewRepository({
    required this.remoteProvider,
    required this.repository,
  });

  String articlesFrag({int? offset}) {
    return '''
      articles(input: {limit: 5,offset:$offset}){
        articleKey
        headline
        imageUrl
        url
        postedAt
        summary
        source
        text{
          textKey
          numberOfReactions
          numberOfComments
          textType
          article{
            summary
            headline
            imageUrl
          }
          reactions(input: {limit:1}){
            user{
              userKey
              firstName
              lastName
            }
          }
          authUserReaction{
            user{
              userKey
              firstName
              lastName
            }
          }
          comments(input:{limit:1,offset:0}){
            textKey
            value
            textType
            parentKey
            user{
              userKey
              firstName
              lastName
              profilePictureUrl
              avatar {
                avatarKey
                avatarName
                code
                url
              }
            }
            authUserReaction{
              user{
                userKey
                firstName
                lastName
              }
            }
          }
        }
      }
    ''';
  }

  @override
  assetToWatchlist({required int assetKey, required bool watch}) async {
    const document = r'''
      mutation userAssetsUpdate($input: UserAssetsUpdateInput!){
        userAssetsUpdate(input: $input){
          userAssets {
            assetKey
          }
        }
      }
    ''';

    final dynamic variables = {
      'input': {
        'assetKeys': [assetKey],
        'watch': watch
      }
    };

    try {
      final mutationOptions = remoteProvider.createMutationOptions(
          document: document, variables: variables);
      final res = await remoteProvider.mutateWithOptions(mutationOptions);
      if (res.data == null) {
        throw 'Error did not receive data from api';
      }
      return true;
    } catch (err) {
      debugPrint(err.toString());
      return null;
    }
  }

  @override
  Future<List<Article>?> getArticles(
      {List<int?>? assetKeys, int? limit = 5, int? offset = 0}) async {
    var document = '''
      query assetSearch(\$input: AssetSearchInput) 
    ''';
    document += '''
    {
        assetSearch(input: \$input) {
          assets{
            ${articlesFrag(offset: offset)}
          }
        }
      }
    ''';
    final input = {'limit': limit, 'offset': 0, 'assetKeys': assetKeys};

    final queryOptions = remoteProvider.createQueryOptions(
        document: document,
        variables: {'input': input},
        fetchPolicy: FetchPolicy.networkOnly);
    final res = await remoteProvider.queryWithOptions(queryOptions);
    if (res == null || res.data == null || res.data!['assetSearch'] == null) {
      return null;
    }
    final assetListData = res.data!['assetSearch']['assets'];
    final List<Asset> assetList =
        List<Asset>.from(assetListData.map((i) => Asset.fromJson(i)));
    if (assetList.isNotEmpty) {
      final Asset asset = assetList[0];
      final List<Article>? articles = asset.articles;
      return articles;
    }
    return <Article>[];
  }

  @override
  Repository<Map<String, dynamic>?> getAsset(
      {required List<int?> assetKeys, int? limit = 1, int? offset = 0}) {
    final requestedFields = getRequestedFields();
    var document = '''
      query assetSearch(\$input: AssetSearchInput) 
    ''';
    document += '''
    {
      assetSearch(input: \$input) {
        assets{
          $requestedFields
        }
      }
    }
    ''';

    final input = {'limit': limit, 'offset': offset, 'assetKeys': assetKeys};

    final dataFromRemote = Future<Map<String, dynamic>?>(() async {
      final queryOptions = remoteProvider.createQueryOptions(
          document: document,
          variables: {'input': input},
          fetchPolicy: FetchPolicy.networkOnly);
      final res = await remoteProvider.queryWithOptions(queryOptions);
      if (res == null || res.data == null || res.data!['assetSearch'] == null) {
        return null;
      }
      final assetListData =
          AssetSearchResponse.fromJson(res.data?['assetSearch'] ?? {});

      final List<Asset> assetList = assetListData.assets ?? [];
      if (assetList.isEmpty) {
        return null;
      }
      final Asset asset = assetList[0];
      final List<Article>? articles = asset.articles;
      return {
        'asset': asset,
        'articles': articles,
      };
    });

    final dataFromLocal = Future<Map<String, dynamic>?>(() async {
      final queryOptions = remoteProvider.createQueryOptions(
        document: document,
        variables: {'input': input},
        fetchPolicy: FetchPolicy.cacheFirst,
      );
      final res = await remoteProvider.queryWithOptions(queryOptions);
      final assetListData =
          AssetSearchResponse.fromJson(res?.data?['assetSearch'] ?? {});

      final List<Asset> assetList = assetListData.assets ?? [];
      if (assetList.isEmpty) {
        return null;
      }
      final Asset asset = assetList[0];
      final List<Article>? articles = asset.articles;
      return {
        'asset': asset,
        'articles': articles,
      };
    });

    return Repository(local: dataFromLocal, remote: dataFromRemote);
  }

  @override
  Future<void> getAssetMention({
    required int assetKey,
    int limit = 10,
    String? cursor,
    TEXT_TYPE textType = TEXT_TYPE.POST,
    QueryType queryType = QueryType.loadCache,
    required Function(dynamic data) callback,
    required Function(OperationException error) onError,
  }) async {
    const requestedFields = TextGql.feed;
    const document = '''
      query advancedFeedGet(\$input: AdvancedFeedGetInput!){
        advancedFeedGet(input:\$input) {
          texts{
             $requestedFields
          }
          nextCursor
        }
      }
    ''';

    final variables = {
      'input': {
        'assetKeys': [assetKey],
        'textTypes': [describeEnum(textType)],
        'limit': limit,
      }
    };
    if (cursor != '') {
      variables['input']!['cursor'] = cursor!;
    }

    return repository.query(
      type: CacheType.assetMention,
      id: 'assetMention' + assetKey.toString(),
      document: document,
      variables: variables,
      callback: (data) {
        callback(data);
      },
      onError: onError,
      queryType: queryType,
    );
  }

  @override
  Future<void> getAssetStories({
    int limit = 15,
    QueryType queryType = QueryType.loadCache,
    required Function(List<Asset>? data) callback,
    required Function(OperationException error) onError,
  }) async {
    const requestedFields = '''assetKey
      symbol
      pictureUrl
      name
      currentPrice
      quote {
        changePercent
      }
  ''';
    var document = '''
      query assetPopular(\$input: AssetInput!) 
    ''';
    document += '''
    {
      assetPopular(input: \$input) {
        $requestedFields
      }
    }
    ''';

    final input = {'limit': limit, 'offset': 0};
    return repository.query(
      type: CacheType.feedAssetStories,
      id: CacheType.feedAssetStories,
      variables: {'input': input},
      document: document,
      queryType: queryType,
      callback: (data) {
        if (data == null || !data.containsKey('assetPopular')) {
          return callback(<Asset>[]);
        }
        final List assetListData = data['assetPopular'] ?? [];
        final List<Asset> assetList =
            List<Asset>.from(assetListData.map((i) => Asset.fromJson(i)));
        callback(assetList);
      },
      onError: onError,
    );
  }

  @override
  Future<void> getAssetTopTraders({
    required int assetKey,
    int limit = 10,
    String? cursor,
    QueryType queryType = QueryType.loadCache,
    required Function(AssetTopTraderData<TopTraderData<User>> data) callback,
    required Function(OperationException error) onError,
  }) {
    var document = '''
      query {
        assetSearch(input: {assetKeys: [$assetKey]}) {
          assets {
            ${getRequestedFields()}
            all: ${topTradesRequestedFields(SEGMENT_TYPE.ALL_POSITION_TYPES)}
            equity: ${topTradesRequestedFields(SEGMENT_TYPE.EQUITY)}
            options: ${topTradesRequestedFields(SEGMENT_TYPE.OPTION)}
          }
        }
      }
    ''';

    return repository.query(
      type: CacheType.topAssetInvestors,
      id: 'topAssetInvestors' + assetKey.toString(),
      document: document,
      queryType: queryType,
      callback: (data) {
        if (data == null) {
          return callback(const AssetTopTraderData());
        }
        final List<TopTraderData<User>> topTraderData = [];
        final assetsData = data['assetSearch']['assets'][0];
        final Asset asset = Asset.fromJson(assetsData);
        final allData = assetsData['all'];
        final List<User> allUsers = allData != null
            ? List<User>.from(allData.map((i) => User.fromJson(i['user'])))
            : <User>[];
        final equityData = assetsData['equity'];
        final List<User> equityUsers = equityData != null
            ? List<User>.from(equityData.map((i) => User.fromJson(i['user'])))
            : <User>[];
        final optionsData = assetsData['options'];
        final List<User> optionsUsers = optionsData != null
            ? List<User>.from(optionsData.map((i) => User.fromJson(i['user'])))
            : <User>[];
        topTraderData.add(TopTraderData(
            list: allUsers, type: SEGMENT_TYPE.ALL_POSITION_TYPES));
        topTraderData
            .add(TopTraderData(list: equityUsers, type: SEGMENT_TYPE.EQUITY));
        topTraderData
            .add(TopTraderData(list: optionsUsers, type: SEGMENT_TYPE.OPTION));
        callback(AssetTopTraderData(asset: asset, list: topTraderData));
      },
      onError: onError,
    );
  }

  @override
  Future<Historical?> getHistorical(
      {List<int?>? assetKeys,
      int? limit = 1,
      int? offset = 0,
      HISTORICAL_SPAN? span}) async {
    final requestedFields = '''
      historical : historical(input:{span:${describeEnum(span!)}}){
      $historicalResponseFragment
    }
    ''';
    var document = '''
      query assetSearch(\$input: AssetSearchInput) 
    ''';
    document += '''
    {
        assetSearch(input: \$input) {
          assets{
            $requestedFields
          }
        }
      }
    ''';
    final input = {'limit': limit, 'offset': offset, 'assetKeys': assetKeys};

    final queryOptions = remoteProvider.createQueryOptions(
        document: document,
        variables: {'input': input},
        fetchPolicy: FetchPolicy.networkOnly);
    final res = await remoteProvider.queryWithOptions(queryOptions);
    if (res == null || res.data == null || res.data!['assetSearch'] == null) {
      return null;
    }
    final assetListData = res.data!['assetSearch']['assets'];
    final List<Asset> assetList =
        List<Asset>.from(assetListData.map((i) => Asset.fromJson(i)));
    final Asset asset = assetList[0];
    final Historical? historical = asset.historical;
    return historical;
  }

  String getRequestedFields() {
    return '''
      assetKey
      symbol
      pictureUrl
      name
      currentPrice
      ceo{
        displayName
        personPictureUrl
      }
      authUserIsWatching
      irisAssetOutlook {
        bullish
        bearish
      }
      orders(input:{authUser: true}){
        orderKey
        symbol
        orderSide
        optionType
        positionType
        averagePrice
        placedAt
      }
      assetStat{
        putCallRatio
        peRatio
        numberEmployees
        nextDividendRate
        marketCap
        ttmDividendRate
        ttmEPS
        beta
        maxChangePercent
        profitMargin
        revenuePerShare
        totalCash
        currentDebt
        revenue
        grossProfit
        ebitda
        revenuePerShare
        dividendYield
        float
        week52High
        week52Low
      }
      quote {
        change
        changePercent
        latestPrice
      }
      shortInfo {
        shortPercentOfFloat
      }
      dayHistorical : historical(input:{span:DAY}){
        $historicalResponseFragment
      }
  ''';
  }

  String topTradesRequestedFields(SEGMENT_TYPE segmentType) {
    final stringSegmentType = describeEnum(segmentType);
    return '''
      topTraders(input: {segmentType: $stringSegmentType, limit: 10}){
        user{
          userKey
          firstName
          lastName
          username
          badgeType
          profilePictureUrl
          authUserFollowInfo{
            followStatus
          }
          tradePerformanceConnections(input: {segmentTypes: [ALL_POSITION_TYPES]}){
            tradePerformance{
              tradeAccuracy
              openTradesPerMonth
            }
            percentileConnection{
              percentile
            }
            mostProfitableAssets(input: {limit: 3}){
              assetKey
              name
              pictureUrl
            }
          }
        }
        segmentType
      }
    ''';
  }
}
