import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:graphql/client.dart';
import 'package:http/http.dart' as http;

import '../../../iris_common.dart';

class ChatSubscriptionData {
  final COLLECTION_EVENT_TYPE? eventType;
  final TextModel? text;
  final int? collectionKey;
  final int? userKey;
  final Reaction? reaction;

  const ChatSubscriptionData({
    required this.eventType,
    required this.text,
    required this.collectionKey,
    required this.userKey,
    required this.reaction,
  });
}

abstract class IChatRepository {
  Future collectionAddEntities(
      {required int? collectionKey,
      required COLLECTION_REQUEST_ENTITY_TYPE entityType,
      required List<int?> entityKeys});

  StreamSubscription? collectionEvents({
    List<int>? collectionKeys,
    required List<COLLECTION_EVENT_TYPE> events,
    required ValueChanged<ChatSubscriptionData> callback,
    required Function? onError,
  });

  Future collectionRemoveEntities(
      {required int? collectionKey,
      required COLLECTION_REQUEST_ENTITY_TYPE entityType,
      required List<int?> entityKeys});

  Future<TextModel?> deleteMessage({required int textKey});

  Future<User?> getAuthUser({
    required String requestedFields,
    required FetchPolicy fetchPolicy,
  });

  Future<void> getBasicCollectionDetails({
    required int collectionKey,
    QueryType queryType = QueryType.loadCache,
    required Function(Collection collection) callback,
    required Function(OperationException error) onError,
  });

  Future<void> getCollectionOrders({
    int? collectionKey,
    int limit = 10,
    String? cursor,
    List<int>? userKeys,
    List<int>? assetKeys,
    QueryType queryType = QueryType.loadCache,
    required Function(DataList<TextModel> data) callback,
    required Function(OperationException error) onError,
  });

  Future<void> getCollectionPortfolios({
    required int collectionKey,
    QueryType queryType = QueryType.loadCache,
    required Function(dynamic data) callback,
    required Function(OperationException error) onError,
  });

  Future<void> getCollectionUsers({
    required List<int?> collectionKeys,
    List<int?>? userKeys,
    required QueryType queryType,
    required Function(Collection data) callback,
    required Function(OperationException error) onError,
  });

  Future<void> getLastSeen({
    required int userKey,
    required QueryType type,
    required Function(dynamic data) callback,
    required Function(OperationException error) onError,
  });

  Future<void> getMessagesFromCollection({
    // get initial messages from collection for message view
    required int? collectionKey,
    int? limit,
    String? cursor = '',
    QueryType queryType = QueryType.loadCache,
    required Function(CollectionsGetResponse data) callback,
    required Function(OperationException error) onError,
  });

  Future markSeen({
    required USER_RELATION_ENTITY_TYPE entityType,
    required int entityKeys,
    required bool seen,
    RELATION_LOCATION? relationLocation,
  });

  Future<Collection?> privateMessageCollectionFindOrCreate({
    required int? userKey,
  });

  Future<TextModel> sendMessage(
      {required TEXT_TYPE? textType,
      String? value,
      int? parentKey,
      required bool isEncrypted,
      Giff? giff,
      List<http.MultipartFile>? fileUploads,
      int? collectionKey,
      int? sharedTextKey});

  void setNotificationSettings(
      {required USER_RELATION_NOTIFICATION_AMOUNT amountType,
      required List<int> collectionKeys});

  Future<void> updateGroupInfo({
    required int? collectionKey,
    required String groupName,
    http.MultipartFile? groupPic,
    required String description,
    required Function(dynamic data) callback,
    required Function(OperationException error) onError,
  });

  Future<bool?>? userTyping({int? collectionKey});

  Future<Collection?> createCollection({
    required String groupName,
    required String description,
    required List userKeys,
    required http.MultipartFile? pictureUpload,
  });
}

enum NOTIFICATION_AMOUNT_TYPE { ALL, NONE }
