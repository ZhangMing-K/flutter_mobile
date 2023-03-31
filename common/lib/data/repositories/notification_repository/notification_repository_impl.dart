import 'package:flutter/foundation.dart';
import 'package:graphql/client.dart';

import '../../../iris_common.dart';

class NotificationRepository implements INotificationRepository {
  final IGraphqlProvider remoteProvider;
  final BaseRepository repository;
  NotificationRepository({
    required this.remoteProvider,
    required this.repository,
  });

  @override
  Future<UserUserUpdateResponse?> changeUserNotifications({
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

    final options = remoteProvider
        .createMutationOptions(document: document, variables: {'input': input});
    try {
      final res = await remoteProvider.mutateWithOptions(options);

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
  Future<void> getFollowRequests({
    String? requestedFields,
    int limit = 10,
    String? cursor,
    QueryType queryType = QueryType.loadCache,
    required Function(dynamic data) callback,
    required Function(OperationException error) onError,
  }) {
    final input = {
      'limit': 10,
      'otherRequesting': 'PENDING',
      'orderBy': 'DESC'
    };
    if (cursor != null && cursor != '') {
      input['cursor'] = '"' + cursor + '"';
    }
    requestedFields ??= '''
      userKey
      followRequestsConnection (input: $input) {
        followRequests{
          ${NotificationGql.followingRequestedFields}
        }
        nextCursor
      }
    ''';

    var document = r'''
    query {
        whoami {
    ''';

    document += requestedFields;
    document += '}}';

    return repository.query(
        type: CacheType.followRequest,
        id: 'followRequest',
        queryType: queryType,
        document: document,
        callback: (data) {
          if (data == null || data!['whoami'] == null) {
            return callback({'list': null, 'cursor': ''});
          }
          final userData = data!['whoami'];
          final requests =
              userData['followRequestsConnection']['followRequests'];
          final cursor = userData['followRequestsConnection']['nextCursor'];
          final List<FollowRequest> requestsList = List<FollowRequest>.from(
              requests.map((i) => FollowRequest.fromJson(i)));
          return callback({'list': requestsList, 'cursor': cursor ?? ''});
        },
        onError: onError);
  }

  @override
  Future<void> getNotifications({
    String? requestedFields,
    int limit = 20,
    String? cursor = '',
    QueryType queryType = QueryType.loadCache,
    required Function(dynamic data) callback,
    required Function(OperationException error) onError,
  }) {
    var document = '''
    query whoAmi(\$input: UserNotificationsInput!){
        whoami {
          userKey
          firstName
          lastName
          notificationsConnection (input: \$input) {
            notifications {
              ${NotificationGql.requestedFields}
            }
            nextCursor
          }
    ''';

    document += '}}';

    final variables = {
      'input': {
        'limit': 10,
        'ignored': false,
      }
    };

    if (cursor != '') {
      variables['input']!['cursor'] = cursor!;
    }
    return repository.query(
      type: CacheType.notifications,
      id: 'id',
      document: document,
      callback: (data) {
        if (data == null || data['whoami'] == null) {
          return callback(const DataList(list: [], cursor: ''));
        }
        final notificationData =
            data['whoami']['notificationsConnection']['notifications'];
        final cursor = data['whoami']['notificationsConnection']['nextCursor'];
        final notifications = List<NotificationModel>.from(
            notificationData.map((i) => NotificationModel.fromJson(i)));
        callback(DataList(list: notifications, cursor: cursor ?? ''));
      },
      variables: variables,
      onError: onError,
      queryType: queryType,
    );
  }

  @override
  Future<bool> makeAllSeen() async {
    const document = r'''
      mutation{
        notificationChangeAllToSeen
      }
    ''';
    final mutationOptions =
        remoteProvider.createMutationOptions(document: document);
    try {
      await remoteProvider.mutateWithOptions(mutationOptions);
      return true;
    } catch (err) {
      debugPrint(err.toString());
      return false;
    }
  }

  @override
  Future<bool> muteAllPortfolios() async {
    const document = r'''
      mutation {
        globalUserRelationsUpdate(input:{ entityType:PORTFOLIO, notificationAmount:NONE }) {
          userRelations {
            userKey
            entityKey
            entityType
            notificationAmount
          }
        }
      }
    ''';
    final mutationOptions =
        remoteProvider.createMutationOptions(document: document);
    try {
      await remoteProvider.mutateWithOptions(mutationOptions);
      return true;
    } catch (err) {
      debugPrint(err.toString());
      return false;
    }
  }

  @override
  Future<bool> muteAllTradeNotifications() async {
    const document = r'''
    mutation globalUserUserUpdate($input: GlobalUserUserUpdateInput!) {
      globalUserUserUpdate(input:$input){
        userUsers {
          postNotificationAmount
          tradeNotificationAmount
        }
      }
    }
    ''';
    final input = <String, dynamic>{};

    input['postNotificationAmount'] =
        describeEnum(USER_POST_NOTIFICATION_AMOUNT.NONE);

    input['tradeNotificationAmount'] =
        describeEnum(USER_TRADE_NOTIFICATION_AMOUNT.NONE);

    final options = remoteProvider
        .createMutationOptions(document: document, variables: {'input': input});
    try {
      await remoteProvider.mutateWithOptions(options);

      return true;
    } catch (err) {
      debugPrint(err.toString());
      return false;
    }
  }

  // @override
  // Future<bool> muteAllTradeNotifications() async {
  //   const document = r'''
  //     mutation {
  //       globalUserUserUpdate(input:{ tradeNotificationAmount:NONE }) {
  //         userUsers {
  //           userUserKey
  //         }
  //       }
  //     }
  //   ''';
  //   final mutationOptions =
  //       remoteProvider.createMutationOptions(document: document);
  //   try {
  //     final data = await remoteProvider.mutateWithOptions(mutationOptions);
  //     debugPrint(data);
  //     return true;
  //   } catch (err) {
  //     debugPrint(err.toString());
  //     return false;
  //   }
  // }

  @override
  Future<void> setNotificationsAmount(
      {required bool isAll,
      bool? allAmount,
      bool? tradeNotificationAmount,
      bool? followNotificationAmount,
      bool? postNotificationAmount,
      bool? messagingNotificationAmount}) async {
    const document = r'''
      mutation userSettingsUpdate($input:UserSettingsUpdateInput!){
          userSettingsUpdate(input:$input){
            userSettings {
              userKey
              userSettingsKey
            }
          }
        }
    ''';

    final Map<String, dynamic> input = {
      'tradeNotificationAmount': isAll
          ? describeEnum(allAmount!
              ? TRADE_NOTIFICATION_AMOUNT.ALL
              : TRADE_NOTIFICATION_AMOUNT.NONE)
          : describeEnum(tradeNotificationAmount!
              ? TRADE_NOTIFICATION_AMOUNT.ALL
              : TRADE_NOTIFICATION_AMOUNT.NONE),
      'followNotificationAmount': isAll
          ? describeEnum(allAmount!
              ? FOLLOW_NOTIFICATION_AMOUNT.ALL
              : FOLLOW_NOTIFICATION_AMOUNT.NONE)
          : describeEnum(followNotificationAmount!
              ? FOLLOW_NOTIFICATION_AMOUNT.ALL
              : FOLLOW_NOTIFICATION_AMOUNT.NONE),
      'postNotificationAmount': isAll
          ? describeEnum(allAmount!
              ? POST_NOTIFICATION_AMOUNT.ALL
              : POST_NOTIFICATION_AMOUNT.NONE)
          : describeEnum(postNotificationAmount!
              ? POST_NOTIFICATION_AMOUNT.ALL
              : POST_NOTIFICATION_AMOUNT.NONE),
      'messagingNotificationAmount': isAll
          ? describeEnum(allAmount!
              ? MESSAGING_NOTIFICATION_AMOUNT.ALL
              : MESSAGING_NOTIFICATION_AMOUNT.NONE)
          : describeEnum(messagingNotificationAmount!
              ? MESSAGING_NOTIFICATION_AMOUNT.ALL
              : MESSAGING_NOTIFICATION_AMOUNT.NONE),
    };
    final mutationOptions = remoteProvider.createMutationOptions(
      document: document,
      variables: {'input': input},
    );

    await remoteProvider.mutateWithOptions(mutationOptions);
  }

  @override
  Future<UserSnooze> snoozeNotifications({
    required USER_SNOOZE_TYPE snoozeType,
    required Function(OperationException error) onError,
    int? fromTextKey,
    Function(dynamic data)? callback,
    int? fromUserKey,
  }) async {
    const document = r'''
      mutation snooze($input:UserSnoozeInput!){
          snooze(input:$input){
            userSnooze {
              userSnoozeKey
              snoozeType
              snoozeUntil
            }
          }
        }
    ''';

    final Map<String, dynamic> input = {
      'snoozeType': describeEnum(snoozeType),
    };

    if (fromTextKey != null) {
      input['fromTextKey'] = fromTextKey;
    }

    if (fromUserKey != null) {
      input['fromUserKey'] = fromUserKey;
    }

    final mutationOptions = remoteProvider.createMutationOptions(
      document: document,
      variables: {'input': input},
    );

    final res = await remoteProvider.mutateWithOptions(mutationOptions);
    final userSnoozeData = res.data!['snooze']['userSnooze'];
    return UserSnooze.fromJson(userSnoozeData);
  }

  @override
  Future<dynamic> unsnoozeNotifications({
    required USER_SNOOZE_TYPE snoozeType,
  }) async {
    const document = r'''
      mutation unsnooze($input:UserUnsnoozeInput!){
          unsnooze(input:$input){
            userSnooze {
              userSnoozeKey
              snoozeType
              snoozeUntil
            }
          }
        }
    ''';

    final Map<String, dynamic> input = {
      'snoozeType': describeEnum(snoozeType),
    };

    final mutationOptions = remoteProvider.createMutationOptions(
      document: document,
      variables: {'input': input},
    );

    final res = await remoteProvider.mutateWithOptions(mutationOptions);
    final userSnoozeData = res.data!['unsnooze']['userSnooze'];
    return UserSnooze.fromJson(userSnoozeData);
  }
}
