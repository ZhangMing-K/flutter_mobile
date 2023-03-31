import 'package:flutter/foundation.dart';
import 'package:graphql/client.dart';

import '../../../iris_common.dart';

class TopMoversRepository implements ITopMoversRepository {
  final IGraphqlProvider remoteProvider;
  TopMoversRepository({
    required this.remoteProvider,
  });

  @override
  Repository<Leaderboard?> getTopMovers(
      {bool? mostRecent, int? limit, HISTORICAL_SPAN? span}) {
    const document = r'''
      query leaderboardGet($input: LeaderboardGetInput){
        leaderboardGet(input:$input){
          leaderboard{
            instances{
              portfolio{
                portfolioKey
                portfolioName
                brokerName
                authUserFollowInfo{
                  followStatus
                }
              }
              percentile
              rankNumber
              snapshot{
                dayPercent
                weekPercent
                monthPercent
                threeMonthPercent
                yearPercent
                lastUpdatedAt
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
    ''';
    final dataFromRemote = Future<Leaderboard?>(() async {
      final queryOptions = remoteProvider.createQueryOptions(
          document: document,
          variables: {
            'input': {
              'mostRecent': mostRecent,
              'limit': limit,
              'span': describeEnum(span!)
            }
          },
          fetchPolicy: FetchPolicy.networkOnly);
      final res = await remoteProvider.queryWithOptions(queryOptions);
      final data = res?.data;
      if (data == null) {
        return null;
      }
      final leaderBoard =
          Leaderboard.fromJson(data['leaderboardGet']['leaderboard']);
      return leaderBoard;
    });

    final dataFromLocal = Future<Leaderboard?>(() async {
      final queryOptions = remoteProvider.createQueryOptions(
        document: document,
        variables: {
          'input': {
            'mostRecent': mostRecent,
            'limit': limit,
            'span': describeEnum(span!)
          }
        },
        fetchPolicy: FetchPolicy.cacheFirst,
      );
      final res = await remoteProvider.queryWithOptions(queryOptions);
      if (res == null ||
          res.data == null ||
          res.data!['leaderboardGet'] == null) {
        return null;
      }
      final leaderBoard =
          Leaderboard.fromJson(res.data!['leaderboardGet']['leaderboard']);
      return leaderBoard;
    });

    return Repository(local: dataFromLocal, remote: dataFromRemote);
  }
}
