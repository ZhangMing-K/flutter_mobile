import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:graphql/client.dart';

import '../../../iris_common.dart';

class InboxRepository implements IInboxRepository {
  final IGraphqlProvider remoteProvider;

  final BaseRepository repository;
  InboxRepository({required this.remoteProvider, required this.repository});

  @override
  StreamSubscription? collectionEvents({
    List<int>? collectionKeys,
    List<COLLECTION_EVENT_TYPE>? events,
    required ValueChanged<InboxSubscriptionData> callback,
    required Function? onError,
  }) {
    const document = r'''
      subscription collectionEvents($input: CollectionEventInput!){
        collectionEvents(input:$input) {
          eventType
          userKey
          collectionKey
          collection {
            collectionKey
            collectionType
            name
            pictureUrl
            collectionGuardedInfo {
              encryptionCode
            }
          }
          text {
            textKey
            value
            orderedCreatedAt
            createdAt
            userKey
            isEncrypted
            user {
              userKey
              firstName
              lastName
              lastOnlineAt
              badgeType
              profilePictureUrl
            }
          }
        }
      }
    ''';
    final optionEvents = events!.map((event) => describeEnum(event)).toList();
    final subscriptionOptions = remoteProvider
        .createSubscriptionOptions(document: document, variables: {
      'input': {
        'collectionKeys': collectionKeys,
        'eventTypes': optionEvents,
      }
    });

    final res = remoteProvider.subscribeWithOptions(subscriptionOptions);

    return res!.listen((event) {
      if (event.isLoading || event.data == null) {
        return;
      }

      if (event.hasException) {
        debugPrint('has exceptions: ${event.exception}');
      }

      final collectionEvent = event.data!['collectionEvents'];
      final eventType =
          (collectionEvent['eventType'] as String).collectionTypeFromString();
      final collection = Collection.fromJson(collectionEvent['collection']);
      final collectionKey = collection.collectionKey;
      final userKey = collectionEvent['userKey'];

      // final key = CacheType.inbox.fromId(RELATION_LOCATION.PRIMARY.toString());
      // final cacheData = repository.cache.read(key);

      final text = TextModel.fromJson(collectionEvent['text'] ?? {})
          .copyWith(collection: collection);

      //  if (eventType == COLLECTION_EVENT_TYPE.TEXT_CREATED) {
      //  final messageData = cacheData?['messagesGetRecent']?['messages'];
      //  if(messageData != null){
      //  final messages =
      //             List<TextModel>.from(messageData.map((i) => TextModel.fromJson(i)));

      final subscriptionData = InboxSubscriptionData(
        collectionKey: collectionKey,
        eventType: eventType,
        text: text,
        userKey: userKey,
      );

      callback(subscriptionData);
    }, onError: onError);
  }

  @override
  Future<void> loadPrimary({
    int limit = 10,
    required String cursor,
    RELATION_LOCATION? relationLocation = RELATION_LOCATION.PRIMARY,
    QueryType queryType = QueryType.loadCache,
    required Function(MessagesGetRecentResponse data) callback,
    required Function(OperationException error) onError,
  }) {
    return loadRecentMessages(
      limit: limit,
      cursor: cursor,
      relationLocation: relationLocation!,
      callback: callback,
      onError: onError,
      queryType: queryType,
    );
  }

  Future<void> loadRecentMessages({
    int limit = 20,
    required String cursor,
    required RELATION_LOCATION relationLocation,
    QueryType queryType = QueryType.loadCache,
    required Function(MessagesGetRecentResponse data) callback,
    required Function(OperationException error) onError,
  }) {
    const document = '''
    query messagesGetRecent(\$input: MessagesGetRecentInput!){
      messagesGetRecent(input:\$input){
        ${MessageGql.recentMessages}
      }
    }
    ''';

    final Map input = {
      'limit': limit,
      'cursor': cursor,
      'relationLocation': describeEnum(relationLocation)
    };

    final variables = {'input': input};

    return repository.query(
      type: CacheType.inbox,
      // id: '$relationLocation',
      id: cursor,
      document: document,
      variables: variables,
      queryType: queryType,
      callback: (data) {
        final response = MessagesGetRecentResponse.fromJson(
            data?['messagesGetRecent'] ?? {});

        return callback(response);
      },
      onError: onError,
    );
  }

  @override
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
            verifiedText
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
      variables['input']['context'] = {
        'contextType': variables['input']['context']['contextType'],
        'contextKey': contextKey,
      };
    }

    if (excludeUserKeys != null && excludeUserKeys.isNotEmpty) {
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
}
