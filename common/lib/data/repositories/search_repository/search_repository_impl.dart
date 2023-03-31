import 'package:flutter/foundation.dart';
import 'package:graphql/client.dart';

import '../../../iris_common.dart';

class SearchRepository implements ISearchRepository {
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

  // final IEncriptedDatabase localProvider;
  // final ICacheManager localProvider;

  SearchRepository({
    required this.remoteProvider,
    required this.repository,
    //  @required this.localProvider,
  });

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
  Future<void> discoverPageGet({
    required DiscoverPageGetInput input,
    QueryType queryType = QueryType.loadCache,
    required Function(DiscoverPageGetResponse data) callback,
    required Function(OperationException error) onError,
  }) {
    const document = r'''
      query discoverPageGet($input: DiscoverPageGetInput) {
        discoverPageGet(input: $input) {
          nextCursor
          items{
            followSuggestion{
              carouselTitle
              userCards{
                subtitle
                user{
                  userKey
                  profilePictureUrl
                  firstName
                  lastName
                  username
                  description
                  email
                  verifiedAt
                  portfolios {
                    brokerName
                  }
                  temporarySnapshotHistoricalPoints {
                    dayPercent
                    weekPercent
                    monthPercent
                    threeMonthPercent
                    yearPercent
                    allPercent
                  }
                  dailyPercentGain
                  badgeType
                  assetsWatching (input:{global: true}) {
                    symbol
                    pictureUrl
                  }
                  followStats{
                    numberOfFollowers
                  }
                  authUserFollowInfo{
                    followStatus
                  }
                  connectedBrokerNames
                }
              }
            }
          }

        }
      }
    ''';
    final variables = {
      'input': input.toJson(),
    };

    return repository.query(
      type: CacheType.searchUsers,
      id: input.nextCursor.toString(),
      document: document,
      variables: variables,
      queryType: queryType,
      callback: (data) {
        return callback(
            DiscoverPageGetResponse.fromJson(data?['discoverPageGet'] ?? {}));
      },
      onError: (err) {
        print(err);
        return onError(err);
      },
    );
  }

  @override
  Future<void> followSuggestions({
    required FOLLOW_SUGGESTION_TYPE suggestionType,
    String cursor = '',
    QueryType queryType = QueryType.loadCache,
    required Function(List<User> data) callback,
    required Function(OperationException error) onError,
  }) {
    const document = r'''
      query followSuggestionsGet($input: FollowSuggestionsGetInput) {
        followSuggestionsGet(input: $input) {
          users{
            userKey
            profilePictureUrl
            firstName
            lastName
            username
            description
            email
            verifiedAt
            portfolios {
              brokerName
            }
            temporarySnapshotHistoricalPoints {
              dayPercent
              weekPercent
              monthPercent
              threeMonthPercent
              yearPercent
              allPercent
            }
            dailyPercentGain
            badgeType
            assetsWatching (input:{global: true}) {
              symbol
              pictureUrl
            }
            followStats{
              numberOfFollowers
            }
            authUserFollowInfo{
              followStatus
            }
            connectedBrokerNames
          }
        }
      }
    ''';
    final variables = {
      'input': {
        'followSuggestionType': describeEnum(suggestionType),
        'cursor': cursor
      }
    };

    return repository.query(
      type: CacheType.searchUsers,
      id: suggestionType.toString(),
      document: document,
      variables: variables,
      queryType: queryType,
      callback: (data) {
        final userData = data?['followSuggestionsGet']?['users'] as List?;
        if (userData != null) {
          final List<User> userList =
              List<User>.from(userData.map((i) => User.fromJson(i)));
          callback(userList);
        } else {
          callback(<User>[]);
        }
      },
      onError: onError,
    );
  }

  @override
  Future<void> loadAssets({
    String? partialSymbol,
    String? searchValue = '',
    int limit = 10,
    int? offset = 10,
    List<int>? assetKeys,
    QueryType queryType = QueryType.loadCache,
    required Function(dynamic data) callback,
    required Function(OperationException error) onError,
  }) {
    final requestedFields = '''
      assetKey
      symbol  
      name
      pictureUrl
      quote{
        changePercent
        extendedChange
        latestPrice
        change
      }
      authUserIsWatching
      dayHistorical : historical(input:{span:DAY}){
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
    if (partialSymbol != null) {
      input['partialSymbol'] = partialSymbol;
    }
    if (searchValue != null) {
      input['partialSymbol'] = searchValue;
    }
    final variables = {'input': input};

    return repository.query(
      type: CacheType.searchStocks,
      id: searchValue.toString(),
      document: document,
      variables: variables,
      queryType: queryType,
      callback: (data) {
        if (data == null) {
          callback(<Asset>[]);
          return;
        }

        final assetListData = data['assetSearch']['assets'];
        final List<Asset> assetList =
            List<Asset>.from(assetListData.map((i) => Asset.fromJson(i)));
        callback(assetList);
      },
      onError: onError,
    );
  }

  @override
  Future<void> loadUsers({
    String? name = '',
    int limit = 10,
    int? offset = 10,
    QueryType queryType = QueryType.loadCache,
    required Function(dynamic data) callback,
    required Function(OperationException error) onError,
  }) {
    const document = '''
      query relevantUsersSearch(\$input: RelevantUsersSearchInput) {
        relevantUsersSearch(input: \$input) {
          users{
            userKey
            profilePictureUrl
            firstName
            lastName
            username
            email
            verifiedAt
            badgeType
            authUserFollowInfo{
              followStatus
            }
            connectedBrokerNames
          }
        }
      }
    ''';
    final variables = {
      'input': {
        'excludeAuthUser': true,
        'searchText': name,
        'limit': limit,
        'offset': offset,
        'context': {'contextType': 'GENERAL'}
      }
    };

    return repository.query(
      type: CacheType.searchUsers,
      id: name.toString(),
      document: document,
      variables: variables,
      queryType: queryType,
      callback: (data) {
        if (data == null) {
          return callback(<User>[]);
        }
        if (data['relevantUsersSearch'] != null) {
          final userData = data['relevantUsersSearch']['users'];
          final List<User> userList =
              List<User>.from(userData.map((i) => User.fromJson(i)));
          return callback(userList);
        } else {
          return callback(<User>[]);
        }
      },
      onError: onError,
    );
  }

  @override
  Future<void> relevantUsersSearch({
    String? searchText = '',
    int limit = 10,
    int? offset = 0,
    bool? excludeAuthUser = true,
    List<int>? excludeUserKeys,
    CONTEXT_TYPE? contextType = CONTEXT_TYPE.GENERAL,
    int? contextKey,
    QueryType queryType = QueryType.loadCache,
    required Function(List<User> data) callback,
    required Function(OperationException error) onError,
  }) {
    const document = r'''
      query relevantUsersSearch($input: RelevantUsersSearchInput) {
        relevantUsersSearch(input: $input) {
          users{
            userKey
            profilePictureUrl
            firstName
            lastName
            username
            email
            verifiedAt
            badgeType
            firstOrderAt
            authUserFollowInfo{
              followStatus
            }
            connectedBrokerNames
          }
        }
      }
    ''';
    final Map<String, dynamic> variables = {
      'input': {
        'searchText': searchText,
        'limit': limit,
        'offset': offset,
        'excludeAuthUser': excludeAuthUser,
        'context': {
          'contextType': describeEnum(contextType!),
        }
      }
    };

    if (contextKey != null) {
      variables['input']['context']['contextKey'] = contextKey;
    }

    if (excludeUserKeys!.isNotEmpty) {
      variables['excludeUserKeys'] = excludeUserKeys;
    }

    return repository.query(
      type: CacheType.relevantUsersSearch,
      id: searchText.toString(),
      document: document,
      variables: variables,
      queryType: queryType,
      callback: (data) {
        if (data == null) {
          return callback(<User>[]);
        }

        final userData = data['relevantUsersSearch']['users'];
        final List<User> userList =
            List<User>.from(userData.map((i) => User.fromJson(i)));
        callback(userList);
      },
      onError: onError,
    );
  }

  @override
  Future<void> searchAssets({
    String? searchValue = '',
    int limit = 10,
    int? offset = 10,
    QueryType queryType = QueryType.loadCache,
    required Function(dynamic data) callback,
    required Function(OperationException error) onError,
  }) {
    const requestedFields = '''
      assetKey
      symbol  
      name
      pictureUrl
      quote{
        changePercent
        extendedChange
        latestPrice
        change
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

    final Map<String, dynamic> input = {'limit': limit, 'offset': offset};

    if (searchValue != null) {
      input['searchValue'] = searchValue;
    }
    final variables = {'input': input};

    return repository.query(
      type: CacheType.searchStocks,
      id: searchValue.toString(),
      document: document,
      variables: variables,
      queryType: queryType,
      callback: (data) {
        if (data == null) {
          callback(<Asset>[]);
          return;
        }

        final assetListData = data['assetSearch']['assets'];
        final List<Asset> assetList =
            List<Asset>.from(assetListData.map((i) => Asset.fromJson(i)));
        callback(assetList);
      },
      onError: onError,
    );
  }

  @override
  Future<void> topInvestorsSuggestions({
    QueryType queryType = QueryType.loadCache,
    required Function(List<TopTraderData<User>> data) callback,
    required Function(OperationException error) onError,
  }) {
    var document = '''
      query {
        all: ${topTradesRequestedFields(SEGMENT_TYPE.ALL_POSITION_TYPES)}
        equity: ${topTradesRequestedFields(SEGMENT_TYPE.EQUITY)}
        options: ${topTradesRequestedFields(SEGMENT_TYPE.OPTION)}
        crypto: ${topTradesRequestedFields(SEGMENT_TYPE.CRYPTO)}
        meme: ${topTradesRequestedFields(SEGMENT_TYPE.MEME)}
      }
    ''';

    return repository.query(
      type: CacheType.topInvestors,
      id: 'topInvestors',
      document: document,
      queryType: queryType,
      callback: (data) {
        if (data == null) {
          return callback(<TopTraderData<User>>[]);
        }
        final List<TopTraderData<User>> topTraderData = [];
        final allData = data['all'];
        final List<User> allUsers = List<User>.from(
            allData?['users']?.map((i) => User.fromJson(i)) ?? []);
        final equityData = data?['equity'];
        final List<User> equityUsers = List<User>.from(
            equityData?['users']?.map((i) => User.fromJson(i)) ?? []);
        final optionsData = data?['options'];
        final List<User> optionsUsers = List<User>.from(
            optionsData?['users']?.map((i) => User.fromJson(i)) ?? []);
        final cryptoData = data?['crypto'];
        final List<User> cryptoUsers = List<User>.from(
            cryptoData?['users']?.map((i) => User.fromJson(i)) ?? []);
        final memeData = data?['meme'];
        final List<User> memeUsers = List<User>.from(
            memeData?['users']?.map((i) => User.fromJson(i)) ?? []);
        topTraderData.add(TopTraderData(
            list: allUsers, type: SEGMENT_TYPE.ALL_POSITION_TYPES));
        topTraderData
            .add(TopTraderData(list: equityUsers, type: SEGMENT_TYPE.EQUITY));
        topTraderData
            .add(TopTraderData(list: optionsUsers, type: SEGMENT_TYPE.OPTION));
        topTraderData
            .add(TopTraderData(list: cryptoUsers, type: SEGMENT_TYPE.CRYPTO));
        topTraderData
            .add(TopTraderData(list: memeUsers, type: SEGMENT_TYPE.MEME));
        callback(topTraderData);
      },
      onError: onError,
    );
  }

  @override
  Future<void> topPerformersSuggestions({
    QueryType queryType = QueryType.loadCache,
    required Function(List<LeaderboardInstance> data) callback,
    required Function(OperationException error) onError,
  }) async {
    const document = r'''
      query leaderboardGet($input: LeaderboardGetInput) {
        leaderboardGet(input: $input) {
          leaderboard {
            instances {
              portfolio {
                user {
                  userKey
                  profilePictureUrl
                  firstName
                  lastName
                  username
                  description
                  email
                  verifiedAt
                  badgeType
                  followStats{
                    numberOfFollowers
                  }
                  authUserFollowInfo{
                    followStatus
                  }
                }
              }
              snapshot {
                dayPercent
                weekPercent
              }
            }
          }
        }
      }
    ''';
    final variables = {
      'input': {
        'span': describeEnum(HISTORICAL_SPAN.WEEK),
        'limit': 3,
        'mostRecent': true,
      }
    };

    return repository.query(
      type: CacheType.topPerformers,
      id: 'topPerformers',
      document: document,
      variables: variables,
      queryType: queryType,
      callback: (data) {
        if (data == null) {
          return callback(<LeaderboardInstance>[]);
        }

        final leaderboardData = data['leaderboardGet']['leaderboard'];
        final Leaderboard leaderboard = Leaderboard.fromJson(leaderboardData);
        final List<LeaderboardInstance> instances = leaderboard.instances!;
        callback(instances);
      },
      onError: onError,
    );
  }

  String topTradesRequestedFields(SEGMENT_TYPE segmentType) {
    final stringSegmentType = describeEnum(segmentType);
    return '''
      topTraders(input: {segmentType: $stringSegmentType, limit: 10}){
        users{
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
