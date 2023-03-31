import 'package:flutter/foundation.dart';
import 'package:graphql/client.dart';

import '../../../iris_common.dart';

class LeaderboardRepository implements ILeaderboardRepository {
  final IGraphqlProvider remoteProvider;
  final BaseRepository repository;
  LeaderboardRepository({
    required this.remoteProvider,
    required this.repository,
  });

  @override
  Future<void> getGlobalLeaderboard({
    bool? mostRecent,
    int? limit,
    HISTORICAL_SPAN? span,
    QueryType queryType = QueryType.loadCache,
    required Function(bool isLocal, HISTORICAL_SPAN span, dynamic data)
        callback,
    required Function(OperationException error) onError,
  }) async {
    const document = r'''
      query leaderboardGet($input: LeaderboardGetInput){
        leaderboardGet(input:$input){
          leaderboard{
            instances{
              snapshot {
                dayPercent
                weekPercent
                threeMonthPercent
                yearPercent
                lastUpdatedAt
              }
              portfolio{
                portfolioKey
                portfolioName
                brokerName
                portfolioVisibilitySetting
                accountId
                connectionStatus
                authUserFollowInfo{
                  followStatus
                }
                user{
                  userKey
                  firstName
                  lastName
                  verifiedAt
                  badgeType
                  firstOrderAt
                  profilePictureUrl
                  authUserFollowInfo{
                    followStatus
                  }
                }
              }
            }
          }
        }
      }
    ''';
    final variables = {
      'input': {
        'mostRecent': mostRecent,
        'limit': limit,
        'span': describeEnum(span!)
      }
    };
    return repository.query(
      type: CacheType.globalLeaderboard,
      id: 'globalLeaderboard' + describeEnum(span),
      document: document,
      variables: variables,
      queryType: queryType,
      callback: (data) {
        if (data != null) {
          final leaderboardGet = data['leaderboardGet'];
          if (leaderboardGet != null) {
            final leaderboardListData = leaderboardGet['leaderboard'];
            final leaderBoard = Leaderboard.fromJson(leaderboardListData);
            final List<LeaderboardInstance> instances = leaderBoard.instances!;
            final List<Portfolio> globalLeadboardPortfoliosList =
                List<Portfolio>.from(instances
                    .map((e) => e.portfolio!.copyWith(snapshot: e.snapshot)));
            callback(false, span, globalLeadboardPortfoliosList);
          } else {
            return callback(false, span, <Portfolio>[]);
          }
        } else {
          return callback(false, span, <Portfolio>[]);
        }
      },
      onError: onError,
    );
  }

  @override
  Future<void> getPortfolios({
    int? offset,
    HISTORICAL_SPAN? orderBy,
    QueryType queryType = QueryType.loadCache,
    required Function(bool isLocal, HISTORICAL_SPAN span, dynamic data)
        callback,
    required Function(OperationException error) onError,
  }) async {
    const document = '''
      query portfolioSearch(\$input: PortfolioSearchInput!){
        portfolioSearch(input: \$input){
          $portfolioSummaryGql
        }
      }
    ''';

    final variables = {
      'input': {
        'limit': 10,
        'offset': offset,
        'orderBy': describeEnum(orderBy!)
      }
    };

    return repository.query(
      type: CacheType.localLeaderboard,
      id: 'localLeaderboard' + describeEnum(orderBy),
      document: document,
      variables: variables,
      queryType: queryType,
      callback: (data) {
        if (data != null) {
          final portfolioSearch = data['portfolioSearch'];
          if (portfolioSearch != null) {
            final portfoliosListData = portfolioSearch['portfolios'];
            final List<Portfolio> portfoliosList = List<Portfolio>.from(
                portfoliosListData.map((i) => Portfolio.fromJson(i)));
            callback(true, orderBy, portfoliosList);
          } else {
            return callback(true, orderBy, <Portfolio>[]);
          }
        } else {
          return callback(true, orderBy, <Portfolio>[]);
        }
      },
      onError: onError,
    );
  }
}
