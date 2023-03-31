import 'package:flutter/foundation.dart';
import 'package:graphql/client.dart';

import '../../../iris_common.dart';

class ProfileRepository implements IProfileRepository {
  final BaseRepository remoteProvider;
  ProfileRepository({
    required this.remoteProvider,
  });

  @override
  Future<UserUserUpdateResponse?> changeNotifications({
    USER_POST_NOTIFICATION_AMOUNT? postNotificationAmount,
    USER_TRADE_NOTIFICATION_AMOUNT? tradeNotificationAmount,
    required int userKey,
  }) async {
    const document = r'''
    mutation userUserUpdate($input: UserUserInput!) {
      userUserUpdate(input:$input){
        userUser{
          profileUserKey
          accountUserKey
          postNotificationAmount
          tradeNotificationAmount
        }
      }
    }
    ''';
    final input = <String, dynamic>{
      'userKey': userKey,
    };

    if (postNotificationAmount != null) {
      input['postNotificationAmount'] = describeEnum(postNotificationAmount);
    }

    if (tradeNotificationAmount != null) {
      input['tradeNotificationAmount'] = describeEnum(tradeNotificationAmount);
    }

    final options = remoteProvider.graphqlProvider
        .createMutationOptions(document: document, variables: {'input': input});
    try {
      final res =
          await remoteProvider.graphqlProvider.mutateWithOptions(options);

      final data = res.data?['userUserUpdate'];
      if (data == null) {
        return null;
      } else {
        return UserUserUpdateResponse.fromJson(data);
      }
    } catch (err) {
      debugPrint(err.toString());
      return null;
    }
  }

  @override
  Future<User> changePrivacy({
    required TRADE_STAT_VISIBILITY tradeStatVisibility,
  }) async {
    const document = r'''
    mutation userEdit($input: UserEditInput) {
      userEdit(input:$input){
        user{
          tradeStatVisibility
        }
      }
    }
    ''';
    final input = {
      'tradeStatVisibility': describeEnum(tradeStatVisibility),
    };

    final options = remoteProvider.graphqlProvider
        .createMutationOptions(document: document, variables: {'input': input});
    try {
      final res =
          await remoteProvider.graphqlProvider.mutateWithOptions(options);
      final userData = res.data!['userEdit']['user'];
      final user = User.fromJson(userData);
      return user;
    } catch (err) {
      rethrow;
    }
  }

  @override
  Future<void> getGoldConnection({
    int? userKey,
    required String requestedFields,
    required QueryType queryType,
    required Function(GoldConnection? data) callback,
    required Function(OperationException error) onError,
  }) {
    var document = r'''
    query usersGet($input: UsersGetInput!) {
        usersGet(input: $input) {
          users {
    ''';
    document += requestedFields;
    document += '}}}';

    final variables = {
      'input': {
        'userKeys': [userKey],
      }
    };

    return remoteProvider.query(
      type: CacheType.goldConnection,
      id: '$userKey',
      document: document,
      variables: variables,
      callback: (data) {
        final response = UsersGetResponse.fromJson(data?['usersGet'] ?? {});
        if (response.users?.isNotEmpty ?? false) {
          callback(response.users!.first.goldConnection);
        } else {
          callback(null);
        }
      },
      onError: onError,
      queryType: queryType,
    );
  }

  @override
  Future<void> getWatchListForUser({
    required int userKey,
    required QueryType queryType,
    required Function(List<Asset> data) callback,
    required Function(OperationException error) onError,
  }) {
    var document = r'''
    query usersGet($input: UsersGetInput!) {
        usersGet(input: $input) {
          users {
            userKey
            watchlist(input: {limit: 10}) {
              assetKey
              symbol
              name
              description
              companyUrl
              pictureUrl
              currentPrice
              authUserIsWatching
              quote {
                changePercent
                change
                latestPrice
              }
            
    ''';
    document += StoryGql.storyLimit1;
    document += '}}}}';
    final variables = {
      'input': {
        'userKeys': [userKey],
      }
    };

    final id = 'profileWatchlist-$userKey';

    return remoteProvider.query(
      type: CacheType.profileWatchlist,
      id: id,
      document: document,
      variables: variables,
      callback: (data) {
        final response = UsersGetResponse.fromJson(data?['usersGet'] ?? {});
        if (response.users?.isNotEmpty ?? false) {
          callback(response.users!.first.watchlist ?? []);
        } else {
          callback([]);
        }
      },
      queryType: queryType,
      onError: (err) {
        print('error happened $err');
      },
    );
  }

  @override
  Future<void> getPortfolios({
    required int userKey,
    required QueryType queryType,
    required Function(List<Portfolio> data) callback,
    required Function(OperationException error) onError,
  }) {
    var document = r'''
    query usersGet($input: UsersGetInput!) {
        usersGet(input: $input) {
          users {
    ''';
    document += portfolioSummaryGql;
    document += '}}}';

    final variables = {
      'input': {
        'userKeys': [userKey],
      }
    };

    final id = 'profilePortfolios-$userKey';

    return remoteProvider.query(
      type: CacheType.profilePortfolios,
      id: id,
      document: document,
      variables: variables,
      callback: (data) {
        final response = UsersGetResponse.fromJson(data?['usersGet'] ?? {});
        if (response.users?.isNotEmpty ?? false) {
          callback(response.users!.first.portfolios ?? []);
        } else {
          callback([]);
        }
      },
      queryType: queryType,
      onError: onError,
    );
  }

  @override
  Future<void> getPostsOrOrders({
    int offset = 0,
    int? userKey,
    TEXT_TYPE? type,
    required QueryType queryType,
    required Function(UserProfileFeedData<TextModel> data) callback,
    required Function(OperationException error) onError,
  }) {
    var document = r'''
    query usersGet($input: UsersGetInput!) {
        usersGet(input: $input) {
          users {
    ''';
    document += profileTextsGql(offset: offset, textType: describeEnum(type!));
    document += '}}}';

    final variables = {
      'input': {
        'userKeys': [userKey],
      }
    };

    return remoteProvider.query(
      type: CacheType.profilePosts,
      id: '$type-$userKey',
      document: document,
      variables: variables,
      callback: (data) {
        final response = UsersGetResponse.fromJson(data?['usersGet'] ?? {});
        if (response.users?.isNotEmpty ?? false) {
          callback(UserProfileFeedData(
              list: response.users?.first.texts ?? [], type: type));
        } else {
          callback(UserProfileFeedData(list: [], type: type));
        }
      },
      onError: onError,
      queryType: queryType,
    );
  }

  @override
  Future<void> getUserByKey({
    required int userKey,
    required Function(UsersGetResponse data) callback,
    required String userGql,
    required Function(OperationException error) onError,
    QueryType queryType = QueryType.loadCache,
  }) {
    var document = r'''
    query getUserByKey($userKey: Int) {
        usersGet(input: {
          userKeys: [$userKey]
        }) {
          users {
            userKey
            authUserUser {
              postNotificationAmount
              tradeNotificationAmount
            }
    ''';

    document += userGql;
    document += '}}}';

    final variables = {'userKey': userKey};
    return remoteProvider.query(
      document: document,
      variables: variables,
      type: CacheType.profileSummary,
      id: userKey.toString(),
      callback: (data) {
        return callback(UsersGetResponse.fromJson(data?['usersGet'] ?? {}));
      },
      onError: onError,
      queryType: queryType,
    );
  }

  @override
  Future<void> positionTypeSummaryGet({
    required PositionTypeSummaryGetInput input,
    required Function(PositionTypeSummaryGetResponse data) callback,
    required Function(OperationException error) onError,
    QueryType queryType = QueryType.loadCache,
  }) {
    const document = '''
      query positionTypeSummaryGet(\$input: PositionTypeSummaryGetInput!){
        positionTypeSummaryGet(input:\$input) {
          positionTypeSummary{
            equityPercent
            optionPercent
            cryptoPercent
            equityMarketValue
            optionMarketValue
            cryptoMarketValue
          }
         
        }
      }
    ''';

    final variables = {
      'input': input.toJson(),
    };

    // final id = input.userKey.toString();

    return remoteProvider.query(
      document: document,
      variables: variables,
      type: CacheType.profileSummary,
      id: input.hashCode.toString(),
      callback: (data) {
        final feed = PositionTypeSummaryGetResponse.fromJson(
            data?['positionTypeSummaryGet'] ?? {});
        return callback(feed);
      },
      onError: onError,
      queryType: queryType,
    );
  }

  @override
  Future<void> positionsSummaryGet({
    required PositionsSummaryGetInput input,
    required Function(PositionsSummaryGetResponse data) callback,
    required Function(OperationException error) onError,
    QueryType queryType = QueryType.loadCache,
  }) {
    const document = '''
      query positionsSummaryGet(\$input: PositionsSummaryGetInput!){
        positionsSummaryGet(input:\$input) {
          summarizedPositions{
            userKey
            portfolioKeys
            symbol
            assetKey
            asset{
              assetKey
              symbol
              name
              currentPrice
              pictureUrl
            }
            openedAt
            totalTransactionCount
            postCount
            positionTypes 
            relativePositionValue
            profitLossPercent
            todayProfitLossPercent
            totalPositionValue
            profitLoss
            todayProfitLoss
            positions{
              stockName
              positionType
              positionDirection
              openedAt
              averageBuyPrice
              relativeMetrics{
                portfolioAllocation
                totalProfitLossPercent
                todayProfitLossPercent
              }
              totalTransactionCount
            }
            positionTypeSummary{
              equityPercent
              optionPercent
              cryptoPercent
              equityMarketValue
              optionMarketValue
              cryptoMarketValue
            }
          }
        }
      }
    ''';

    final variables = {
      'input': input.toJson(),
    };

    // final id = input.userKey.toString();

    return remoteProvider.query(
      document: document,
      variables: variables,
      type: CacheType.profileSummary,
      id: input.hashCode.toString(),
      callback: (data) {
        final feed = PositionsSummaryGetResponse.fromJson(
            data?['positionsSummaryGet'] ?? {});
        return callback(feed);
      },
      onError: onError,
      queryType: queryType,
    );
  }

  @override
  Future<void> storiesUserGet({
    required int limit,
    required Function(List<RelevantUserRes> data) callback,
    required Function(OperationException error) onError,
    QueryType queryType = QueryType.loadCache,
  }) {
    final storiesConnection = '''
      storiesConnection(input: {limit: $limit}){
        storiesPagination{
          nextCursor
          previousCursor
          stories{
            ${TextGql.fullTextWithOutStories}
          }
        }
        metaData{
          nbrStories
          currentIndex
          areStories
          areUnseenStories
        }
      }
    ''';
    final segmentType = describeEnum(SEGMENT_TYPE.ALL_POSITION_TYPES);
    final segmentTypeString =
        ''' tradePerformanceConnections(input:{segmentTypes:$segmentType}) {
      segmentType
            percentileConnection {
              percentile
            }
          }
          ''';

    var document = r'''
    query {
      relevantUserGet{
        user{
          userKey
          firstName
          lastName
          username
          profilePictureUrl
          authUserFollowInfo {
            followStatus
          }
            
          dailyPercentGain
          verifiedAt
          badgeType
          firstOrderAt
          authUserRelation {
            hideAt
            mutedAt
            savedAt
          }
    ''';
    document += segmentTypeString;
    document += storiesConnection;
    document += '''
          }
        points
        }
      }
    ''';
    return remoteProvider.query(
      document: document,
      variables: {},
      type: CacheType.feedUserStories,
      id: 'feedUserStories',
      callback: (info) {
        final data = info?['relevantUserGet'];

        if (data == null || (data is List && data.isEmpty)) {
          return callback([]);
        }

        if (data is List) {
          final storyListDefault =
              data.map((e) => RelevantUserRes.fromJson(e)).toList();

          final storyList = storyListDefault
              .map((e) => e.copyWith(points: e.points ?? 0))
              .toList();

          storyList.sort((a, b) {
            final unSeenA =
                a.user?.storiesConnection?.metaData?.areUnseenStories;
            final unSeenB =
                b.user?.storiesConnection?.metaData?.areUnseenStories;
            final storiesA = a.user?.storiesConnection?.metaData?.areStories;
            final storiesB = b.user?.storiesConnection?.metaData?.areStories;
            if (unSeenA == null ||
                unSeenB == null ||
                storiesA == null ||
                storiesB == null) return 0;

            if (unSeenA && unSeenB) {
              return b.points! - a.points!;
            } else if (unSeenA && !unSeenB) {
              return -1;
            } else if (!unSeenA && unSeenB) {
              return 1;
            } else {
              if (storiesA && storiesB) {
                return b.points! - a.points!;
              } else if (storiesA && !storiesB) {
                return -1;
              } else if (!storiesA && storiesB) {
                return 1;
              }
              return b.points! - a.points!;
            }
          });
          // final List<User> userList =
          //     List<User>.from(userItemList.map((i) => User.fromJson(i)));
          return callback(storyList);
        }
      },
      onError: onError,
      queryType: queryType,
    );
  }
}
