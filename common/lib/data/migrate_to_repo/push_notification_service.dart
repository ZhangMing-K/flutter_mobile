import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

// enum DEVICE_PLATFORM { IOS, ANDROID, WEB }

class PushNotificationService extends GetxService {
  final IGraphqlProvider iGraphqlProvider;
  final AuthService authService;

  PushNotificationService(
      {required this.iGraphqlProvider, required this.authService});

  //  IAuthUserService authUserStore;

  // final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  Future<void> deviceTokenAdd(
      String fcmToken, DEVICE_PLATFORM devicePlatform) async {
    const document = r'''
      mutation deviceAdd($input: DeviceAddInput){
        deviceAdd(input: $input) {
          device{
            deviceKey
          }
        }
      }
    ''';
    final mutationOptions =
        iGraphqlProvider.createMutationOptions(document: document, variables: {
      'input': {
        'deviceToken': fcmToken,
        'devicePlatform': describeEnum(devicePlatform),
      }
    });

    try {
      await iGraphqlProvider.mutateWithOptions(mutationOptions);
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  Future<User?> getAuthUserNotifications() async {
    final requestedFields = '''
        userKey
        accessAnalyticsAt
        accessFullFeedAt
        accessMessagingAt
        activeSubscriptions{
          subscriptionType
        }
        experienceLevel
        email
        firstName
        lastName
        phoneNumber
        profilePictureUrl
        inviteLink
        description
        verifiedAt
        verifiedText
        firstOrderAt
        lastOnlineAt
        suspendedAt
        username
        goldConnection {
          isGoldMember
          autoRenew
          userPayingPrice
          interval
          purchaseItemPrice {
            purchaseItemPriceKey
            purchaseItemKey
            status
            name
            remoteId
            price
            couponConnection {
              price
              isAuthUserCouponEligible
            }
            interval
            intervalCount
            createdAt
          }      
          subscription {
            subscriptionKey
            status
            latestPaymentTransaction {
              status
            }
            paymentMethodKey
            paymentMethod {
              remoteId
              entityType
              reusable
              previewText
            }
            autoRenew
            remoteId
            startAt
            endAt
          }
        }
        userAccessType
        userPrivacyType
        connectedBrokerNames
        nbrUnreadMessages
        nbrUnseenNotifications
        portfolios{
          portfolioKey
        }
        notifications(input: {limit: 3, offset: 0, seen: false}){
          userKey
        }
        integrations(input: {sources: ${getSocialsInput()}}) {
          source
          username
          integrationKey
          token
        }
        avatar {
          avatarKey
          avatarName
          code
          url
        }
    ''';
    try {
      final authUserNotifications =
          await authService.getAuthUser(requestedFields: requestedFields);

      return authUserNotifications;
    } catch (err) {
      rethrow;
    }
  }

  handleRoute(RemoteMessage? message) {
    if (message == null) {
      Get.toNamed(Paths.Feed + Paths.Notifications, id: 1);
    } else {
      final String? entityKeys = message.data['entityKeys'] ?? '';
      final entityType = message.data['entityType'];
      final clickAction = message.data['clickAction'];
      final imageUrl = message.data['imageUrl'];
      final notificationAction = message.data['notificationAction'];
      final encryptionCode = message.data['encryptionCode'];
      final name = message.data['name'];
      String routePath = '';
      dynamic arguments;
      dynamic parameters;
      final id = uuid.v4();

      if (clickAction ==
              describeEnum(NOTIFICATION_CLICK_ACTION.ROUTE_TO_ENTITY) ||
          entityKeys!.isNotEmpty) {
        final List<int> keys =
            entityKeys!.split(',').map((e) => int.parse(e)).toList();

        if (notificationAction ==
            describeEnum(NOTIFICATION_ACTION_NAME.USER_TRADED)) {
          routePath = Paths.FocusedFeed;
          arguments = {
            'focusedFeedArguments': {
              'textKeys': [...keys],
              'fromPush': true
            }
          };
        } else if (entityType == describeEnum(NOTIFICATION_ENTITY_TYPE.TEXT)) {
          if (keys.length > 1) {
            routePath = Paths.FocusedFeed;
            arguments = {
              'focusedFeedArguments': {
                'textKeys': [...keys]
              }
            };
          } else {
            routePath = Paths.Text.createPath([keys[0]]);
          }
        }
        if (entityType == describeEnum(NOTIFICATION_ENTITY_TYPE.PORTFOLIO)) {
          routePath = Paths.Portfolio.createPath([keys[0]]);
        }

        if (entityType == describeEnum(NOTIFICATION_ENTITY_TYPE.USER)) {
          routePath = Paths.Feed + Paths.Home + Paths.Profile;
          parameters = {'profileUserKey': keys[0].toString()};
          arguments = ProfileArgs(
              heroTag: id, user: User(profilePictureUrl: imageUrl ?? ''));
        }

        if (entityType == describeEnum(NOTIFICATION_ENTITY_TYPE.COLLECTION)) {
          final id = uuid.v4();
          arguments = ChatArgs(
            encryptionCode: encryptionCode,
            avatarUrl: imageUrl ?? '',
            chatname: name,
            id: id,
            message: null,
          );
          routePath = Paths.Feed +
              Paths.Home +
              Paths.MessageCollection.createPath([keys[0]]);
        }
        if (Get.currentRoute != routePath) {
          Get.toNamed(
            routePath,
            parameters: parameters,
            arguments: arguments,
            preventDuplicates: false,
            id: 1,
          );
        }
      } else {
        Get.toNamed(Paths.Feed + Paths.Notifications, id: 1);
      }
    }
  }

  Future initialise() async {
    if (GetPlatform.isIOS) {
      await FirebaseMessaging.instance.requestPermission(
          sound: true, badge: true, alert: true, provisional: false);
      _saveDeviceToken();
    } else {
      _saveDeviceToken();
    }

    FirebaseMessaging.onMessage.listen((message) async {
      final bool currentlyOnScreen = onScreen(message);
      if (currentlyOnScreen == false) {
        final imageUrl = message.data['imageUrl'];
        SnackBarService.to.twoLine(
          imageUrl: imageUrl,
          name: message.notification!.title!,
          subtitle: message.notification!.body!,
          onPressed: () => handleRoute(message),
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) async {
      handleRoute(message);
    });

    await FirebaseMessaging.instance.getInitialMessage().then((value) {
      if (value != null) handleRoute(value);
    });
  }

  bool onScreen(message) {
    if (message != null) {
      final routePath =
          Get.routing.current.split('/').where((r) => r.isNotEmpty).toList();
      final String? entityKeys = message.data['entityKeys'] ?? '';
      final entityType = message.data['entityType'];
      if (entityKeys!.isNotEmpty) {
        final List<int> keys =
            entityKeys.split(',').map((e) => int.parse(e)).toList();
        if (entityType == describeEnum(NOTIFICATION_ENTITY_TYPE.COLLECTION)) {
          if (Get.parameters['collectionKey'] != null &&
              Get.parameters['collectionKey'] != '' &&
              routePath[0] == 'message') {
            final int currentCollectionKey =
                int.parse(Get.parameters['collectionKey']!);
            if (currentCollectionKey == keys[0]) {
              return true;
            }
          }
        }
      }
    }
    return false;
  }

  _saveDeviceToken() async {
    final String? fcmToken = await FirebaseMessaging.instance.getToken();
    if (fcmToken != null) {
      late DEVICE_PLATFORM platform;
      if (GetPlatform.isAndroid) {
        platform = DEVICE_PLATFORM.ANDROID;
      } else if (GetPlatform.isIOS) {
        platform = DEVICE_PLATFORM.IOS;
      } else if (GetPlatform.isWeb) {
        platform = DEVICE_PLATFORM.WEB;
      }
      await deviceTokenAdd(fcmToken, platform);
    } else {
      throw 'FCM token can not be generated.';
    }
  }
}
