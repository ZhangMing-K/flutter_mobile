import 'dart:async';

import 'package:device_info/device_info.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../iris_common.dart';

class AppDeviceInfo {
  AppDeviceInfo({this.deviceKind, this.devicePlatform});

  DEVICE_PLATFORM? devicePlatform;
  String? deviceKind;
}

class IrisEventService extends GetxService {
  EventIGraphqlProvider eventIGraphqlProvider = Get.find();

  int? eventSessionKey;
  int nbrOfFailedTries = 0;

  init() async {
    await eventSessionCreate();
  }

  Future<AppDeviceInfo?> deviceInfo() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AppDeviceInfo? appDeviceInfo;
    if (GetPlatform.isIOS) {
      final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      appDeviceInfo = AppDeviceInfo(
          deviceKind: iosInfo.utsname.machine,
          devicePlatform: DEVICE_PLATFORM.IOS);
    } else if (GetPlatform.isAndroid) {
      final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      appDeviceInfo = AppDeviceInfo(
          deviceKind: androidInfo.model,
          devicePlatform: DEVICE_PLATFORM.ANDROID);
    } else if (GetPlatform.isWeb) {
      appDeviceInfo = AppDeviceInfo(devicePlatform: DEVICE_PLATFORM.WEB);
    }

    return appDeviceInfo;
  }

  AppDeviceInfo? appDeviceInfo;
  bool pendingCreateSession = false;

  Future<int?> eventSessionCreate() async {
    pendingCreateSession = true;
    final f = await Future.wait([deviceInfo()]);
    appDeviceInfo = f[0] as AppDeviceInfo;
    const document = r'''
    mutation eventSessionCreate($input: EventSessionCreateInput){
      eventSessionCreate(input: $input){
        eventSessionKey
      }
    }
    ''';
    final Map<String, dynamic> input = {
      'devicePlatform': describeEnum(appDeviceInfo!.devicePlatform!),
      'userAgent': appDeviceInfo!.deviceKind,
      'clientType': 'EDEN',
    };
    final options = eventIGraphqlProvider.createMutationOptions(
        document: document, variables: {'input': input}, errorLogging: true);
    try {
      final res = await eventIGraphqlProvider.mutateWithOptions(
        options,
      );
      if (res.data!['eventSessionCreate'] != null) {
        eventSessionKey = res.data!['eventSessionCreate']['eventSessionKey'];
        pendingCreateSession = false;
        setEventSessionKey(eventSessionKey);
        cancelTimer();
        return eventSessionKey;
      }
      return null;
    } catch (err) {
      pendingCreateSession = false;
      nbrOfFailedTries++;
      startTimer();
      return null;
    }
  }

  cancelTimer() {
    if (timer != null) {
      timer!.cancel();
      timer = null;
    }
  }

  Timer? timer;

  startTimer() {
    if (timer != null) {
      return;
    }
    Timer(const Duration(minutes: 2), () {
      nbrOfFailedTries = 0;
      if (timer != null) {
        timer!.cancel();
        timer = null;
      }
    });
  }

  setEventSessionKey(int? eventSessionKey) {
    this.eventSessionKey = eventSessionKey;
    return this.eventSessionKey;
  }

  eventSessionAddUser() async {}

  Future<void> registerProfileView({
    int? fromTextKey,
    required int profileUserKey,
    PROFILE_VIEW_FROM? from,
  }) async {
    if (nbrOfFailedTries > 3) {
      return;
    }
    if (eventSessionKey == null && pendingCreateSession == false) {
      await eventSessionCreate();
    }

    const document = r'''
    mutation registerProfileView($input: ProfileViewInput!){
       registerProfileView(input: $input)
    }
    ''';
    final Map<String, dynamic> input = {
      'eventSessionKey': eventSessionKey,
      'profileUserKey': profileUserKey
    };
    if (fromTextKey != null) {
      input['fromTextKey'] = fromTextKey;
    }
    if (from != null) {
      input['from'] = describeEnum(from);
    }

    final options = eventIGraphqlProvider.createMutationOptions(
      document: document,
      variables: {'input': input},
    );

    try {
      await eventIGraphqlProvider.mutateWithOptions(options);
      return;
    } catch (err) {
      return;
    }
  }

  Future<void> reportLogout(
      {required int userKey, bool? isAutoLogout, String? description}) async {
    debugPrint('STARTING 123');
    const document = r'''
    mutation logout($input: LogoutInput!){
       logout(input: $input)
    }
    ''';
    final Map<String, dynamic> input = {
      'userKey': userKey,
    };

    if (isAutoLogout != null) {
      input['isAutoLogout'] = isAutoLogout;
    }
    if (description != null) {
      input['description'] = description;
    }
    // if (eventSessionKey != null) {
    //   input['eventSessionKey'] = eventSessionKey;
    // }
    final options = eventIGraphqlProvider.createMutationOptions(
      document: document,
      variables: {'input': input},
    );

    try {
      await eventIGraphqlProvider.mutateWithOptions(options);

      return;
    } catch (err) {
      debugPrint(err.toString());
      return;
    }
  }

  Future<void> errorReport({required String errorMessage}) async {
    if (nbrOfFailedTries > 3) {
      return;
    }
    if (eventSessionKey == null) {
      await eventSessionCreate();
    }

    debugPrint('reporting event 1');
    const document = r'''
    mutation errorReport($input: ErrorReportInput!){
       errorReport(input: $input)
    }
    ''';
    final Map<String, dynamic> input = {
      'errorMessage': errorMessage,
    };

    if (appDeviceInfo != null) {
      input['deviceType'] = appDeviceInfo!.deviceKind;
    }
    if (eventSessionKey != null) {
      input['eventSessionKey'] = eventSessionKey;
    }
    final options = eventIGraphqlProvider.createMutationOptions(
      document: document,
      variables: {'input': input},
    );

    try {
      await eventIGraphqlProvider.mutateWithOptions(options);

      return;
    } catch (err) {
      debugPrint(err.toString());
      return;
    }
  }

  Future<void> registerTextView({
    int? fromCollectionKey,
    required int textKey,
    TEXT_VIEW_FROM? from,
    int? assetKey,
  }) async {
    if (nbrOfFailedTries > 3) {
      return;
    }
    if (eventSessionKey == null) {
      await eventSessionCreate();
    }
    if (eventSessionKey == null) {
      return;
    }
    const document = r'''
    mutation registerTextView($input: TextViewInput!){
       registerTextView(input: $input)
    }
    ''';
    final Map<String, dynamic> input = {
      'eventSessionKey': eventSessionKey,
      'textKey': textKey
    };
    if (fromCollectionKey != null) {
      input['fromCollectionKey'] = fromCollectionKey;
    }
    if (from != null) {
      input['from'] = describeEnum(from);
    }
    if (assetKey != null) {
      input['assetKey'] = assetKey;
    }

    final options = eventIGraphqlProvider.createMutationOptions(
        document: document,
        variables: {'input': input},
        onError: (err) {
          debugPrint('err');
          debugPrint(err.toString());
        });

    try {
      await eventIGraphqlProvider.mutateWithOptions(options);

      return;
    } catch (err) {
      debugPrint(err.toString());
      return;
    }
  }

  Future<void> registerTextEvent({
    TEXT_EVENT_ACTION? textEventType,
    int? textKey,
  }) async {
    if (eventSessionKey == null) {
      await eventSessionCreate();
    }
    if (eventSessionKey == null) {
      return;
    }
    const document = r'''
    mutation registerTextEvent($input: TextEventInput!){
      registerTextEvent(input: $input)
    }
    ''';
    final Map<String, dynamic> input = {
      'eventSessionKey': eventSessionKey,
      'textEventType': describeEnum(textEventType!),
      'textKey': textKey!,
    };

    final options = eventIGraphqlProvider.createMutationOptions(
      document: document,
      variables: {'input': input},
    );

    try {
      await eventIGraphqlProvider.mutateWithOptions(options);
      return;
    } catch (err) {
      debugPrint('err on register text event: $err');
      return;
    }
  }

  Future<void> registerAssetEvent({
    ASSET_EVENT_TYPE? assetEventType,
    int? assetKey,
  }) async {
    if (eventSessionKey == null) {
      await eventSessionCreate();
    }
    if (eventSessionKey == null) {
      return;
    }
    const document = r'''
    mutation registerAssetEvent($input: AssetEventInput!){
      registerAssetEvent(input: $input)
    }
    ''';
    final Map<String, dynamic> input = {
      'eventSessionKey': eventSessionKey,
      'assetEventType': describeEnum(assetEventType!),
      'assetKey': assetKey!,
    };

    final options = eventIGraphqlProvider.createMutationOptions(
      document: document,
      variables: {'input': input},
    );

    try {
      await eventIGraphqlProvider.mutateWithOptions(options);
      return;
    } catch (err) {
      debugPrint('error on register Asset event $err');
      return;
    }
  }

  Future<void> saveClipboard({String? data}) async {
    if (eventSessionKey == null) {
      await eventSessionCreate();
    }
    if (eventSessionKey == null) {
      return;
    }
    const document = r'''
    mutation saveClipboard($input: ClipboardInput!){
      registerAssetEvent(input: $input)
    }
    ''';
    final Map<String, dynamic> input = {
      'eventSessionKey': eventSessionKey,
      'data': data!,
    };

    final options = eventIGraphqlProvider.createMutationOptions(
      document: document,
      variables: {'input': input},
    );

    try {
      await eventIGraphqlProvider.mutateWithOptions(options);
      return;
    } catch (err) {
      return;
    }
  }

  Future<int?> add({
    EVENT_TYPE? eventType,
    String? subType,
    String? eventFrom,
    EVENT_ENTITY_TYPE? entityType,
    int? entityKey,
  }) async {
    if (nbrOfFailedTries > 3) {
      return null;
    }
    if (eventSessionKey == null) {
      await eventSessionCreate();
    }
    if (eventSessionKey == null) {
      return null;
    }
    const document = r'''
    mutation eventAdd($input: EventAddInput!){
       eventAdd(input: $input){
        eventKey
      }
    }
    ''';
    final Map<String, dynamic> input = {
      'eventSessionKey': eventSessionKey,
      'subType': subType,
      'eventFrom': eventFrom,
      'entityKey': entityKey,
    };
    if (eventType != null) {
      input['eventType'] = describeEnum(eventType);
    }
    if (entityType != null) {
      input['entityType'] = describeEnum(entityType);
    }

    final options = eventIGraphqlProvider.createMutationOptions(
      document: document,
      variables: {'input': input},
    );

    try {
      final res = await eventIGraphqlProvider.mutateWithOptions(
        options,
      );
      if (res.data!['eventAdd'] != null) {
        final int? eventKey = res.data!['eventAdd']['eventKey'];
        return eventKey;
      }
      return null;
    } catch (err) {
      return null;
    }
  }
}

enum EVENT_TYPE {
  VIEW_USER_PROFILE,
  VIEW_PORTFOLIO_SUMMARY,
  VIEW_PORTFOLIO_FULL,
  VIEW_ASSET,
  VIEW_TEXT,
  VIEW_SCREEN_LEADERBOARD,
  VIEW_SCREEN_SEARCH,
  VIEW_SCREEN_WATCHLIST,
  VIEW_SCREEN_INVITE,
  VIEW_SCREEN_REGISTER,
  VIEW_SCREEN_FEED,
  VIEW_SCREEN_LOGIN,
  LOGIN,
  REGISTER,
  FEED_FILTER,
}

enum EVENT_ENTITY_TYPE {
  ASSET,
  USER,
  TEXT,
  PORTFOLIO,
}

enum PROFILE_VIEW_FROM { SEARCH, MESSAGE, TEXT, LEADERBOARD }

enum TEXT_VIEW_FROM { FEED, PROFILE, COLLECTION, STORY }

enum TEXT_EVENT_ACTION { CLICK, SEE_MORE, ATTENTION, LONG_ATTENTION }

enum ASSET_EVENT_TYPE {
  VIEW,
  HISTORICAL_1D,
  HISTORICAL_1W,
  HISTORICAL_1M,
  HISTORICAL_3M,
  HISTORICAL_1Y,
  HISTORICAL_ALL,
  MENTIONS,
  OVERVIEW,
  ATTENTION,
  LONG_ATTENTION,
}
