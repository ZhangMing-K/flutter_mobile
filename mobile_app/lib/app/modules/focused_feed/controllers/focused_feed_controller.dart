import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

enum FEED_ORDER_SELECTION {
  FOLLOWING,
  POPULAR,
}

class FocusedFeedArguments {
  List<int?>? textKeys;
  List<int?>? orderKeys;
  List<int?>? assetKeys;
  List<String?>? orderGroupUUIDS;
  bool? fromPush;

  FocusedFeedArguments(
      {this.textKeys,
      this.orderKeys,
      this.assetKeys,
      this.orderGroupUUIDS,
      this.fromPush});
}

class FocusedFeedController extends GetxController
    with StateMixin<List<Rx<TextModel>>> {
  final IFeedRepository repository;
  final scrollController = ScrollController();
  final listviewController = GlobalKey<IrisListViewState>();
  final isOverlayButtonVisible = false.obs;
  final IFeedRepository feedRepository = Get.find<IFeedRepository>();
  final INotificationRepository notificationRepository =
      Get.find<INotificationRepository>();
  final Rx<User?> profileUser$ = Rx<User?>(null);
  final Rx<User?> accountUser$ = Rx<User?>(null);
  final IAuthUserService authUserStore = Get.find<IAuthUserService>();
  final UserService userService = Get.find<UserService>();
  int? listLength;

  late FocusedFeedArguments focusedFeedArguments;

  Rx<List<Text>>? texts$;
  String? cursor;

  FocusedFeedController({required this.repository});

  bool get hasAlerts {
    return accountUser$.value?.authUserUser?.tradeNotificationAmount ==
        USER_TRADE_NOTIFICATION_AMOUNT.ALL;
  }

  bool get hasTradeNotifications {
    return accountUser$.value?.tradeNotificationsSnoozed == false;
  }

  Future<void> loadMore() async {
    if (cursor != null) {
      final res = await textsGet<TextModel>().remote;
      final List<TextModel> list = transformTexts(data: res)!;
      if (res.cursor != '') {
        cursor = res.cursor;
      }

      change(
        state!
          ..addAll(
            list.map((item) => item.obs).toList(),
          ),
        status: RxStatus.success(),
      );
    }
  }

  @override
  void onInit() {
    final args = Get.arguments['focusedFeedArguments'];
    focusedFeedArguments = FocusedFeedArguments(
        textKeys: args['textKeys'],
        orderKeys: args['orderKeys'],
        assetKeys: args['assetKeys'],
        orderGroupUUIDS: args['orderGroupUUIDS'],
        fromPush: args['fromPush']);
    textsGet<TextModel>().getResponse((data) {
      final List<TextModel> list = transformTexts(data: data)!;
      if (list.isNotEmpty) {
        setAccountUser(list[0].user);
        rebuildOnChange(list.map((item) => item.obs).toList());
      }
    });

    super.onInit();
  }

  Future<void> pullRefresh() async {
    cursor = null;
    final data = await textsGet<TextModel>().remote;
    final List<TextModel> list = transformTexts(data: data)!;
    if (data.cursor != '') {
      cursor = data.cursor;
    }
    rebuildOnChange(list.map((item) => item.obs).toList());
  }

  void rebuildOnChange(List<Rx<TextModel>> data) {
    change(data, status: RxStatus.success());
  }

  setAccountUser(User? data) {
    accountUser$.value = data;
  }

  setSnooze(void Function(void Function()) update) async {
    final UserSnooze res;

    if (hasTradeNotifications) {
      //TODO: CHECK EMPTY STATE
      final userKey = state![0].value.user!.userKey;
      final textKey = state![0].value.textKey;
      res = await notificationRepository.snoozeNotifications(
          onError: (error) => debugPrint(error.toString()),
          fromTextKey: textKey,
          fromUserKey: userKey,
          snoozeType: USER_SNOOZE_TYPE.TRADE);
      profileUser$.value =
          profileUser$.value!.copyWith(tradeNotificationsSnoozed: true);
    } else {
      res = await notificationRepository.unsnoozeNotifications(
          snoozeType: USER_SNOOZE_TYPE.TRADE);
      profileUser$.value =
          profileUser$.value!.copyWith(tradeNotificationsSnoozed: false);
    }

    if (kDebugMode) {
      print(res);
    }
    update(() {});
  }

  Repository<DataList<T>> textsGet<T>() {
    return repository.textsGet(
      textKeys: focusedFeedArguments.textKeys,
      orderKeys: focusedFeedArguments.orderKeys,
      assetKeys: focusedFeedArguments.assetKeys,
      requestedFields: TextGql.focusedFeed,
      orderGroupUUIDS: focusedFeedArguments.orderGroupUUIDS,
      cursor: cursor,
    ) as Repository<DataList<T>>;
  }

  List<TextModel>? transformTexts({required DataList data}) {
    List<TextModel>? list;
    list = data.list as List<TextModel>;
    if (data.cursor != '') cursor = data.cursor;
    return list;
  }
}
