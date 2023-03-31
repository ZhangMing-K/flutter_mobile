import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:graphql/client.dart';
import 'package:http/http.dart' as http;

import '../../../iris_common.dart';

class ChatRepository implements IChatRepository {
  final IGraphqlProvider remoteProvider;

  final BaseRepository repository;
  final IAuthUserService authUserStore;

  ChatRepository(
      {required this.remoteProvider,
      required this.repository,
      required this.authUserStore});

  String get collectionFields {
    return '''
       collection{
          collectionKey
          collectionGuardedInfo {
            encryptionCode
          }
        }
        collectionRequests{
          collectionRequestKey
          portfolio {
            brokerName
            portfolioVisibilitySetting
            portfolioKey
            accountId
            connectionStatus
            authUserRelation {
              hideAt
              mutedAt
              savedAt
              notificationAmount
            }
            followStats{
              numberOfFollowers
            }
            authUserFollowInfo{
              followStatus
              watching
            }
            portfolioName
          }
        }
    ''';
  }

  String get getAccountFollowingRequest {
    return '''
      userKey
      firstName
      lastName
      username
      nbrUnreadMessages
      accountsFollowing{
        userKey
        firstName
        lastName
        username
        profilePictureUrl
        connectedBrokerNames
      }
    ''';
  }

  @override
  Future collectionAddEntities(
      {required int? collectionKey,
      required COLLECTION_REQUEST_ENTITY_TYPE entityType,
      required List<int?> entityKeys}) async {
    var document = r'''
    mutation collectionAddEntities($input: CollectionAddEntitiesInput!){
      collectionAddEntities(input: $input){
    ''';
    document += collectionFields;
    document += '}}';

    final Map input = {
      'collectionKey': collectionKey,
      'entityType': describeEnum(entityType),
      'entityKeys': [...entityKeys]
    };
    final queryOptions = remoteProvider
        .createQueryOptions(document: document, variables: {'input': input});
    try {
      final res = await remoteProvider.queryWithOptions(queryOptions);
      if (res?.hasException ?? false) {
        debugPrint(res?.exception.toString());
      }
      final response = res?.data;
      if (response == null) {
        return null;
      }
      final data = response['collectionAddEntities']['collectionRequests'];
      return data;
    } catch (err) {
      rethrow;
    }
  }

  @override
  StreamSubscription? collectionEvents({
    List<int>? collectionKeys,
    required List<COLLECTION_EVENT_TYPE> events,
    required ValueChanged<ChatSubscriptionData> callback,
    required Function? onError,
  }) {
    const document = r'''
      subscription collectionEvents($input: CollectionEventInput!){
        collectionEvents(input:$input) {
          eventType
          reaction {
            reactionKey
            userKey
            textKey
            reactionKind
          }
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
            authUserReaction{
              user{
                userKey
                firstName
                lastName
              }
              reactionKey
              userKey
              textKey
              reactionKind
            }
            numberOfReactions
            orderedCreatedAt
            createdAt
            textType
            userKey
            taggedFiles {
              url
            }
            user {
              userKey
              firstName
              lastName
              avatar {
                avatarKey
                url
                avatarName
                code
              }
              profilePictureUrl
            }
            sharedText {
              value
              orderedCreatedAt
              textType
              numberOfReactions
              authUserReaction{
                user{
                  userKey
                  firstName
                  lastName
                }
                reactionKey
                userKey
                textKey
                reactionKind
              }
              textKey
              order {
                symbol
                asset{
                  assetKey
                  symbol
                  name
                  currentPrice
                  pictureUrl
                }
                orderKey
                averagePrice
                orderKey
                averageBuyPrice
                averageSellPrice
                positionType
                optionType
                orderSide
                strikePrice
                expirationDate
                orderGroupUUID
                optionLegGroupId
                profitLoss
                profitLossPercent
                positionEffect
                orderStrategy
                strategyType
                closedAt
                openedAt
                placedAt
                fullfilledAt
                portfolio {
                  brokerName
                  authUserRelation {
                    mutedAt
                    hideAt
                    watchedAt
                  }
                }
              }
              user {
                userKey
                firstName
                lastName
                profilePictureUrl
                avatar {
                  avatarKey
                  code
                  avatarName
                }
                verifiedAt
                verifiedText
                firstOrderAt
                suspendedAt
              }
            }
          }
        }
      }
    ''';
    final optionEvents = [];
    for (var event in events) {
      optionEvents.add(describeEnum(event));
    }
    final subscriptionOptions = remoteProvider.createSubscriptionOptions(
      document: document,
      variables: {
        'input': {
          'collectionKeys': collectionKeys,
          'eventTypes': optionEvents,
        },
      },
      fetchPolicy: FetchPolicy.networkOnly,
    );

    final res = remoteProvider.subscribeWithOptions(subscriptionOptions);
    return res?.listen((event) {
      if (event.isLoading || event.data == null) {
        return;
      }

      if (event.hasException) {
        debugPrint('has exceptions: collectionEvents: ${event.exception}');
      }

      final collectionEvent = CollectionEventsResponse.fromJson(
          event.data?['collectionEvents'] ?? {});
      final eventType = collectionEvent.eventType;
      final collection = collectionEvent.collection;
      final collectionKey = collection?.collectionKey;
      var userKey = collectionEvent.userKey;

      final cacheData = repository.cache
          .getFromCache(CacheType.chatMessages, collectionKey.toString());
      final collectionText = collectionEvent.text;

      final text = collectionText?.copyWith(collection: collection);

      final reaction = collectionEvent.reaction;

      final collectionGet =
          CollectionsGetResponse.fromJson(cacheData?['collectionsGet']);

      final collections = collectionGet.collections;
      final messageData = collections
              ?.first.collectionGuardedInfo?.messagesConnection?.messages ??
          [];

      if (eventType == COLLECTION_EVENT_TYPE.TEXT_CREATED) {
        userKey = collectionText?.userKey;

        if (collections?.isNotEmpty ?? false) {
          messageData.insert(0, text!.copyWith(isEncrypted: true));
        }
      } else if (eventType == COLLECTION_EVENT_TYPE.REACTION_CREATED) {
        userKey = reaction!.userKey;
        final messageKey = collectionEvent.reaction?.textKey;
        if (collections?.isNotEmpty ?? false) {
          final isMe = userKey == authUserStore.loggedUser!.userKey;

          final message =
              messageData.firstWhereOrNull((e) => e.textKey! == messageKey!);
          final messageIndex = messageData.indexOf(message!);
          final currentReactionsNumber = message.numberOfReactions ?? 0;

          if (isMe) {
            messageData[messageIndex] = message.copyWith(
                authUserReaction: reaction,
                numberOfReactions: currentReactionsNumber + 1);
          } else {
            final currentReactions = message.reactions ?? [];
            currentReactions.add(reaction);
            messageData[messageIndex] = message.copyWith(
                reactions: currentReactions,
                numberOfReactions: currentReactionsNumber + 1);
          }
        }
      } else if (eventType == COLLECTION_EVENT_TYPE.REACTION_DELETED) {
        userKey = reaction!.userKey;
        final messageKey = collectionEvent.reaction?.textKey;
        if (collections?.isNotEmpty ?? false) {
          final isMe = userKey == authUserStore.loggedUser!.userKey;

          final message =
              messageData.firstWhereOrNull((e) => e.textKey! == messageKey!);
          final messageIndex = messageData.indexOf(message!);
          final currentReactionsNumber = message.numberOfReactions ?? 1;

          if (isMe) {
            messageData[messageIndex] = message.copyWith(
                authUserReaction: null,
                numberOfReactions: currentReactionsNumber - 1);
          } else {
            final currentReactions = message.reactions ?? [];
            currentReactions.removeWhere(
                (element) => element.reactionKey == reaction.reactionKey);
            messageData[messageIndex] = message.copyWith(
                reactions: currentReactions,
                numberOfReactions: currentReactionsNumber - 1);
          }
        }
      }

      final messages = messageData.map((e) => e.toJson()).toList();

      cacheData?['collectionsGet']?['collections']?[0]?['collectionGuardedInfo']
          ?['messagesConnection']?['messages'] = messages;

      repository.cache.putOnCache(CacheType.chatMessages,
          CacheEntry(id: collectionKey.toString(), data: cacheData));

      final subscriptionData = ChatSubscriptionData(
        collectionKey: collectionKey,
        eventType: eventType,
        text: text,
        userKey: userKey,
        reaction: reaction,
      );

      callback(subscriptionData);
    }, onError: onError);
  }

  @override
  Future collectionRemoveEntities(
      {required int? collectionKey,
      required COLLECTION_REQUEST_ENTITY_TYPE entityType,
      required List<int?> entityKeys}) async {
    var document = r'''
    mutation collectionRemoveEntities($input: CollectionRemoveEntitiesInput!){
      collectionRemoveEntities(input: $input){
    ''';

    document += collectionFields;
    document += '}}';

    final Map input = {
      'collectionKey': collectionKey,
      'entityType': describeEnum(entityType),
      'entityKeys': [...entityKeys]
    };

    final queryOptions = remoteProvider
        .createQueryOptions(document: document, variables: {'input': input});
    try {
      final res = await remoteProvider.queryWithOptions(queryOptions);
      if (res?.hasException ?? false) {
        debugPrint(res?.exception.toString());
      }
      final request = res?.data;
      if (request == null) {
        return null;
      }
      final data = request['collectionRemoveEntities']['collection'];
      debugPrint('data: $data');
      // return data.collectionRequestKey;
    } catch (err) {
      rethrow;
    }
  }

  @override
  Future<Collection?> createCollection({
    required String groupName,
    required String description,
    required List userKeys,
    required http.MultipartFile? pictureUpload,
  }) async {
    // create collection for group message
    const document = r'''
      mutation collectionCreate($input: CollectionCreateInput!, $pictureUpload: Upload){
        collectionCreate(input: $input, pictureUpload: $pictureUpload){
          collection{
            collectionGuardedInfo {
              encryptionCode
            }
            collectionKey
            collectionType
            name
            pictureUrl
            description
            currentUsers(input: {limit: 10, excludeAuthUser: true}){
              userKey
              firstName
              lastName
              profilePictureUrl
              avatar {
                avatarKey
                code
                avatarName
              }
            }
          }
        }
      }
    ''';

    final Map<String, dynamic> variables = {};
    variables['input'] = {
      'name': groupName,
      'description': description,
      'collectionType': describeEnum(COLLECTION_TYPE.GROUP_MESSAGE),
      'addedUserKeys': userKeys,
    };
    if (pictureUpload != null) {
      variables['pictureUpload'] = pictureUpload;
    }
    try {
      final mutationOptions = remoteProvider.createMutationOptions(
          document: document, variables: variables);
      final res = await remoteProvider.mutateWithOptions(mutationOptions);
      if (res.data == null) {
        throw 'Error did not receive data from api';
      }
      return Collection.fromJson(res.data!['collectionCreate']['collection']);
    } catch (err) {
      debugPrint('err: $err');
      return null;
    }
  }

  @override
  Future<TextModel?> deleteMessage({required int textKey}) async {
    const document = r'''
      mutation textDelete($input: TextDeleteInput){
        textDelete(input:$input){
          text{
            textKey
          }
        }
      }
    ''';

    final mutationOptions =
        remoteProvider.createMutationOptions(document: document, variables: {
      'input': {'textKey': textKey},
    });

    try {
      final res = await remoteProvider
          .mutateWithOptions(mutationOptions)
          .catchError((e) {});
      final text = res.data!['textDelete']['text'];
      return TextModel.fromJson(text);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  @override
  Future<User?> getAuthUser(
      {required String requestedFields,
      required FetchPolicy fetchPolicy}) async {
    if (requestedFields == '') {
      requestedFields = getAccountFollowingRequest;
    }
    var document = r'''
    query {
        whoami {
    ''';

    document += requestedFields;
    document += '}}';
    try {
      final queryOptions = remoteProvider.createQueryOptions(
          document: document, variables: {}, fetchPolicy: fetchPolicy);
      final res = await remoteProvider.queryWithOptions(queryOptions);
      final data = res?.data;
      if (data == null) {
        return null;
      }
      final userData = data['whoami'];
      return User.fromJson(userData);
    } catch (err) {
      rethrow;
    }
  }

  @override
  Future<void> getBasicCollectionDetails({
    required int collectionKey,
    QueryType queryType = QueryType.loadCache,
    required Function(Collection collection) callback,
    required Function(OperationException error) onError,
  }) async {
    const document = '''
    query collectionsGet(\$input: CollectionsGetInput!){
      collectionsGet(input:\$input){
        collections{
          numberOfCurrentUsers
          collectionKey
          collectionType
          name
          pictureUrl
          authUserRelation {
            notificationAmount
            seenAt
          }
          collectionGuardedInfo {
            encryptionCode
          }
          currentUsers(input:{limit: 3, excludeAuthUser: true}){
            userKey
            firstName
            lastName
            verifiedAt
            lastOnlineAt
            badgeType
            firstOrderAt
            profilePictureUrl
          }
        }
      }
    }
    ''';

    final Map input = {
      'collectionKeys': [collectionKey],
    };

    final variables = {'input': input};

    return repository.query(
      type: CacheType.chatUsers,
      id: collectionKey.toString(),
      document: document,
      queryType: queryType,
      variables: variables,
      callback: (info) {
        final data =
            CollectionsGetResponse.fromJson(info?['collectionsGet'] ?? {});
        final collections = data.collections;
        if (collections?.isEmpty ?? true) {
          return callback(const Collection());
        }
        callback(collections!.first);
      },
      onError: onError,
    );
  }

  @override
  Future<void> getCollectionOrders({
    int? collectionKey,
    int limit = 10,
    String? cursor,
    List<int>? userKeys,
    List<int>? assetKeys,
    QueryType queryType = QueryType.loadCache,
    required Function(DataList<TextModel> data) callback,
    required Function(OperationException error) onError,
  }) {
    final Map mInput = {};
    mInput['limit'] = limit;
    if (cursor != '') {
      mInput['cursor'] = '"' + cursor! + '"';
    }
    if (userKeys != null && userKeys.isNotEmpty) {
      mInput['userKeys'] = userKeys;
    }
    if (assetKeys != null && assetKeys.isNotEmpty) {
      mInput['assetKeys'] = assetKeys;
    }

    final document = '''
    query collectionsGet(\$input: CollectionsGetInput!){
      collectionsGet(input:\$input){
        collections{
          collectionGuardedInfo {
            ordersConnection (input: $mInput) {
              orders{
                $collectionOrderCollection
              }
              nextCursor
            }
          }
        }
      }
    }
    ''';

    final Map input = {
      'collectionKeys': [collectionKey!],
    };

    final variables = {'input': input};

    return repository.query(
      type: CacheType.chatOrders,
      id: collectionKey.toString(),
      document: document,
      queryType: queryType,
      variables: variables,
      callback: (info) {
        final data =
            CollectionsGetResponse.fromJson(info?['collectionsGet'] ?? {});

        final collections = data.collections;
        if (collections?.isEmpty ?? true) {
          return callback(const DataList(list: <TextModel>[], cursor: ''));
        }

        final collectionGuardedInfo = collections!.first.collectionGuardedInfo;
        final nextCursor = collectionGuardedInfo?.ordersConnection?.nextCursor;
        final dataCollections = collectionGuardedInfo?.ordersConnection?.orders;
        if (dataCollections != null &&
            dataCollections.isNotEmpty &&
            nextCursor != null) {
          final orders =
              dataCollections.map((i) => i.text ?? const TextModel()).toList();
          return callback(DataList(list: orders, cursor: nextCursor));
        } else {
          return callback(const DataList(list: <TextModel>[], cursor: ''));
        }
      },
      onError: onError,
    );
  }

  @override
  Future<void> getCollectionPortfolios({
    required int collectionKey,
    QueryType queryType = QueryType.loadCache,
    required Function(dynamic data) callback,
    required Function(OperationException error) onError,
  }) {
    const document = '''
    query collectionsGet(\$input: CollectionsGetInput!){
      collectionsGet(input:\$input){
        collections{
          collectionGuardedInfo {
            currentPortfoliosConnection{
              $portfolioSummaryGql
            }
          }
        }
      }
    }
    ''';

    final Map input = {
      'collectionKeys': [collectionKey],
    };
    final variables = {'input': input};

    return repository.query(
      type: CacheType.chatPortfolio,
      id: collectionKey.toString(),
      document: document,
      variables: variables,
      queryType: queryType,
      callback: (info) {
        final data =
            CollectionsGetResponse.fromJson(info?['collectionsGet'] ?? {});

        final collections = data.collections;
        if (collections?.isEmpty ?? true) {
          return callback(<Portfolio>[]);
        }
        final dataCollections = collections!.first.collectionGuardedInfo
            ?.currentPortfoliosConnection?.portfolios;

        return callback(dataCollections ?? <Portfolio>[]);
      },
      onError: onError,
    );
  }

  @override
  Future<void> getCollectionUsers({
    required List<int?> collectionKeys,
    List<int?>? userKeys,
    QueryType queryType = QueryType.loadCache,
    required Function(Collection data) callback,
    required Function(OperationException error) onError,
  }) async {
    var currentPortfoliosGql = '';
    if (userKeys != null && userKeys.isNotEmpty) {
      currentPortfoliosGql = '''
        collectionGuardedInfo {
          currentPortfoliosConnection {
            portfolios {
              portfolioName
            }
          }
        }
      ''';
    }
    final document = '''
    query collectionsGet(\$input: CollectionsGetInput!){
      collectionsGet(input:\$input){
        collections{
          numberOfCurrentUsers
          $currentPortfoliosGql
          nbrTradesToday
          authUserSimilarity {
            commonAssets(input: {limit:20}) {
              asset {
                assetKey
                assetType
                symbol
                name
                pictureUrl
              }
              nbrUsers
              nbrOrders
            }
          }
          collectionKey
          collectionType
          name
          pictureUrl
          authUserRelation {
            notificationAmount
            seenAt
          }
          currentUsers(input:{limit: 10, excludeAuthUser: true}){
            userKey
            firstName
            lastName
            verifiedAt
            lastOnlineAt
            badgeType
            firstOrderAt
            profilePictureUrl
          }
        }
      }
    }
    ''';

    final Map input = {
      'collectionKeys': collectionKeys,
    };

    final variables = {'input': input};

    return repository.query(
      type: CacheType.chatUsers,
      id: collectionKeys.toString(),
      document: document,
      queryType: queryType,
      variables: variables,
      callback: (data) {
        final collectionResponse =
            CollectionsGetResponse.fromJson(data?['collectionsGet'] ?? {});
        final collection = collectionResponse.collections;
        if (collection?.isEmpty ?? true) {
          return;
        }

        final dataCollection = collection!.first;

        return callback(dataCollection);
      },
      onError: onError,
    );
  }

  @override
  Future<void> getLastSeen({
    required int userKey,
    required QueryType type,
    required Function(dynamic data) callback,
    required Function(OperationException error) onError,
  }) {
    const document = r'''
    query getUserByKey($userKey: Int) {
        usersGet(input: {
          userKeys: [$userKey]
        }) {
          users {
            lastOnlineAt
          }
        }
    }  
    ''';

    final variables = {'userKey': userKey};
    return repository.query(
      document: document,
      variables: variables,
      type: CacheType.lastSeen,
      queryType: type,
      id: userKey.toString(),
      callback: (data) {
        callback(User.fromJson(data?['usersGet']?['users']?[0] ?? {}));
      },
      onError: onError,
    );
  }

  @override
  Future<void> getMessagesFromCollection({
    required int? collectionKey,
    int? limit = 10,
    String? cursor = '',
    QueryType queryType = QueryType.loadCache,
    required Function(CollectionsGetResponse data) callback,
    required Function(OperationException error) onError,
  }) async {
    final Map mInput = {};
    mInput['limit'] = limit;
    if (cursor != '') {
      mInput['cursor'] = '"' + cursor! + '"';
    }
    final document = '''
    query collectionsGet(\$input: CollectionsGetInput!){
      collectionsGet(input:\$input){
        collections{
          collectionGuardedInfo {
            encryptionCode
            messagesConnection (input: $mInput) {
              messages{
                $collectionMessageCollection
              }
              nextCursor
            }
          }
        }
      }
    }
    ''';

    final Map input = {
      'collectionKeys': [collectionKey],
    };

    final variables = {'input': input};
    return repository.query(
      type: CacheType.chatMessages,
      id: collectionKey.toString(),
      document: document,
      variables: variables,
      queryType: queryType,
      callback: (data) {
        final collection =
            CollectionsGetResponse.fromJson(data?['collectionsGet'] ?? {});
        return callback(collection);
      },
      onError: onError,
    );
  }

  @override
  Future markSeen({
    required USER_RELATION_ENTITY_TYPE entityType,
    required int entityKeys,
    required bool seen,
    RELATION_LOCATION? relationLocation,
  }) async {
    const document = r'''
      mutation userRelationsUpdate($input:UserRelationsUpdateInput!){
          userRelationsUpdate(input:$input){
            userRelations {
              userRelationKey
              mutedAt
              hideAt
              relationLocation
              seenAt
              savedAt
              notificationAmount
            }
          }
        }
    ''';

    final Map<String, dynamic> input = {
      'entityType': describeEnum(entityType),
      'entityKeys': [entityKeys],
    };

    input['seen'] = seen;

    if (relationLocation != null) {
      input['relationLocation'] = describeEnum(relationLocation);
    }

    final mutationOptions = remoteProvider.createMutationOptions(
      document: document,
      variables: {'input': input},
    );
    try {
      final res = await remoteProvider.mutateWithOptions(mutationOptions);

      final relationData = res.data!['userRelationsUpdate']['userRelations'][0];
      return UserRelation.fromJson(relationData);
    } catch (err) {
      debugPrint(err.toString());
      return null;
    }
  }

  @override
  Future<Collection?> privateMessageCollectionFindOrCreate({
    // create collection for private message
    required int? userKey,
  }) async {
    const document = r'''
    query privateMessageCollectionFindOrCreate($input: CollectionFindOrCreateInput!){
      privateMessageCollectionFindOrCreate(input:$input){
        collection{
          collectionKey
          authUserRelation {	
            notificationAmount	
          }
          collectionGuardedInfo {
            encryptionCode
          }
          collectionType
          currentUsers(input:{limit: 1, excludeAuthUser: true}){
            userKey
            firstName
            lastName
            verifiedAt
            lastOnlineAt
            verifiedText
            firstOrderAt
            profilePictureUrl
            avatar {
              avatarKey
              code
              avatarName
            }
          }
        }
      }
    }
    ''';

    final Map input = {
      'userKey': userKey,
    };
    final queryOptions = remoteProvider
        .createQueryOptions(document: document, variables: {'input': input});
    try {
      final res = await remoteProvider.queryWithOptions(queryOptions);
      if (res?.hasException ?? false) {
        debugPrint(res?.exception.toString());
      }
      final data = res?.data;
      if (data == null) {
        return null;
      }
      final collectionData =
          data['privateMessageCollectionFindOrCreate']['collection'];
      return Collection.fromJson(collectionData);
    } catch (err) {
      rethrow;
    }
  }

  @override
  Future<TextModel> sendMessage({
    required TEXT_TYPE? textType,
    String? value,
    int? parentKey,
    Giff? giff,
    required bool isEncrypted,
    List<http.MultipartFile>? fileUploads,
    int? collectionKey,
    int? sharedTextKey,
  }) async {
    const document = '''
      mutation textCreateV2(\$input: TextCreateV2Input!, \$fileUploads: [Upload]){
        textCreateV2(input:\$input, fileUploads: \$fileUploads){
          text{
            ${TextGql.feed}
            sharedText {
              value
              orderedCreatedAt
              textKey
              order {
                symbol
                asset{
                  assetKey
                  symbol
                  name
                  currentPrice
                  pictureUrl
                }
                orderKey
                averagePrice
                orderKey
                averageBuyPrice
                averageSellPrice
                positionType
                optionType
                orderSide
                strikePrice
                expirationDate
                orderGroupUUID
                optionLegGroupId
                profitLoss
                profitLossPercent
                positionEffect
                orderStrategy
                strategyType
                closedAt
                openedAt
                placedAt
                fullfilledAt
                portfolio {
                  brokerName
                  authUserRelation {
                    mutedAt
                    hideAt
                    watchedAt
                  }
                }
              }
              user {
                userKey
                firstName
                lastName
                profilePictureUrl
                avatar {
                  avatarKey
                  code
                  avatarName
                }
                verifiedAt
                verifiedText
                firstOrderAt
                suspendedAt
              }
            }
            collection {
              collectionKey
              collectionGuardedInfo {
                encryptionCode
              }
            }
          }
        }
      }
    ''';
    final Map<String, dynamic> variables = {};
    final Map<dynamic, dynamic> input = {'textType': describeEnum(textType!)};

    input['isEncrypted'] = isEncrypted;

    if (value != null) {
      input['value'] = value;
    }
    if (parentKey != null) {
      input['parentKey'] = parentKey;
    }
    if (collectionKey != null) {
      input['collectionKey'] = collectionKey;
    }
    if (sharedTextKey != null) {
      input['sharedTextKey'] = sharedTextKey;
    }

    if (giff != null) {
      input['giffInfo'] = {
        'giffSource': describeEnum(giff.giffSource!),
        'remoteId': giff.remoteId,
        'url': giff.url
      };
    }
    if (fileUploads != null && fileUploads.isNotEmpty) {
      variables['fileUploads'] = fileUploads;
    }
    variables['input'] = input;
    final mutationOptions = remoteProvider.createMutationOptions(
        document: document,
        variables: variables,
        fetchPolicy: FetchPolicy.noCache);
    try {
      final res = await remoteProvider.mutateWithOptions(mutationOptions);
      final TextModel text =
          TextModel.fromJson(res.data!['textCreateV2']['text']);
      return text;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  void setNotificationSettings(
      {required USER_RELATION_NOTIFICATION_AMOUNT amountType,
      required List<int> collectionKeys}) async {
    const document = '''
      mutation userRelationsUpdate(\$input: UserRelationsUpdateInput!){
        userRelationsUpdate(input:\$input){
          userRelations {
            userRelationKey
            notificationAmount
          }
        }
      }
    ''';
    final Map<String, dynamic> variables = {};
    final Map<dynamic, dynamic> input = {
      'notificationAmount': describeEnum(amountType)
    };

    input['entityType'] = describeEnum(USER_RELATION_ENTITY_TYPE.COLLECTION);
    input['entityKeys'] = collectionKeys;

    variables['input'] = input;
    try {
      final mutationOptions = remoteProvider.createMutationOptions(
          document: document,
          variables: variables,
          fetchPolicy: FetchPolicy.noCache);
      final res = await remoteProvider.mutateWithOptions(mutationOptions);
      res.data!['userRelationsUpdate']['userRelations'][0]
          ['notificationAmount'];
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> updateGroupInfo({
    required int? collectionKey,
    required String groupName,
    http.MultipartFile? groupPic,
    required String description,
    required Function(dynamic data) callback,
    required Function(OperationException error) onError,
  }) async {
    const document = r'''
    mutation collectionUpdate($input: CollectionUpdateInput!, $pictureUpload: Upload){
      collectionUpdate(input: $input, pictureUpload: $pictureUpload){
        collection{
          name
          description
          pictureUrl
          collectionKey
          collectionGuardedInfo {
            encryptionCode
          }
        }
      }
    }
    ''';
    final Map<String, dynamic> variables = {};
    variables['input'] = {
      'name': groupName,
      'description': description,
      'collectionKey': collectionKey,
    };
    if (groupPic != null) {
      variables['pictureUpload'] = groupPic;
    }

    final mutationOptions = remoteProvider.createMutationOptions(
        document: document, variables: variables);
    final res = await remoteProvider.mutateWithOptions(mutationOptions);

    if (res.hasException) {
      onError(res.exception!);
      return;
    }
    if (res.data == null) {
      throw 'Error did not receive data from api';
    }
    callback(Collection.fromJson(res.data!['collectionUpdate']['collection']));
  }

  @override
  Future<bool?>? userTyping({int? collectionKey}) async {
    const document = r'''
      mutation collectionTyping($input: CollectionTypingInput!){
        collectionTyping(input: $input){
          success
        }
      }
    ''';

    final dynamic variables = {
      'input': {
        'collectionKey': collectionKey,
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
}
