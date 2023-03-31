import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../../../routes/pages.dart';
import '../../notification/controllers/notification_controller.dart';
import '../modules/posts/controllers/following_feed_controller.dart';
import '../modules/posts/controllers/posts_controller.dart';
import '../modules/user_stories/controllers/user_stories_user_controller.dart';

class FeedController extends SuperController
    with GetSingleTickerProviderStateMixin {
  final PostsController newPostsController;
  //final DDController ddController;

  final FollowingFeedController homeController;
  final IFeedRepository repository;
  final IAuthUserService authUserStore;
  final IrisEvent irisEvent;
  final PushNotificationService pushNotificationService;
  final UpdateCheckerService updateChecker;
  final UserStoriesUserController userStoryController;
  final SecureStorage secureStorage;

  late final tabController = TabController(
    vsync: this,
    length: 1,
    initialIndex: 0,
  );

  get innerKey => Get.keys[1];

  Timer? _newPostTimer;

  Timer? _setOnlineTimer;

  late StreamSubscription _routeListener;

  FeedController({
    required this.newPostsController,
    required this.homeController,
    // required this.ddController,
    required this.repository,
    required this.authUserStore,
    required this.irisEvent,
    required this.pushNotificationService,
    required this.updateChecker,
    required this.userStoryController,
    // required this.assetStoriesAssetController,
    required this.secureStorage,
  });

  int get currentTabIndex {
    return tabController.index;
  }

  PostsController get postsController {
    return newPostsController;
  }

  void addPostToTop(Rx<TextModel> post, TEXT_TYPE? textType) {
    if (textType == TEXT_TYPE.POST) {
      homeController.appendPostOnTop(post);
    }
  }

  void animateWithIndex(int index) {
    tabController.animateTo(index,
        curve: Curves.easeIn, duration: const Duration(milliseconds: 250));
  }

  Future<void> createText(String value, PostInputInfo info) async {
    int? parentKey;
    // if (info.createTextType.textType == TEXT_TYPE.COMMENT) {
    //   parentKey = info.createTextType.parentKey;
    // }
    final Rx<TextModel> text = TextModel(
            textCreateId: DateTime.now().millisecondsSinceEpoch,
            //This is so we can locate it later
            value: value,
            textType: info.createTextType!.textType,
            parentKey: parentKey,

            //TODO: Create authUser object on UserController and remove Store depencency of this controller
            user: authUserStore.loggedUser,
            orderedCreatedAt: DateTime.now())
        .obs;

    addPostToTop(text, info.textType);

    Giff? giff;
    List<http.MultipartFile>? fileUploads;

    if (info.mediaList.isNotEmpty) {
      final AppMedia appMedia = info.mediaList[0];
      info.mediaList.clear();
      if (appMedia.appMediaType == APP_MEDIA_TYPE.GIFF) {
        giff = Giff(
            giffSource: GIFF_SOURCE.GIPHY,
            remoteId: appMedia.giffId,
            url: appMedia.url);
      }
      if (appMedia.appMediaType == APP_MEDIA_TYPE.PHOTO) {
        final http.MultipartFile multiPartFile = http.MultipartFile.fromBytes(
          'photo',
          appMedia.bytes!,
          filename: '${DateTime.now().second}.jpg',
          contentType: MediaType('image', 'jpg'),
        );
        fileUploads = [multiPartFile];
      }
      if (appMedia.appMediaType == APP_MEDIA_TYPE.VIDEO) {
        final http.MultipartFile multiPartFile = http.MultipartFile.fromBytes(
          'video',
          appMedia.bytes!,
          filename: '${DateTime.now().second}.mp4',
          contentType: MediaType('video', 'mp4'),
        );
        fileUploads = [multiPartFile];
      }
    }

    try {
      Get.focusScope?.unfocus();
      final data = await overlayLoader(
          context: Get.context!,
          asyncFunction: () async {
            return repository.postCreate(
                giff: giff,
                value: value,
                parentKey: parentKey,
                fileUploads: fileUploads,
                textType: info.createTextType!.textType,
                collectionKey: info.createTextType!.collectionKey);
          });

      final newText = data.copyWith(textCreateId: text.value.textCreateId).obs;

      replacePostOnList(newText, info.createTextType!.textType);

      if (Get.isBottomSheetOpen!) {
        Get.back();
      }

      // newText.value =
      //     newText.value.copyWith(textCreateId: text.value.textCreateId);

      // replacePostOnList(
      //   newText,
      //   info.textType,
      // );
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  editText(String value, TextModel? text, List<AppMedia> mediaList,
      bool isEdited, AppMedia? deletedMedia) async {
    try {
      Giff? giff;
      List<http.MultipartFile>? fileUploads;

      int? entityKey;
      APP_MEDIA_TYPE? entityType;
      if (isEdited && deletedMedia != null) {
        entityKey = deletedMedia.entityKey;
        entityType = deletedMedia.appMediaType;
      }

      if (mediaList.isNotEmpty && isEdited) {
        final AppMedia appMedia = mediaList[0];
        if (appMedia.appMediaType == APP_MEDIA_TYPE.GIFF) {
          giff = Giff(
              giffSource: GIFF_SOURCE.GIPHY,
              remoteId: appMedia.giffId,
              url: appMedia.url);
        }
        if (appMedia.appMediaType == APP_MEDIA_TYPE.PHOTO) {
          final http.MultipartFile multiPartFile = http.MultipartFile.fromBytes(
            'photo',
            appMedia.bytes!,
            filename: '${DateTime.now().second}.jpg',
            contentType: MediaType('image', 'jpg'),
          );
          fileUploads = [multiPartFile];
        }
        if (appMedia.appMediaType == APP_MEDIA_TYPE.VIDEO) {
          final http.MultipartFile multiPartFile = http.MultipartFile.fromBytes(
            'video',
            appMedia.bytes!,
            filename: '${DateTime.now().second}.mp4',
            contentType: MediaType('video', 'mp4'),
          );
          fileUploads = [multiPartFile];
        }
      }

      late TextModel? newText;
      if (fileUploads != null) {
        newText = await overlayLoader(
            context: Get.overlayContext!,
            asyncFunction: () async {
              return repository.textEdit(
                  textKey: text!.textKey,
                  giff: giff,
                  value: value,
                  fileUploads: fileUploads,
                  entityKey: entityKey,
                  entityType: entityType);
            });
      } else {
        newText = await repository.textEdit(
            textKey: text!.textKey,
            giff: giff,
            value: value,
            fileUploads: fileUploads,
            entityKey: entityKey,
            entityType: entityType);
      }

      if (newText == null) {
        ///TODO: back to previous text and alert user
      }

      if (Get.isBottomSheetOpen!) {
        Get.back();
      }
    } catch (e) {
      debugPrint('error: $e');
      rethrow;
    }
  }

  Future<void> initPushNotifications() async {
    final user = await pushNotificationService.getAuthUserNotifications();
    if (user != null) authUserStore.editUserData(user);
    PosthogService().setUser(user: authUserStore.loggedUser!);
    await pushNotificationService.initialise();
  }

  // void modifierOrderList(List<Rx<TextModel>> data) {
  //   ordersController.rebuildOnChange(data);
  // }

  void modifierPostList(List<Rx<TextModel>> data) {
    postsController.rebuildOnChange(data);
  }

  @override
  void onClose() {
    _routeListener.cancel();
    _clearTimes();
    super.onClose();
  }

  @override
  void onDetached() {}

  @override
  void onInactive() {}

  @override
  void onInit() {
    irisEvent.add(eventType: EVENT_TYPE.VIEW_SCREEN_FEED);
    final currentDateTime = DateTime.now();
    secureStorage.write(key: kFeedSavedTime, value: currentDateTime.toString());
    updateChecker.checkUpdate();
    _routeListener = IrisStackObserver.stackChange.listen((stackChange) {
      if (stackChange.newRoute?.settings.name == Paths.Feed &&
          stackChange.oldRoute is GetPageRoute) {
        // _checkNewPosts();
        _checkShouldRefresh();
        _setStatusOnline();
        updateAppBadges();
      }
    });
    initPushNotifications();
    _setTimer();
    Get.keys[1] = GlobalKey<NavigatorState>(debugLabel: 'Inner navigator');
    super.onInit();
  }

  @override
  void onPaused() {
    _clearTimes();
    debugPrint('AppStatus change: Paused');
  }

  @override
  void onResumed() {
    _setTimer();
    debugPrint('AppStatus change: Resumed');
  }

  Future<void> onSubmit(PostInputInfo info) async {
    final String? value = info.textEditingController?.text;
    if (value == null || value == '') {
      return;
    }
    info.textEditingController!.text = '';

    if (info.textModel == null) {
      await createText(value, info);
    } else {
      await editText(value, info.textModel!.value, info.mediaList,
          info.isEdited, info.deletedMedia);
    }
  }

  void onTabChange(int index) {
    if (index == 0) {
      homeController.checkForUpdate();
    } else if (index == 1) {
      postsController.checkForNewPosts();
    }
  }

  List<Rx<TextModel>> replaceItem(
      Rx<TextModel> newItem, Rx<TextModel> oldItem, List<Rx<TextModel>> list) {
    final index = list.indexWhere(
        (item) => item.value.textCreateId == newItem.value.textCreateId);
    // final index = postList.indexOf(oldItem);
    list.replaceRange(index, index + 1, [newItem]);
    return list;
  }

  void replacePostOnList(Rx<TextModel> newPost, TEXT_TYPE? textType) {
    if (textType == TEXT_TYPE.POST) {
      homeController.replaceData(newPost);
    }
  }

  void scrollToTopOrBackOneTab(int index) {
    if (index == 0) {
      homeController.mustChangePages();
    } else if (index == 1) {
      postsController.mustChangePages();
    } else if (index == 3) {
      // This is a anti pattern, rewrite Notification Bindings
      Get.find<NotificationController>().mustChangePages();
    }
  }

  Future<void> updateAppBadges() async {
    const requestedFields = '''
        userKey
        nbrUnreadMessages
        nbrUnseenNotifications
    ''';
    try {
      final User? user =
          await repository.getAuthUser(requestedFields: requestedFields);

      if (user == null) {
        return;
      }
      final loggedUser = authUserStore.loggedUser;

      if (loggedUser == null) return;

      if (user.nbrUnreadMessages != loggedUser.nbrUnreadMessages ||
          user.nbrUnseenNotifications != loggedUser.nbrUnseenNotifications) {
        authUserStore.editUserData(loggedUser.copyWith(
            nbrUnreadMessages: user.nbrUnreadMessages,
            nbrUnseenNotifications: user.nbrUnseenNotifications));

        if (await FlutterAppBadger.isAppBadgeSupported()) {
          final int num =
              user.nbrUnreadMessages! + user.nbrUnseenNotifications!;
          FlutterAppBadger.updateBadgeCount(num);
        }
      }
    } catch (err) {
      debugPrint('err $err');
      return;
    }
  }

  void _checkShouldRefresh() async {
    final lastTimeString = await secureStorage.read(key: kFeedSavedTime);
    final DateTime savedTime = DateTime.parse(lastTimeString!);
    final difference = DateTime.now().difference(savedTime);
    if (difference > const Duration(minutes: 5)) {
      // refresh
      newPostsController.pullRefresh();
      homeController.pullRefresh();
      await secureStorage.write(
          key: kFeedSavedTime, value: DateTime.now().toString());
    }
  }

  void _clearTimes() {
    _setOnlineTimer?.cancel();
    _newPostTimer?.cancel();
    _setOnlineTimer = null;
    _newPostTimer = null;
  }

  void _setStatusOnline() {
    repository.setOnlineStatus();
  }

  void _setTimer() {
    _setOnlineTimer =
        Timer.periodic(const Duration(minutes: 2), (t) => _setStatusOnline());
    // _newPostTimer =
    //     Timer.periodic(Duration(seconds: 60), (t) => _checkNewPosts());
  }
}
