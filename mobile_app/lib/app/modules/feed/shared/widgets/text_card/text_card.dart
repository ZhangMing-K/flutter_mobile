import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:iris_common/shared/widgets/like_button/like_button.dart';
import 'package:iris_common/shared/widgets/reacted_by/index.dart';
import 'package:unicons/unicons.dart';

import 'SharedMessageText/shared_message_text.dart';
import 'announcement_text.dart';
import 'article_text.dart';
import 'comment_card.dart';
import 'order_text.dart';
import 'post_text.dart';
import 'share_text_bottom_sheet/share_text_controller.dart';
import 'share_text_bottom_sheet/share_text_view.dart';
import 'text_card_controller.dart';

enum TEXT_CARD_DISPLAY_TYPE { FULL, SUMMARY, STORY, CONTENT_ONLY, IMAGE_SHARE }

class TextCard extends StatefulWidget {
  final Rx<TextModel?>? text;
  final TEXT_CARD_DISPLAY_TYPE textCardDisplayType;
  final bool isShareable;
  final Function(TextModel order)? setSharingOrder;
  final bool showHint;
  final VoidCallback? onFollowTapped;
  final Asset? asset; // for articles post, the top part

  const TextCard({
    Key? key,
    required this.text,
    this.textCardDisplayType = TEXT_CARD_DISPLAY_TYPE.SUMMARY,
    this.showHint = false,
    this.setSharingOrder,
    this.isShareable = false,
    this.onFollowTapped,
    this.asset,
  }) : super(key: key);

  @override
  _TextCardState createState() => _TextCardState();
}

class _TextCardState extends State<TextCard>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  late TextCardController controller;

  int get numberOfComments {
    final value = controller.text$?.value;
    return value?.numberOfComments ?? 0;
  }

  int get numberOfReactions {
    final value = controller.text$?.value;
    return value?.numberOfReactions ?? 0;
  }

  onClickItem(Rx<TextModel?> item) {
    final ShareTextController sharedTextController = ShareTextController(
        inboxRepository: Get.find(),
        chatRepository: Get.find(),
        sharedText: item);
    Get.bottomSheet(
      DraggableScrollableSheet(
        minChildSize: 0.5,
        maxChildSize: 0.90,
        initialChildSize: 0.75,
        expand: true,
        builder: (context, scrollController) {
          return ShareTextView(
              controller: sharedTextController,
              scrollController: scrollController);
        },
      ),
      isScrollControlled: true,
    );
  }

  actionRow() {
    if (widget.textCardDisplayType == TEXT_CARD_DISPLAY_TYPE.STORY ||
        widget.textCardDisplayType == TEXT_CARD_DISPLAY_TYPE.IMAGE_SHARE ||
        widget.textCardDisplayType == TEXT_CARD_DISPLAY_TYPE.CONTENT_ONLY) {
      return const SizedBox.shrink();
    }

    final noBottomPadding = (numberOfComments == 0 && numberOfReactions == 0);

    return Container(
      margin: EdgeInsets.only(
        left: 6,
        right: 16,
        top: 6,
        bottom: noBottomPadding ? 6 : 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          LikeButton(
            color: IrisColor.lighterPrimaryColor,
            height: kIconSize,
            text$: controller.text$,
            onPressed: (reaction) => controller.reactToPost(),
            animationController: animationController,
          ),
          comment(),
          InkWell(
            child: TouchableArea(
                child: Icon(
              UniconsLine.upload,
              size: kIconSize,
              color: context.theme.colorScheme.secondary.withOpacity(.8),
            )),
            onTap: () {
              if (widget.setSharingOrder != null) {
                // set sharing order from recent orders bottom sheet in message page.
                widget.setSharingOrder!(controller.text$!.value!);
                Get.back();
              }
              if (widget.setSharingOrder == null) {
                // opens share text bottom sheet
                onClickItem(controller.text$!);
              }
            },
          ),
          const Expanded(
            child: SizedBox(),
          ),
          const SizedBox(width: 10),
          if (!widget.isShareable)
            StatefulBuilder(builder: (_, update) {
              return IrisBounceButton(
                duration: const Duration(milliseconds: 100),
                onPressed: () {
                  HapticFeedback.lightImpact();
                  controller.markSaved();
                  update(() {});
                },
                child: Builder(builder: (context) {
                  return TouchableArea(
                      child: Icon(
                    UniconsLine.bookmark,
                    size: kIconSize,
                    color: controller.isSaved
                        ? IrisColor.primaryColor
                        : context.theme.colorScheme.secondary.withOpacity(.8),
                  ));
                }),
              );
            }),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Visibility(
          visible: controller.isVisible.isTrue,
          child: StatefulWrapper(
              seenDuration: const Duration(milliseconds: 750),
              onSeen: controller.onSeen,
              child: view()),
        );
      },
    );
  }

  Widget comment() {
    if (widget.textCardDisplayType == TEXT_CARD_DISPLAY_TYPE.IMAGE_SHARE ||
        widget.textCardDisplayType == TEXT_CARD_DISPLAY_TYPE.STORY) {
      return Container();
    }
    return InkWell(
      onTap: () {
        if (widget.textCardDisplayType == TEXT_CARD_DISPLAY_TYPE.FULL) {
        } else if (widget.textCardDisplayType != TEXT_CARD_DISPLAY_TYPE.FULL) {
          Get.toNamed(Paths.Text.createPath([controller.text$!.value!.textKey]),
              arguments: TextScreenArgs(text: controller.text$!), id: 1);
        }
      },
      child: Row(
        children: [
          TouchableArea(
              child: Icon(
            UniconsLine.comment,
            size: kIconSize,
            color: context.theme.colorScheme.secondary.withOpacity(.8),
          )),
        ],
      ),
    );
  }

  Widget commentHint() {
    final comments = widget.text?.value?.comments;
    if (comments != null && comments.isNotEmpty) {
      final hintComment = comments.first;
      return InkWell(
        onTap: () {
          if (widget.textCardDisplayType != TEXT_CARD_DISPLAY_TYPE.FULL) {
            Get.toNamed(Paths.Text.createPath([widget.text!.value!.textKey]),
                arguments: TextScreenArgs(text: widget.text!), id: 1);
          }
        },
        child: Column(
          children: [
            const SizedBox(
              height: 2.0,
            ),
            const SizedBox(
              height: 2.0,
            ),
            CommentCardHint(
              comment: hintComment,
              textCardController: controller,
            ),
          ],
        ),
      );
    }

    return const SizedBox.shrink();
  }

  Widget commentSection() {
    return Obx(() {
      controller.comments.sort((a, b) {
        return a.orderedCreatedAt!.compareTo(b.orderedCreatedAt!);
      });

      final List<Widget> list = [
        Divider(
          color: context.theme.backgroundColor,
          thickness: 1,
          indent: 10,
          endIndent: 10,
        ),
      ];
      if (controller.text!.numberOfComments! > controller.comments.length) {
        final int moreCommentsNum =
            controller.text!.numberOfComments! - controller.comments.length;
        list.add(moreComments(moreCommentsNum));
      }
      for (var element in controller.comments) {
        list.add(CommentCard(
          comment: element,
          textCardController: controller,
        ));
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ...list,
          const SizedBox(
            height: 5,
          )
        ],
      );
    });
  }

  String commentsLengthToText(int moreCommentsNum) {
    String text = '';
    if (moreCommentsNum >= 10) {
      text = 'view 10 more comments';
    } else if (moreCommentsNum == 1) {
      text = 'view 1 more comment';
    } else {
      text = 'view $moreCommentsNum more comments';
    }
    return text;
  }

  @override
  void didUpdateWidget(TextCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.text != oldWidget.text) {
      controller = TextCardController(widget.text);
    }
  }

  @override
  void dispose() {
    animationController.removeListener(_listener);
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = TextCardController(widget.text);

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      lowerBound: 0.0,
      upperBound: .75,
    )..addListener(_listener);
  }

  Widget main() {
    if (controller.text$!.value!.textType == TEXT_TYPE.POST) {
      Widget? newStatRow;
      final taggedFiles = controller.text$!.value?.taggedFiles;
      if (taggedFiles == null || taggedFiles.isEmpty) {
        newStatRow = null;
      } else {
        final fileType = taggedFiles[0].fileType;
        if (fileType == FILE_TYPE.VIDEO) {
          newStatRow = statRow(isVideo: true);
        }
      }

      return Obx(() {
        return PostText(
          controller: controller,
          text: controller.text$!.value,
          onDoubleTap: onDoubleTap,
          statRow: newStatRow,
          textCardDisplayType: widget.textCardDisplayType,
          showMore: controller.showMore,
          onFollowTapped: widget.onFollowTapped,
        );
      });
    } else if (controller.text$!.value!.textType == TEXT_TYPE.ORDER) {
      return Obx(() => widget.isShareable
          ? Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: SharedMessageText(
                text: controller.text$!.value,
                onTap: () {
                  if (widget.setSharingOrder != null) {
                    // set sharing order from recent orders bottom sheet in message page.
                    widget.setSharingOrder!(controller.text$!.value!);
                    Get.back();
                  }
                },
                irisEvent: Get.find(),
              ))
          : OrderText(
              controller: controller,
              text: controller.text$!.value,
              onDoubleTap: onDoubleTap,
              showMore: controller.showMore,
              textCardDisplayType: widget.textCardDisplayType,
              onFollowTapped: widget.onFollowTapped,
            ));
    } else if (controller.text$!.value!.textType == TEXT_TYPE.ASSET_ARTICLE) {
      return Obx(() => ArticleText(
            text: controller.text$!.value,
            onDoubleTap: onDoubleTap,
          ));
      // } else if (controller.text$!.value!.textType == TEXT_TYPE.ARTICLE &&
      //     widget.textCardDisplayType == TEXT_CARD_DISPLAY_TYPE.STORY) {
      //   // Article page shown in story
      //   return Obx(() => ArticleV2Text(
      //         text: controller.text$!.value,
      //         onDoubleTap: onDoubleTap,
      //         textCardDisplayType: widget.textCardDisplayType,
      //       ));
    } else if (controller.text$!.value!.textType == TEXT_TYPE.ARTICLE &&
        widget.textCardDisplayType == TEXT_CARD_DISPLAY_TYPE.FULL) {
      // Article details page when user clicks on comment
      return Obx(() => ArticleText(
          text: controller.text$!.value,
          onDoubleTap: onDoubleTap,
          assetFromArg: widget.asset));
    } else if (controller.text$!.value!.textType == TEXT_TYPE.ARTICLE &&
        widget.textCardDisplayType == TEXT_CARD_DISPLAY_TYPE.SUMMARY) {
      // Article shown in Feed page
      return Obx(() => ArticleText(
          text: controller.text$!.value,
          onDoubleTap: onDoubleTap,
          assetFromArg: widget.asset));
    } else if (controller.text$!.value!.textType == TEXT_TYPE.ANNOUNCEMENT) {
      return Obx(() => AnnouncementText(text: controller.text$!.value));
    }
    return Container();
  }

  Widget moreComments(int moreCommentsNum) {
    if (moreCommentsNum == 0) {
      return Container();
    }

    final text = commentsLengthToText(moreCommentsNum);

    return InkWell(
      onTap: () {
        controller.commentsGet();
      },
      child: Container(
          padding:
              const EdgeInsets.only(left: 15, top: 5, bottom: 5, right: 15),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
          )),
    );
  }

  onDoubleTap() {
    if (controller.text$!.value!.authUserReaction == null) {
      //if not already liked, make server request and like
      controller.reactToPost();
    } else {
      //else, just perform the animation
      controller.performReaction();
    }
    //make thumbs up icon bounce
    animationController.forward();
    Future.delayed(const Duration(milliseconds: 100), () {
      animationController.reverse();
    });
  }

  Widget statRow({isVideo = false}) {
    if (widget.textCardDisplayType == TEXT_CARD_DISPLAY_TYPE.IMAGE_SHARE ||
        widget.textCardDisplayType == TEXT_CARD_DISPLAY_TYPE.STORY) {
      return Container();
    }
    return viewReactions(isVideo: isVideo);
  }

  view() {
    final noBottomPadding = (numberOfComments == 0 && numberOfReactions == 0);

    return Obx(() => Stack(
          alignment: Alignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(
                  top: widget.textCardDisplayType !=
                          TEXT_CARD_DISPLAY_TYPE.IMAGE_SHARE
                      ? 18
                      : 0),
              // decoration: const BoxDecoration(color: Colors.blue),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  main(),
                  if (!widget.isShareable) actionRow(),
                  if (!widget.isShareable) statRow(),
                  if (widget.textCardDisplayType == TEXT_CARD_DISPLAY_TYPE.FULL)
                    commentSection()
                  else
                    Visibility(
                      visible: numberOfComments > 0,
                      child: Container(
                          margin: EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: numberOfReactions > 0 ? 8 : 0,
                          ),
                          child: viewComments()),
                    ),
                  if (!noBottomPadding)
                    const SizedBox(
                      height: 18,
                    )
                ],
              ),
            ),
            IgnorePointer(
              //this icon was sometimes preventing double tap from being registered
              child: IrisIconAnimation(
                isLiked: controller.isReacted.value,
                child: Icon(
                  IrisIcon.like,
                  color: context.theme.colorScheme.secondary,
                ),
              ),
            )
          ],
        ));
  }

  Widget viewComments() {
    if (widget.textCardDisplayType == TEXT_CARD_DISPLAY_TYPE.IMAGE_SHARE ||
        widget.textCardDisplayType == TEXT_CARD_DISPLAY_TYPE.STORY) {
      return Container();
    }
    return Obx(() {
      ///final cNum = controller.text$.value.numberOfComments ?? 0;
      Widget cNum;
      final commentLen = controller.text$!.value!.numberOfComments ?? 0;
      final style = TextStyle(
        color: Colors.grey.shade400,
        fontSize: 13,
        fontWeight: FontWeight.w400,
      );
      if (commentLen == 0) {
        return Container();
      } else if (commentLen == 1) {
        cNum = Text(
          'See 1 comment',
          style: style,
        );
      } else {
        cNum = Text(
          'See $commentLen more comments',
          style: style,
        );
      }
      return InkWell(
          onTap: () {
            if (widget.textCardDisplayType != TEXT_CARD_DISPLAY_TYPE.FULL) {
              Get.toNamed(Paths.Text.createPath([widget.text!.value!.textKey]),
                  arguments: TextScreenArgs(text: widget.text!), id: 1);
            }
          },
          child: cNum);
    });
  }

  Widget viewReactions({isVideo = false}) {
    return Visibility(
      visible: numberOfReactions > 0,
      replacement: const SizedBox.shrink(),
      child: Container(
        margin: const EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: 0,
          top: 0,
        ),
        child: ReactedBy(
          text$: controller.text$,
          isVideo: isVideo,
          fontSize: 13,
        ),
      ),
    );
  }

  void _listener() {
    if (mounted) {
      setState(() {});
    }
  }
}
