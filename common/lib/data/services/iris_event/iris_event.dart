import 'package:flutter/material.dart';
import 'package:iris_common/iris_common.dart';

export './iris_event_service.dart';

class IrisEvent {
  final IrisEventService irisEventService;
  final EventIGraphqlProvider eventIGraphqlProvider;

  IrisEvent(
      {required this.irisEventService, required this.eventIGraphqlProvider});

  Future<void> capture(EVENT_TYPE eventType, String eventName) async {
    return PosthogService()
        .capture(eventName: eventName, eventType: eventType.name)
        .then((value) => debugPrint("sent Event $eventName"));
  }

  Future<int?> add({
    EVENT_TYPE? eventType,
    String? subType,
    String? eventFrom,
    EVENT_ENTITY_TYPE? entityType,
    int? entityKey,
  }) async {
    return irisEventService.add(
        eventType: eventType,
        subType: subType,
        eventFrom: eventFrom,
        entityType: entityType,
        entityKey: entityKey);
  }

  void addAuthorization(String? token) {
    eventIGraphqlProvider.authToken = token;
  }

  Future<void> registerAssetEvent({
    ASSET_EVENT_TYPE? assetEventType,
    int? assetKey,
  }) async {
    return irisEventService.registerAssetEvent(
        assetEventType: assetEventType, assetKey: assetKey);
  }

  Future<void> registerProfileView({
    int? fromTextKey,
    required int profileUserKey,
    PROFILE_VIEW_FROM? from,
  }) async {
    return irisEventService.registerProfileView(
        profileUserKey: profileUserKey, from: from, fromTextKey: fromTextKey);
  }

  Future<void> registerTextEvent({
    TEXT_EVENT_ACTION? textEventType,
    int? textKey,
  }) async {
    return irisEventService.registerTextEvent(
        textEventType: textEventType, textKey: textKey);
  }

  Future<void> registerTextView({
    int? fromCollectionKey,
    required int textKey,
    TEXT_VIEW_FROM? from,
    int? assetKey,
  }) async {
    return irisEventService.registerTextView(
        textKey: textKey,
        fromCollectionKey: fromCollectionKey,
        from: from,
        assetKey: assetKey);
  }

  Future<void> reportError({required String errorMessage}) async {
    return irisEventService.errorReport(errorMessage: errorMessage);
  }

  Future<void> reportLogout(
      {required int userKey, bool? isAutoLogout, String? description}) async {
    return irisEventService.reportLogout(
        userKey: userKey, isAutoLogout: isAutoLogout, description: description);
  }
}
