import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:iris_common/shared/widgets/app_easy_rich_text/index.dart';
import 'package:iris_common/shared/widgets/like_button/like_button.dart';
import 'package:iris_mobile/app/modules/feed/shared/widgets/text_card/SharedMessageText/index.dart';

import 'iris_context_menu.dart';
import 'message_attachment.dart';

class MessageItemController extends GetxController {
  final isReacted = false.obs;

  final ReactionService reactionService = Get.find();
  //final ChatController chatController = Get.find();
  final IAuthUserService authUserStore = Get.find();

  final IrisReactionManager reactionManager = IrisReactionManager();

  Color likeBackgroundColor(Rx<TextModel> message, bool isDark) {
    final darkModeColor = isDark ? Colors.grey[900]! : Colors.grey.shade300;
    final authUserKey = authUserStore.loggedUser?.userKey;
    if (message.value.authUserReaction != null) {
      if (message.value.authUserReaction!.user == null) {
        return IrisColor.primaryColor;
      }
      if (message.value.authUserReaction!.user!.userKey == authUserKey) {
        return IrisColor.primaryColor;
      } else {
        return darkModeColor;
      }
    } else {
      return darkModeColor;
    }
  }

  Color likeColor(Rx<TextModel> message, bool isDark) {
    final darkModeColor = isDark ? Colors.grey[300]! : Colors.grey[900]!;
    final authUserKey = authUserStore.loggedUser!.userKey;
    if (message.value.authUserReaction != null) {
      if (message.value.authUserReaction!.user == null) {
        return Colors.white;
      }
      if (message.value.authUserReaction!.user!.userKey == authUserKey) {
        return Colors.white;
      } else {
        return darkModeColor;
      }
    } else {
      return darkModeColor;
    }
  }

  // void removeMessage(Rx<TextModel> text$) {
  //   chatController.chatRepository.deleteMessage(textKey: text$.value.textKey!);
  //   chatController.totalMessages$.removeWhere(
  //       (element) => element.message.value.textKey == text$.value.textKey);
  // }

  void performReaction() {
    isReacted.value = true;
    HapticFeedback.lightImpact();
    Future.delayed(
        const Duration(milliseconds: 700), () => isReacted.value = false);
  }

  Future<void> reactToPost(Rx<TextModel> text$,
      {required String? reaction}) async {
    REACTION_KIND? reactionKind;
    if (reaction == null) {
      reactionKind = text$.value.authUserReaction!.reactionKind!;
    } else if (reaction.toLowerCase() == 'like') {
      reactionKind = REACTION_KIND.LIKE;
    } else if (reaction.toLowerCase() == 'wow') {
      reactionKind = REACTION_KIND.WOW;
    } else if (reaction.toLowerCase() == 'haha') {
      reactionKind = REACTION_KIND.HAHA;
    } else if (reaction.toLowerCase() == 'angry') {
      reactionKind = REACTION_KIND.ANGRY;
    } else if (reaction.toLowerCase() == 'sad') {
      reactionKind = REACTION_KIND.SAD;
    } else {
      reactionKind = text$.value.authUserReaction!.reactionKind!;
    }

    if (text$.value.authUserReaction == null) {
      //by wrapping this in a conditional, the reaction animation only happens when the post is liked
      //to have an unlike animation, remove it from the conditional
      performReaction();
    }

    if (text$.value.authUserReaction == null) {
      //adding reaction
      text$.value = text$.value.copyWith(
          numberOfReactions: text$.value.numberOfReactions! + 1,
          authUserReaction: Reaction(reactionKind: reactionKind));
    } else {
      text$.value = (reaction == null)
          //removing reaction
          ? text$.value.copyWith(
              numberOfReactions: text$.value.numberOfReactions! - 1,
              authUserReaction: null,
            )
          //editing reaction
          : text$.value.copyWith(
              authUserReaction: Reaction(reactionKind: reactionKind),
            );
    }
    await reactionService.reactToText(
        reactionKind: reactionKind, textKey: text$.value.textKey);
  }
}

class MessageItemView extends StatelessWidget {
  final IrisBubbleType type;
  final Rx<TextModel> message;
  final bool isSending;
  final bool isLast;
  final bool isSender;
  final bool showDate;
  final bool isPrivateMessage;
  final int? fromCollectionKey;
  final controller =
      MessageItemController(); // function to be called after watching stories from chat

  //TODO: Change to GetWidget and put it on bindings
  final reactionList = const <String>[
    'like',
    'wow',
    'haha',
    // 'sad',
    // 'angry',
  ];

  MessageItemView({
    Key? key,
    required this.message,
    this.isSending = false,
    required this.type,
    required this.isLast,
    required this.isSender,
    required this.showDate,
    required this.isPrivateMessage,
    this.fromCollectionKey,
  }) : super(key: key);

  bool get hasAttachment {
    if (message.value.taggedFiles != null &&
        message.value.taggedFiles!.isNotEmpty) {
      return true;
    }
    if (message.value.taggedGiffs != null &&
        message.value.taggedGiffs!.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool get hasMessageValue {
    if (message.value.value != null && message.value.value != '') {
      return true;
    }
    return false;
  }

  bool get hasSharedText {
    if (message.value.sharedText != null) {
      return true;
    }
    return false;
  }

  bool get hasTwoBubbles {
    if (hasMessageValue) {
      if (hasSharedText || hasAttachment) {
        return true;
      }
      return false;
    }
    return false;
  }

  bool get isMessageValueEmoji {
    if (!hasMessageValue) return false;
    final textVal = message.value.value!;
    final RegExp regExp = RegExp(
        r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])');
    final matched = regExp.allMatches(textVal);
    if (matched.isEmpty || matched.length > 3) return false;
    final String emojis = matched.map((z) => z.group(0)).toList().join('');
    if (emojis != textVal) return false;
    return true;
  }

  bool get isReacted => message.value.authUserReaction != null;

  EdgeInsets get mainPadding {
    if (type == IrisBubbleType.bottom || type == IrisBubbleType.topAndBottom) {
      return const EdgeInsets.only(
          left: 7.0,
          right: 15,
          bottom:
              10); //note this bottom 10 padding is intentional this is what imessage does
    }
    return const EdgeInsets.only(left: 7.0, right: 15, bottom: 1);
  }

  double get maxWidth {
    if (message.value.value!.length > 400) {
      return .68;
    }
    return (hasAttachment || hasSharedText) ? 0.73 : 0.6;
  }

  bool get sharedTextDeleted {
    if (message.value.sharedText != null &&
        message.value.sharedText!.value == null) {
      if (message.value.sharedText!.order == null &&
          message.value.sharedText!.article == null) return true;
      return false;
    }
    return false;
  }

  Widget bubble(bool isOverlay) {
    return Builder(builder: (context) {
      final id = uuid.v4();
      final textScale = MediaQuery.of(context).textScaleFactor;
      final fontSize = textScale * 17;
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // if (showReactions) reactions(),
          Flexible(
            child: Obx(() => IrisBubble(
                  onDoubleTapMessage: () {
                    controller.reactToPost(message, reaction: 'like');
                  },
                  showReactionContainer:
                      message.value.numberOfReactions != null &&
                          message.value.numberOfReactions! > 0,
                  reactionButton: likeButton(),
                  isLast: isLast,
                  isSender: isSender,
                  bubbleColor: controller.likeBackgroundColor(
                      message, context.isDarkMode),
                  avatarPadding: !isPrivateMessage,
                  type: hasTwoBubbles ? IrisBubbleType.middle : type,
                  uniformBubbleMargin:
                      (message.value.sharedText != null) ? true : false,
                  showAvatar: !isPrivateMessage &&
                      !hasTwoBubbles &&
                      (type == IrisBubbleType.bottom ||
                          type == IrisBubbleType.topAndBottom),
                  showName: !isPrivateMessage &&
                      (type == IrisBubbleType.top ||
                          type == IrisBubbleType.topAndBottom),
                  color: !hasSharedText && isMessageValueEmoji
                      ? Colors.transparent
                      : context.isDarkMode
                          ? Colors.grey[900]!
                          : const Color(0xffdfdfdf),
                  isAttachment: hasAttachment,
                  isSharedText: hasSharedText,
                  isMessageAllEmojis: isMessageValueEmoji,
                  status: () {
                    if (isSending) {
                      return BubbleStatus.loading;
                    } else {
                      return BubbleStatus.none;
                    }
                  }(),
                  maxWidth: maxWidth,
                  text: Column(
                    children: [
                      if (hasAttachment)
                        MessageAttachment(
                          text: message.value,
                          isSender: isSender,
                        ),
                      if (hasMessageValue && !hasSharedText && !hasAttachment)
                        RichTextEditor(
                          originalText: message.value.value,
                          text: message.value.value ?? '',
                          richTextStyleType: isSender
                              ? RICH_TEXT_STYLE.LIGHT_COLOR
                              : RICH_TEXT_STYLE.NORMAL,
                          style: TextStyle(
                            fontSize:
                                isMessageValueEmoji ? fontSize + 30 : fontSize,
                            color: isSender
                                ? Colors.white
                                : context.theme.colorScheme.secondary,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      if (hasSharedText)
                        SharedMessageText(
                          text: message.value.sharedText,
                          fromCollectionKey: fromCollectionKey,
                          irisEvent: Get.find(),
                        ),
                    ],
                  ),
                  name: message.value.user?.fullName ?? '',
                  avatar: UserImage(
                    radius: 14,
                    user: message.value.user!,
                  ),
                )),
          ),
          if (hasTwoBubbles && !sharedTextDeleted)
            Padding(
              padding: const EdgeInsets.only(top: 1),
              child: IrisBubble(
                onDoubleTapMessage: () {},
                showReactionContainer: false,
                avatarPadding: !isPrivateMessage,
                isLast: isLast,
                bubbleColor:
                    controller.likeBackgroundColor(message, context.isDarkMode),
                reactionButton: likeButton(),
                isSender: isSender,
                showAvatar: !isPrivateMessage &&
                    (type == IrisBubbleType.bottom ||
                        type == IrisBubbleType.topAndBottom),
                showName: false,
                type: type,
                color: isMessageValueEmoji
                    ? Colors.transparent
                    : context.isDarkMode
                        ? Colors.grey[900]!
                        : const Color(0xffdfdfdf),
                isMessageAllEmojis: isMessageValueEmoji,
                status: () {
                  if (isSending) {
                    return BubbleStatus.loading;
                  } else {
                    return BubbleStatus.none;
                  }
                }(),
                text: Column(
                  children: [
                    RichTextEditor(
                      originalText: message.value.value,
                      text: message.value.value ?? '',
                      style: TextStyle(
                        fontSize:
                            isMessageValueEmoji ? fontSize + 30 : fontSize,
                        color: isSender
                            ? Colors.white
                            : context.theme.colorScheme.secondary,
                      ),
                      richTextStyleType: isSender
                          ? RICH_TEXT_STYLE.LIGHT_COLOR
                          : RICH_TEXT_STYLE.NORMAL,
                    ),
                  ],
                ),
                name: message.value.user?.fullName ?? '',
                avatar: UserImage(
                  radius: 14,
                  user: message.value.user!,
                ),
              ),
            ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
            visible: showDate,
            child: SizedBox(
              height: 30,
              child: Center(
                child: Text(
                  message.value.dateCompact,
                  style: TextStyle(
                      color:
                          context.theme.colorScheme.secondary.withOpacity(.5)),
                ),
              ),
            )),
        Padding(
          padding: mainPadding,
          child: IrisCupertinoContextMenu(
            header: reactions(),
            contextMenuLocation:
                isSender ? ContextMenuLocation.right : ContextMenuLocation.left,
            previewBuilder: (context, animation, widget) {
              return Material(
                color: Colors.transparent,
                child: bubble(true),
              );
            },
            actions: [
              IrisCupertinoContextMenuAction(
                trailingIcon: CupertinoIcons.doc_on_doc,
                child: const Text('Copy text'),
                onPressed: () {
                  Clipboard.setData(ClipboardData(
                    text: message.value.value,
                  ));
                  Get.back();
                  Get.snackbar('Success', 'Message copied to clipboard');
                },
              ),
              if (message.value.authUserReaction != null)
                IrisCupertinoContextMenuAction(
                  trailingIcon: CupertinoIcons.delete,
                  child: const Text('Remove reaction'),
                  onPressed: () {
                    controller.reactToPost(message, reaction: null);
                    Get.back();
                  },
                ),
              IrisCupertinoContextMenuAction(
                trailingIcon: CupertinoIcons.multiply_circle,
                child: const Text('Cancel'),
                onPressed: () {
                  Get.back();
                },
              ),
            ],
            child: Material(
              color: Colors.transparent,
              child: GestureDetector(
                child: bubble(false),
                onDoubleTap: () =>
                    controller.reactToPost(message, reaction: 'like'),
              ),
            ),
          ),

          // likeButton(),
          //     Visibility(
          //       visible: isLast,
          //       child: iconTick != Icons.alarm
          //           ? Container(
          //               height: !isSender ? 0 : 0,
          //             )
          //           : Text('Sending...'),
          //     ),
          //   ],
          // ),
        ),
      ],
    );
  }

  Widget likeButton() {
    return Builder(builder: (context) {
      return Align(
        alignment: Alignment.center,
        child: Visibility(
          visible: message.value.numberOfReactions != null &&
              message.value.numberOfReactions! > 0,
          child: Padding(
            padding: EdgeInsets.zero,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                LikeButton(
                  unselectedColor:
                      context.theme.colorScheme.secondary.withOpacity(.8),
                  showReactions: true,
                  showNumber: false,
                  text$: message,
                  showIcon: true,
                  color: controller.likeColor(message, context.isDarkMode),
                  onPressed: (reaction) =>
                      controller.reactToPost(message, reaction: null),
                  isBubble: true,
                ),
                const SizedBox(
                  width: 2,
                ),
                Visibility(
                  visible: message.value.numberOfReactions != null &&
                      message.value.numberOfReactions! > 0,
                  child: Text(
                    '${message.value.numberOfReactions}',
                    style: TextStyle(
                        color:
                            controller.likeColor(message, context.isDarkMode),
                        fontSize: 12),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget reactedIcon() {
    final authReaction = message.value.authUserReaction;
    if (authReaction == null) return Container();

    if (authReaction.reactionKind == REACTION_KIND.LIKE) {
      return const Icon(
        IrisIcon.like,
        color: IrisColor.lighterPrimaryColor,
      );
    } else if (authReaction.reactionKind == REACTION_KIND.HAHA) {
      return reaction(icon: 'haha.png', height: 20);
    } else if (authReaction.reactionKind == REACTION_KIND.SAD) {
      return reaction(icon: 'sad.png', height: 20);
    } else if (authReaction.reactionKind == REACTION_KIND.ANGRY) {
      return reaction(icon: 'angry.png', height: 20);
    } else if (authReaction.reactionKind == REACTION_KIND.WOW) {
      return reaction(icon: 'wow.png', height: 20);
    } else {
      return const Icon(
        IrisIcon.like,
        color: IrisColor.lighterPrimaryColor,
      );
    }
  }

  Widget reaction({required String icon, double height = 40}) {
    return GestureDetector(
      onTap: () {
        controller.reactToPost(message, reaction: icon);
        Get.back();
      },
      child: Image.asset(
        'assets/emoji/' + icon + '.gif',
        height: height,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget reactions() {
    return Builder(
      builder: (context) => Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: kContainerHeight,
            margin: EdgeInsets.symmetric(vertical: isReacted ? 5 : kPadding),
            width: context.width * 0.67,
            decoration: BoxDecoration(
              color: const Color(0xFF3E3A41),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: reactionList
                  .map((reactionName) => reaction(icon: reactionName))
                  .toList(),
            ),
          ),
          Positioned(
            right: 16,
            bottom: 0,
            child: Container(
              height: 12,
              width: 12,
              decoration: BoxDecoration(
                color: const Color(0xFF3E3A41),
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
          Positioned(
            right: 15,
            bottom: -5,
            child: Container(
              height: 5,
              width: 5,
              decoration: BoxDecoration(
                color: const Color(0xFF3E3A41),
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
