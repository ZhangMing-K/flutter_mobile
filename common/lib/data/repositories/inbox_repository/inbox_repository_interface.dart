import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:graphql/client.dart';

import '../../../iris_common.dart';

abstract class IInboxRepository {
  StreamSubscription? collectionEvents({
    List<int>? collectionKeys,
    List<COLLECTION_EVENT_TYPE>? events,
    required ValueChanged<InboxSubscriptionData> callback,
    required ValueChanged onError,
  });

  Future<void> loadPrimary({
    int limit = 10,
    required String cursor,
    RELATION_LOCATION? relationLocation,
    QueryType queryType = QueryType.loadCache,
    required Function(MessagesGetRecentResponse data) callback,
    required Function(OperationException error) onError,
  });

  Future<void> relevantUsersSearch({
    String? searchText = '',
    int limit = 15,
    int? offset = 0,
    bool? excludeAuthUser = true,
    List<int>? excludeUserKeys,
    CONTEXT_TYPE? contextType = CONTEXT_TYPE.FOLLOWING,
    int? contextKey,
    QueryType queryType = QueryType.loadCache,
    required Function(List<User> data) callback,
    required Function(OperationException error) onError,
  });
}

class InboxSubscriptionData {
  final COLLECTION_EVENT_TYPE? eventType;
  final TextModel? text;
  final int? collectionKey;
  final int? userKey;

  const InboxSubscriptionData({
    required this.eventType,
    required this.text,
    required this.collectionKey,
    required this.userKey,
  });
}
