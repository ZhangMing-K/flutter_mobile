import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:iris_common/shared/widgets/app_easy_rich_text/index.dart';
import 'package:iris_mobile/app/modules/feed/controllers/feed_controller.dart';
import 'package:iris_mobile/app/modules/feed/shared/widgets/post_input/post_input.dart';
import 'package:iris_mobile/widgets_v2/pannels/text_settings_pannel/text_setting_pannel_data.dart';
import 'package:iris_mobile/widgets_v2/pannels/text_settings_pannel/text_settings_pannel.dart';

class TextCardController extends GetxController {
  final Rx<TextModel?>? text$;
  final isVisible = true.obs;
  BaseController baseController = Get.find();
  FocusNode focusNode = FocusNode();
  final TextService textService = Get.find();
  final IFeedRepository feedRepository = Get.find();
  final IAuthUserService authUserStore = Get.find();
  final Events events = Get.find();
  final FollowService followService = Get.find();
  final INotificationRepository notificationRepository =
      Get.find<INotificationRepository>();
  final IrisEvent irisEvent = Get.find();
  final RxBool isExpand = false.obs;
  final maxLength = 200;
  final isReacted = false.obs;
  final recentOrdersLoadingApiStatus$ = Rx<API_STATUS>(API_STATUS.NOT_STARTED);
  final RxList<Order> recentOrders$ = <Order>[].obs;
  bool canLoadMore = true;
  int offset = 0;
  int limit = 10;

  final ReactionService reactionService = Get.find();

  Timer? attentionTimer;
  Timer? longAttentionTimer;

  TextCardController(this.text$);

  int get commentLenght => comments.length;

  List<TextModel> get comments => text?.comments ?? <TextModel>[];

  String? get cutText =>
      RichEditTextUtils.getCutText(text$!.value!.value, maxLength);

  bool get isAuthUser {
    final textUser = text$?.value?.user?.userKey;
    if (textUser == null) return false;
    return authUserStore.loggedUser?.userKey == textUser;
  }

  bool get isSaved {
    return text$!.value?.authUserRelation?.savedAt != null;
  }

  bool get isShowMore =>
      RichEditTextUtils.needShowMore(text$!.value!.value, maxLength) ?? false;

  bool get noRecentOrders => recentOrders$.isEmpty;

  TextModel? get text => text$!.value;

  String? get userProfileUrl {
    var url = text?.user?.profilePictureUrl;
    if (text?.user?.userKey == authUserStore.loggedUser?.userKey) {
      url = authUserStore.loggedUser?.profilePictureUrl;
    }
    return url;
  }

  void askForUserNotifications() {
    Get.dialog(CupertinoAlertDialog(
      title: Text(
          'Want to get notified when ${text$?.value?.user?.firstName} makes a trade?'),
      content: const Text(
          'Turn on trade and post notifications to know exactly when and what they trade.'),
      actions: [
        CupertinoDialogAction(
          child: const Text('Not now'),
          onPressed: () {
            Get.back();
          },
        ),
        CupertinoDialogAction(
          child: const Text('Turn on'),
          onPressed: () async {
            final isGranted =
                await NotificationPermission.getNotificationPermission();
            if (isGranted) {
              await notificationRepository.changeUserNotifications(
                userKey: text$!.value!.user!.userKey!,
                postNotificationAmount: USER_POST_NOTIFICATION_AMOUNT.ALL,
                tradeNotificationAmount: USER_TRADE_NOTIFICATION_AMOUNT.ALL,
              );
            }
            Get.back();
          },
        ),
      ],
    ));
  }

  void changeText(TextModel newText) {
    text$!.value = newText;
  }

  closeDDCard() {
    if (attentionTimer != null) {
      attentionTimer!.cancel();
    }
    if (longAttentionTimer != null) {
      longAttentionTimer!.cancel();
    }
  }

  Future<void> commentsGet() async {
    feedRepository.getComments(
      CommentsGetInput(
          parentKey: text$!.value!.textKey,
          limit: 10,
          order: QUERY_ORDER.DESC,
          offset: text?.comments?.length),
      callback: (data) {
        final text = text$!.value;
        final newText = data.comments;

        if (newText == null) {
          return;
        }
        text$!.value = text!.copyWith(comments: [
          ...newText,
          ...?text.comments,
        ]);
      },
      onError: onError,
    );
  }

  void expandText() {
    isExpand.value = true;
  }

  Future<void> followUser() async {
    HapticFeedback.lightImpact();
    text$?.value = text$?.value?.copyWith(
        user: text$?.value?.user?.copyWith(
            authUserFollowInfo:
                const AuthUserFollowInfo(followStatus: FOLLOW_STATUS.PENDING)));
    askForUserNotifications();
    await followService.requestToFollowType(
        lookupKey: text!.user!.userKey,
        entityType: FOLLOW_REQUEST_ENTITY_TYPE.USER);
  }

  // Future<void> generateVideoPreview() async {
  //   final uint8list = await VideoThumbnail.thumbnailFile(
  //     video:
  //         'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
  //     imageFormat: ImageFormat.JPEG,
  //     maxHeight:
  //         64, // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
  //     quality: 75,
  //   );
  // }

  Future<void> markSaved() async {
    final UserRelation? data = await feedRepository.userRelationsUpdate(
      entityType: USER_RELATION_ENTITY_TYPE.TEXT,
      entityKeys: [text!.textKey],
      save: !isSaved,
    );
    text$!.value = text$!.value!.copyWith(authUserRelation: data);
  }

  void onAddCommentEvent(ReturnTextInfo info) {
    final TextModel? text = text$!.value;
    if (info.apiStatus == API_STATUS.PENDING) {
      text$!.value = text!.copyWith(comments: [...text.comments!, info.text!]);
    } else if (info.apiStatus == API_STATUS.FINISHED) {
      final comments = text!.comments!;
      final List<TextModel?> newComments = [];
      for (var element in comments) {
        if (element.textCreateId == info.text!.textCreateId) {
          newComments.add(info.text);
        } else {
          newComments.add(element);
        }
      }
      text$!.value = text.copyWith(comments: newComments as List<TextModel>?);
    } else if (info.apiStatus == API_STATUS.ERROR) {
      text!.comments!.removeWhere((element) => element.textKey == null);
      text$!.value = text.copyWith(comments: [...text.comments!]);
      text$!.refresh();
    }
  }

  onError(err) {
    debugPrint(err.toString());
    recentOrdersLoadingApiStatus$.value = API_STATUS.ERROR;
  }

  onRecentOrdersGetSuccess(List<Order> data) {
    if (data.length == limit) {
      offset += limit;
      canLoadMore = true;
    } else {
      canLoadMore = false;
    }
    List<Order> allOrders = [...recentOrders$, ...data];
    recentOrders$.assignAll(allOrders);
    recentOrdersLoadingApiStatus$.value = API_STATUS.FINISHED;
  }

  onRemoveCommentEvent(TextModel? text) {
    comments.removeWhere((textComment) {
      return textComment == text;
    });

    final isRemoved = comments.remove(text);

    if (!isRemoved) {
      text$!.value = text$!.value!
          .copyWith(numberOfComments: text$!.value!.numberOfComments! - 1);
    }

    // text$.value.comments.removeWhere((element) {
    //   return element.textCreateId == text.textCreateId;
    // });
    text$!.refresh();
    // events.text(TextEvent(TEXT_EVENT_TYPE.CREATE_TEXT, text$.value,
    //     apiStatus: info.apiStatus));
  }

  onSeen() {
    // debugPrint('onSeen ${Get.currentRoute}');
    if (text$ == null) {
      return;
    }
    final text = text$!.value!;

    TEXT_VIEW_FROM from = TEXT_VIEW_FROM.FEED;
    if (Get.currentRoute.contains('Story') ||
        Get.currentRoute.contains('story')) {
      from = TEXT_VIEW_FROM.STORY;
      return; //do not register text view here as we register it in the story
    } else if (Get.currentRoute.contains('profile')) {
      from = TEXT_VIEW_FROM.PROFILE;
    } else if (Get.currentRoute.contains('collection')) {
      from = TEXT_VIEW_FROM.COLLECTION;
    }
    irisEvent.registerTextView(textKey: text.textKey!, from: from);
  }

  onSlideUpAsset(BuildContext context, {required int assetKey}) {
    // if (assetKey == null) {
    //   return;
    // }
    // AssetViewBottomSheet.open(assetKey: assetKey);
  }

  void performReaction() {
    isReacted.value = true;
    HapticFeedback.lightImpact();
    Future.delayed(
        const Duration(milliseconds: 700), () => isReacted.value = false);
  }

  Future<void> reactToPost() async {
    if (text$!.value!.authUserReaction == null) {
      //by wrapping this in a conditional, the reaction animation only happens when the post is liked
      //to have an unlike animation, remove it from the conditional
      performReaction();
    }

    final userNotReacted = text$!.value!.authUserReaction == null;
    int reactionCount = text$!.value!.numberOfReactions!;
    reactionCount = reactionCount > 0
        ? reactionCount
        : 0; // reactionCount could be -1 in some case
    final newReactionCount =
        userNotReacted ? reactionCount + 1 : reactionCount - 1;
    final newReaction = userNotReacted ? const Reaction() : null;
    text$!.value = text$!.value!.copyWith(
        numberOfReactions: newReactionCount, authUserReaction: newReaction);

    final currentReactions = text$!.value!.reactions;
    if (currentReactions!.isEmpty) {
      const AuthUserFollowInfo followInfo =
          AuthUserFollowInfo(followStatus: FOLLOW_STATUS.ME);
      final reactionMyself = Reaction(
          user: authUserStore.loggedUser!
              .copyWith(authUserFollowInfo: followInfo, userPrivacyType: null));

      text$!.value = text$!.value!.copyWith(reactions: [reactionMyself]);
    }
    await reactionService.reactToText(
        reactionKind: REACTION_KIND.LIKE, textKey: text$!.value!.textKey);
  }

  void registerAttention() {
    if (text$?.value?.textKey == null) {
      return;
    }

    attentionTimer = Timer(const Duration(seconds: 5), () {
      irisEvent.registerTextEvent(
          textKey: text$!.value!.textKey,
          textEventType: TEXT_EVENT_ACTION.ATTENTION);
    });
  }

  void registerLongAttention() {
    if (text$?.value?.textKey == null) {
      return;
    }
    longAttentionTimer = Timer(const Duration(seconds: 20), () {
      irisEvent.registerTextEvent(
          textKey: text$!.value!.textKey,
          textEventType: TEXT_EVENT_ACTION.LONG_ATTENTION);
    });
  }

  void routeToProfilePage(String id) {
    final profileArgs = ProfileArgs(
      user: text$?.value?.user ?? const User(),
      heroTag: id,
    );
    Get.toNamed(
      Paths.Feed + Paths.Home + Paths.Profile,
      arguments: profileArgs,
      parameters: {'profileUserKey': text$!.value!.user!.userKey.toString()},
      id: 1,
    );
  }

  void showMore() {
    final int textKey = text$!.value!.textKey!;
    irisEvent.registerTextEvent(
        textEventType: TEXT_EVENT_ACTION.SEE_MORE, textKey: textKey);
    isExpand.toggle();
  }

  tapEditReason() {
    PostInput.show(
        submitName: 'Publish',
        isFullPage: true,
        textType: text$!.value!.textType ?? TEXT_TYPE.POST,
        createTextType:
            CreateTextType(textType: text$!.value!.textType ?? TEXT_TYPE.POST),
        focusNode: FocusNode(),
        hintText: 'Add the reason you made this order',
        onSubmit: (info) {
          final TextModel newData =
              text$!.value!.copyWith(value: info.textEditingController!.text);
          text$!.call(newData);
          Get.find<FeedController>().onSubmit(info);
        },
        text: text$,
        onTyping: () {});
  }

  tapTrailing() {
    final text = text$!.value;
    final TextSettingsPannelData pannelData =
        TextSettingsPannelData(authUser: authUserStore.loggedUser, text: text);
    if (kDebugMode) {
      print('tap trailing: ');
    }
    TextSettingPannel.openPannel(
      text: text$,
      pannelData: pannelData,
      textCardController: this,
    );
  }

  viewMoreComments() {}
}

class UserReactionCall {
  final API_STATUS apiStatus;
  final Reaction reaction;

  UserReactionCall({
    this.apiStatus = API_STATUS.NOT_STARTED,
    required this.reaction,
  });
}
