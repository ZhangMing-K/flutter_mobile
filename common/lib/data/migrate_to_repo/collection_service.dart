import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:graphql/client.dart';
import 'package:http/http.dart' as http;

import '../../iris_common.dart';

class CollectionService extends GetxService {
  final IGraphqlProvider iGraphqlProvider;
  CollectionService({required this.iGraphqlProvider});

  collectionAddEntities(
      {required int? collectionKey,
      required COLLECTION_REQUEST_ENTITY_TYPE entityType,
      required List<int?> entityKeys}) async {
    var document = r'''
    mutation collectionAddEntities($input: CollectionAddEntitiesInput!){
      collectionAddEntities(input: $input){
    ''';
    document += collectionFields();
    document += '}}';

    final Map input = {
      'collectionKey': collectionKey,
      'entityType': describeEnum(entityType),
      'entityKeys': [...entityKeys]
    };
    final queryOptions = iGraphqlProvider
        .createQueryOptions(document: document, variables: {'input': input});
    try {
      final res = await iGraphqlProvider.queryWithOptions(queryOptions);
      if (res?.hasException ?? false) {
        debugPrint(res?.exception.toString());
      }
      final response = res?.data;
      if (response == null) {
        return null;
      }
      final data = response['collectionAddEntities']['collectionRequests'];
      return data.collectionRequests;
    } catch (err) {
      rethrow;
    }
  }

  Stream<QueryResult>? collectionEvents(
      {List<int?>? collectionKeys,
      required List<COLLECTION_EVENT_TYPE> events}) {
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
          }
        }
      }
    ''';
    final optionEvents = [];
    for (var event in events) {
      optionEvents.add(describeEnum(event));
    }
    final subscriptionOptions = iGraphqlProvider
        .createSubscriptionOptions(document: document, variables: {
      'input': {'collectionKeys': collectionKeys, 'eventTypes': optionEvents}
    });
    try {
      final res = iGraphqlProvider.subscribeWithOptions(subscriptionOptions);
      return res;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  collectionFields() {
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

  collectionRemoveEntities(
      {required int? collectionKey,
      required COLLECTION_REQUEST_ENTITY_TYPE entityType,
      required List<int?> entityKeys}) async {
    var document = r'''
    mutation collectionRemoveEntities($input: CollectionRemoveEntitiesInput!){
      collectionRemoveEntities(input: $input){
    ''';

    document += collectionFields();
    document += '}}';

    final Map input = {
      'collectionKey': collectionKey,
      'entityType': describeEnum(entityType),
      'entityKeys': [...entityKeys]
    };

    final queryOptions = iGraphqlProvider
        .createQueryOptions(document: document, variables: {'input': input});
    try {
      final res = await iGraphqlProvider.queryWithOptions(queryOptions);
      if (res?.hasException ?? false) {
        debugPrint(res?.exception.toString());
      }
      final request = res?.data;
      if (request == null) {
        return null;
      }
      final data = request['collectionRemoveEntities']['collection'];
      return data.collectionRequestKey;
    } catch (err) {
      rethrow;
    }
  }

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
      final mutationOptions = iGraphqlProvider.createMutationOptions(
          document: document, variables: variables);
      final res = await iGraphqlProvider.mutateWithOptions(mutationOptions);
      if (res.data == null) {
        throw 'Error did not receive data from api';
      }
      return Collection.fromJson(res.data!['collectionCreate']['collection']);
    } catch (err) {
      debugPrint('err: $err');
      return null;
    }
  }

  Future<List<Collection>> getCollections({
    // get collections for inbox screen
    required List<int?> collectionKeys,
    int? offset,
  }) async {
    final document = '''
    query collectionsGet(\$input: CollectionsGetInput!){
      collectionsGet(input:\$input){
        collections{
          collectionKey
          collectionType
          name
          currentPortfolios(input:{limit:10, offset:$offset}) {
            user {
              userKey
              firstName
              lastName
              profilePictureUrl
            }
            snapshot(input: {mostRecent: true}){
              dayPercent
              weekPercent
              threeMonthPercent
              yearPercent
              allPercent
              lastUpdatedAt
            }
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
          currentUsers(input:{limit: 10, excludeAuthUser: true}){
            userKey
            firstName
            lastName
            verifiedAt
            verifiedText
            firstOrderAt
          }
        }
      }
    }
    ''';

    final Map input = {
      'collectionKeys': collectionKeys,
    };
    final queryOptions = iGraphqlProvider
        .createQueryOptions(document: document, variables: {'input': input});
    try {
      final res = await iGraphqlProvider.queryWithOptions(queryOptions);
      if (res?.hasException ?? false) {
        debugPrint(res?.exception.toString());
      }
      final data = res?.data;
      if (data == null) {
        return <Collection>[];
      }
      final dataCollection = data['collectionsGet']['collections'];
      final List<Collection> collections = List<Collection>.from(
          dataCollection.map((i) => Collection.fromJson(i)));
      return collections;
    } catch (err) {
      debugPrint(err.toString());
      return <Collection>[];
    }
  }

  Future<Collection?> getCollectionUsers({
    // get collections for inbox screen
    required List<int?> collectionKeys,
  }) async {
    const document = '''
    query collectionsGet(\$input: CollectionsGetInput!){
      collectionsGet(input:\$input){
        collections{
          collectionKey
          collectionType
          name
          pictureUrl
          currentUsers(input:{limit: 10, excludeAuthUser: true}){
            userKey
            firstName
            lastName
            verifiedAt
            verifiedText
            firstOrderAt
            avatar {
              avatarKey
              avatarName
              code
            }
            profilePictureUrl
          }
        }
      }
    }
    ''';

    final Map input = {
      'collectionKeys': collectionKeys,
    };
    final queryOptions = iGraphqlProvider
        .createQueryOptions(document: document, variables: {'input': input});
    try {
      final res = await iGraphqlProvider.queryWithOptions(queryOptions);
      if (res?.hasException ?? false) {
        debugPrint(res?.exception.toString());
      }
      final data = res?.data;
      if (data == null) {
        return null;
      }
      final dataCollection = data['collectionsGet']['collections'][0];
      return Collection.fromJson(dataCollection);
    } catch (err) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> getMessagesFromCollection({
    // get initial messages from collection for message view
    required int? collectionKey,
    int? offset,
    String? cursor = '',
  }) async {
    final Map mInput = {};
    mInput['limit'] = 10;
    if (cursor != '') {
      mInput['cursor'] = '"${cursor!}"';
    }
    final document = '''
    query collectionsGet(\$input: CollectionsGetInput!){
      collectionsGet(input:\$input){
        collections{
          collectionGuardedInfo {
            encryptionCode
            messagesConnection (input: $mInput) {
              messages{
                textKey
                createdAt
                orderedCreatedAt
                value
                taggedFiles {
                  fileKey
                  url
                  fileType
                }
                taggedGiffs {
                  giffKey
                  remoteId
                  url
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
    final queryOptions = iGraphqlProvider
        .createQueryOptions(document: document, variables: {'input': input});
    try {
      final res = await iGraphqlProvider.queryWithOptions(queryOptions);
      if (res?.hasException ?? false) {
        debugPrint(res?.exception.toString());
      }

      final data = res?.data;
      if (data == null) {
        return null;
      }

      final collectionGuardedInfo =
          data['collectionsGet']['collections'][0]['collectionGuardedInfo'];
      // final encryptionCode = collectionGuardedInfo['encryptionCode'];
      final nextCursor =
          collectionGuardedInfo['messagesConnection']['nextCursor'];

      final dataCollections =
          collectionGuardedInfo['messagesConnection']['messages'];
      final List<TextModel> messages = List<TextModel>.from(
          dataCollections.map((i) => TextModel.fromJson(i)));
      // return messages;
      return {'list': messages, 'cursor': nextCursor};
    } catch (err) {
      return {'list': null, 'cursor': ''};
    }
  }

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
    final queryOptions = iGraphqlProvider
        .createQueryOptions(document: document, variables: {'input': input});
    try {
      final res = await iGraphqlProvider.queryWithOptions(queryOptions);
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

  updateGroupInfo(int? collectionKey, String groupName,
      http.MultipartFile? groupPic) async {
    const document = r'''
    mutation collectionUpdate($input: CollectionUpdateInput!, $pictureUpload: Upload){
      collectionUpdate(input: $input, pictureUpload: $pictureUpload){
        collection{
          name
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
      'collectionKey': collectionKey,
    };
    if (groupPic != null) {
      variables['pictureUpload'] = groupPic;
    }
    try {
      final mutationOptions = iGraphqlProvider.createMutationOptions(
          document: document, variables: variables);
      final res = await iGraphqlProvider.mutateWithOptions(mutationOptions);
      if (res.data == null) {
        throw 'Error did not receive data from api';
      }
      return Collection.fromJson(res.data!['collectionUpdate']['collection']);
    } catch (err) {
      debugPrint('err: $err');
      return null;
    }
  }

  userTyping({int? collectionKey}) async {
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
      final mutationOptions = iGraphqlProvider.createMutationOptions(
          document: document, variables: variables);
      final res = await iGraphqlProvider.mutateWithOptions(mutationOptions);
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
