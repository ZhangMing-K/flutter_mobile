import 'package:graphql/client.dart';

import '../../../iris_common.dart';

abstract class INotificationRepository {
  Future<UserUserUpdateResponse?> changeUserNotifications({
    USER_POST_NOTIFICATION_AMOUNT? postNotificationAmount,
    USER_TRADE_NOTIFICATION_AMOUNT? tradeNotificationAmount,
    required int userKey,
  });
  Future<void> getFollowRequests({
    String? requestedFields,
    int limit = 10,
    String? cursor,
    QueryType queryType = QueryType.loadCache,
    required Function(dynamic data) callback,
    required Function(OperationException error) onError,
  });
  Future<void> getNotifications({
    String? requestedFields,
    int limit = 10,
    String? cursor,
    QueryType queryType = QueryType.loadCache,
    required Function(dynamic data) callback,
    required Function(OperationException error) onError,
  });
  Future<bool> makeAllSeen();
  Future<bool> muteAllPortfolios();
  Future<bool> muteAllTradeNotifications();
  Future<dynamic> setNotificationsAmount(
      {required bool isAll,
      bool? allAmount,
      bool? tradeNotificationAmount,
      bool? followNotificationAmount,
      bool? postNotificationAmount,
      bool? messagingNotificationAmount});

  Future<dynamic> snoozeNotifications({
    Function(dynamic data) callback,
    required Function(OperationException error) onError,
    required USER_SNOOZE_TYPE snoozeType,
    int? fromTextKey,
    int? fromUserKey,
  });
  Future<dynamic> unsnoozeNotifications({
    required USER_SNOOZE_TYPE snoozeType,
  });
}
