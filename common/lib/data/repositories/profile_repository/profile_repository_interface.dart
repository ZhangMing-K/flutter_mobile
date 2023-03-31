import 'package:graphql/client.dart';

import '../../../iris_common.dart';

class UserProfileFeedData<T> {
  final List<T> list;
  final TEXT_TYPE type;
  const UserProfileFeedData({required this.list, required this.type});
}

abstract class IProfileRepository {
  Future<UserUserUpdateResponse?> changeNotifications({
    USER_POST_NOTIFICATION_AMOUNT? postNotificationAmount,
    USER_TRADE_NOTIFICATION_AMOUNT? tradeNotificationAmount,
    required int userKey,
  });

  Future<User> changePrivacy({
    required TRADE_STAT_VISIBILITY tradeStatVisibility,
  });

  Future<void> getGoldConnection({
    int? userKey,
    required QueryType queryType,
    required String requestedFields,
    required Function(GoldConnection? data) callback,
    required Function(OperationException error) onError,
  });

  Future<void> positionTypeSummaryGet({
    required PositionTypeSummaryGetInput input,
    required Function(PositionTypeSummaryGetResponse data) callback,
    required Function(OperationException error) onError,
    QueryType queryType = QueryType.loadCache,
  });

  Future<void> positionsSummaryGet({
    required PositionsSummaryGetInput input,
    required Function(PositionsSummaryGetResponse data) callback,
    required Function(OperationException error) onError,
    QueryType queryType = QueryType.loadCache,
  });

  Future<void> getPortfolios({
    required int userKey,
    required QueryType queryType,
    required Function(List<Portfolio> data) callback,
    required Function(OperationException error) onError,
  });

  Future<void> getWatchListForUser({
    required int userKey,
    required QueryType queryType,
    required Function(List<Asset> data) callback,
    required Function(OperationException error) onError,
  });

  Future<void> getPostsOrOrders({
    int offset = 0,
    int? userKey,
    TEXT_TYPE? type,
    required QueryType queryType,
    required Function(UserProfileFeedData<TextModel> data) callback,
    required Function(OperationException error) onError,
  });

  Future<void> getUserByKey({
    required int userKey,
    required Function(UsersGetResponse data) callback,
    required String userGql,
    required Function(OperationException error) onError,
    QueryType queryType,
  });

  Future<void> storiesUserGet({
    required int limit,
    required Function(List<RelevantUserRes> data) callback,
    required Function(OperationException error) onError,
    QueryType queryType,
  });
}
