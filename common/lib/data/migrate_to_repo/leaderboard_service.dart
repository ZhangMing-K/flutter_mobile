import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../iris_common.dart';

class LeaderboardService extends GetxService {
  IGraphqlProvider iGraphqlProvider = Get.find();
  LeaderboardService();

  Future<Leaderboard?> leaderboardGet(
      {bool? mostRecent, int? limit, required HISTORICAL_SPAN span}) async {
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
                verifiedText
                firstOrderAt
                profilePictureUrl
                authUserFollowInfo{
                  followStatus
                }
                avatar {
                  avatarKey
                  avatarName
                  code
                  url
                }
              }
            }
          }
        }
      }
    ''';
    final queryOptions =
        iGraphqlProvider.createQueryOptions(document: document, variables: {
      'input': {
        'mostRecent': mostRecent,
        'limit': limit,
        'span': describeEnum(span)
      }
    });
    try {
      final res = await iGraphqlProvider.queryWithOptions(queryOptions);
      final data = res?.data;
      if (data == null) {
        return null;
      }
      return Leaderboard.fromJson(data['leaderboardGet']['leaderboard']);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
