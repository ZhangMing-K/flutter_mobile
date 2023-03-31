import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:iris_common/shared/widgets/app_easy_rich_text/index.dart';
import 'package:iris_common/shared/widgets/like_button/like_button.dart';
import 'package:iris_common/shared/widgets/reacted_by/index.dart';
import 'package:iris_mobile/widgets_v2/pannels/text_settings_pannel/text_setting_pannel_data.dart';
import 'package:iris_mobile/widgets_v2/pannels/text_settings_pannel/text_settings_pannel.dart';

import 'text_card_controller.dart';
import 'video_controller.dart';

//TODO: refactor this resource
class CommentCard extends StatefulWidget {
  final CommentCardController controller;
  final isExpand = false.obs;
  final bool isHint;

  CommentCard({
    Key? key,
    required TextModel comment,
    required TextCardController textCardController,
    this.isHint = false,
  })  : controller = CommentCardController(),
        super(key: key) {
    controller.textCardController = textCardController;
    controller.comment.value = comment;
  }

  @override
  _CommentCardState createState() => _CommentCardState();
}

class CommentCardController extends GetxController {
  final Rx<TextModel?> comment = Rx<TextModel?>(null);
  TextCardController? textCardController;
  TextSettingsPannelData? pannelData;
  IAuthUserService authUserStore = Get.find();
  final IrisEvent irisEvent = Get.find();

  final String id = uuid.v4();

  final String showMoreTag = '... <C {"type":"showMore","value":"see"}>SEE</C>';

  final isLongPress = false.obs;
  final maxLength = 100;
  final ReactionService reactionService = Get.find();
  final isReacted = false.obs;

  String? get cutText => RichEditTextUtils.getCutText(text ?? '', maxLength);

  bool get isShowMore =>
      RichEditTextUtils.needShowMore(comment.value!.value ?? '', maxLength) ??
      false;

  String? get text => comment.value!.value;

  void onLongPress() {
    isLongPress.toggle();
    Get.focusScope!.unfocus();
    pannelData ??= TextSettingsPannelData(
      authUser: authUserStore.loggedUser,
      text: comment.value,
    );

    HapticFeedback.mediumImpact();

    TextSettingPannel.openPannel(
      text: comment,
      pannelData: pannelData!,
      textCardController: textCardController,
    );
  }

  void onLongPressEnd() {
    isLongPress.toggle();
  }

  void performReaction() {
    isReacted.value = true;
    HapticFeedback.lightImpact();
    Future.delayed(
        const Duration(milliseconds: 700), () => isReacted.value = false);
  }

  Future<void> reactToPost() async {
    debugPrint('react to post');
    if (comment.value!.authUserReaction == null) {
      performReaction();
    }
    Reaction? newReaction;
    if (comment.value!.authUserReaction == null) {
      newReaction = const Reaction();
      comment.value = comment.value!.copyWith(
          numberOfReactions: comment.value!.numberOfReactions! + 1,
          authUserReaction: newReaction);
    } else {
      newReaction = null;
      comment.value = comment.value!.copyWith(
          numberOfReactions: comment.value!.numberOfReactions! - 1,
          authUserReaction: newReaction);
    }
    await reactionService.reactToText(
        reactionKind: REACTION_KIND.LIKE, textKey: comment.value!.textKey);
  }
}

class CommentCardHint extends StatelessWidget {
  final TextModel comment;

  final TextCardController textCardController;
  final isExpand = false.obs;

  CommentCardHint({
    Key? key,
    required this.comment,
    required this.textCardController,
  }) : super(key: key);

  Widget body() {
    return Builder(
      builder: (context) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          UserName(
            user: comment.user,
            fontWeight: FontWeight.bold,
          ),
          // SizedBox(
          //   width: 4,
          // ),
          Flexible(
            child: RichTextEditor(
              originalText: ':  ${comment.value!}',
              maxLines: 1,
              text: ':  ${comment.value!}',
              style: TextStyle(
                  fontSize: 13, color: context.theme.colorScheme.secondary),
              showMore: () {},
            ),
          ) // using custom rich text
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return commentCard();
  }

  Widget commentCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileImage(
            radius: 9,
            url: comment.user!.profilePictureUrl,
            uuid: uuid.v4(),
          ),
          const SizedBox(
            width: 2,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                body(),
                giffs(),
                files(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget files() {
    if (comment.taggedFiles == null || comment.taggedFiles!.isEmpty) {
      return Container();
    } else {
      // return Container();
      final FileModel file = comment.taggedFiles![0];
      if (file.fileType == FILE_TYPE.IMAGE) {
        return Container(
          margin: const EdgeInsets.only(top: 5),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxHeight: 130.0,
            ),
            child: CachedNetworkImage(
                imageUrl: file.url!,
                cacheManager: Get.find<IrisImageCacheManager>()),
          ),
        );
      } else if (file.fileType == FILE_TYPE.VIDEO && file.url != null) {
        return SizedBox(
          width: 150,
          height: 300,
          child: ChewiePlayer(
              url: file.url!,
              showBottom: false,
              text: comment,
              topContainer: Container(),
              statContainer: Container(),
              textCardController: textCardController),
        );
      }
    }

    return Container();
  }

  Widget giffs() {
    if (comment.taggedGiffs == null || comment.taggedGiffs!.isEmpty) {
      return Container();
    }
    final Giff giff = comment.taggedGiffs![0];
    Widget giphyBranding = const SizedBox.shrink();
    var isGiphy = false;
    if (giff.url!.contains('giphy.com/media/')) {
      // giffs start wih media0.com or media2.com
      isGiphy = true;
      giphyBranding = Column(children: [
        const SizedBox(
          height: 4,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 0),
          child: Image.asset(
            Images.giphyBranding,
            height: 7,
          ),
        )
      ]);
    }

    return Container(
      margin: const EdgeInsets.only(top: 5),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxHeight: 130.0,
              maxWidth: 100.0,
            ),
            child: CachedNetworkImage(
                imageUrl: giff.url!,
                cacheManager: Get.find<IrisImageCacheManager>()),
          ),
          if (isGiphy) giphyBranding,
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

class _CommentCardState extends State<CommentCard>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  actionRow() {
    return Container(
      margin: const EdgeInsets.only(left: 10, top: 2),
      child: Row(
        children: [
          Text(
            widget.controller.comment.value!.dateFromAbb,
            style:
                const TextStyle(fontSize: 12, color: IrisColor.dateFromColor),
          ),
          LikeButton(
            text$: widget.controller.comment,
            showIcon: false,
            fontSize: 13,
            color: widget.controller.comment.value!.authUserReaction != null
                ? IrisColor.primaryColor
                : null,
            onPressed: (reaction) => widget.controller.reactToPost(),
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: ReactedBy(
                    text$: widget.controller.comment,
                    fontSize: 12,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget body(String id) {
    return Obx(() {
      final isExpanded = widget.isExpand.value;
      final comment = widget.controller.comment.value;
      widget.controller.textCardController!.text$!.value;
      return GestureDetector(
        onLongPress: widget.controller.onLongPress,
        onLongPressEnd: (val) {
          widget.controller.onLongPressEnd();
        },
        onDoubleTap: () async {
          if (comment!.authUserReaction == null) {
            widget.controller.reactToPost();
          } else {
            widget.controller.performReaction();
          }
          animationController.forward();
          Future.delayed(const Duration(milliseconds: 100), () {
            animationController.reverse();
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
              color: context.theme.backgroundColor,
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UserName(
                user: comment!.user,
                fontWeight: FontWeight.w600,
                heroTag: id,
              ),
              RichTextEditor(
                originalText: widget.controller.text,
                text: widget.controller.isShowMore
                    ? (isExpanded
                        ? widget.controller.text
                        : widget.controller.cutText! +
                            widget.controller.showMoreTag)
                    : widget.controller.text,
                style: TextStyle(
                    fontSize: 14, color: context.theme.colorScheme.secondary),
                showMore: () {
                  widget.isExpand.value = true;
                  final int textKey = widget.controller.comment.value!.textKey!;
                  widget.controller.irisEvent.registerTextEvent(
                      textEventType: TEXT_EVENT_ACTION.SEE_MORE,
                      textKey: textKey);
                },
              ) // using custom rich text
            ],
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetX<CommentCardController>(
      init: widget.controller,
      global: false,
      builder: (controller) {
        return Stack(
          alignment: Alignment.center,
          children: [
            commentCard(),
            IgnorePointer(
              //this icon was sometimes preventing double tap from being registered
              child: IrisIconAnimation(
                isLiked: widget.controller.isReacted.value,
                child: Icon(
                  IrisIcon.like,
                  color: context.theme.colorScheme.secondary,
                ),
              ),
            )
          ],
        );
      },
    );
  }

  commentCard() {
    final id = uuid.v4();
    return ListTile(
      horizontalTitleGap: 0,
      leading: Container(
        width: 30,
        alignment: Alignment.topLeft,
        child: UserImage(
          radius: 15,
          id: id, //widget.controller.id,
          user: widget.controller.comment.value!.user!,
        ),
      ),
      trailing: Container(
          width: 50,
          margin: const EdgeInsets.only(left: 20, bottom: 15),
          alignment: Alignment.centerRight,
          child: LikeButton(
            color: IrisColor.lighterPrimaryColor,
            height: kIconSize,
            text$: widget.controller.comment,
            onPressed: (data) => widget.controller.reactToPost(),
            animationController: animationController,
          )),
      title: title(id),
    );
  }

  @override
  void dispose() {
    animationController.removeListener(_listener);
    animationController.dispose();
    super.dispose();
  }

  Widget files() {
    if (widget.controller.comment.value!.taggedFiles == null ||
        widget.controller.comment.value!.taggedFiles!.isEmpty) {
      return Container();
    } else {
      // return Container();
      final FileModel file = widget.controller.comment.value!.taggedFiles![0];
      if (file.fileType == FILE_TYPE.IMAGE) {
        return Container(
          margin: const EdgeInsets.only(top: 5),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxHeight: 130.0,
            ),
            child: FullScreenWidget(
              url: file.url,
              tag: widget.controller.id,
              child: Hero(
                  tag: widget.controller.id,
                  child: CachedNetworkImage(
                      imageUrl: file.url!,
                      cacheManager: Get.find<IrisImageCacheManager>())),
            ),
          ),
        );
      } else if (file.fileType == FILE_TYPE.VIDEO && file.url != null) {
        return SizedBox(
          width: 150,
          height: 300,
          child: ChewiePlayer(
              url: file.url!,
              showBottom: false,
              text: widget.controller.comment.value,
              topContainer: Container(),
              statContainer: Container(),
              textCardController: widget.controller.textCardController),
        );
      }
    }

    return Container();
  }

  Widget giffs() {
    if (widget.controller.comment.value!.taggedGiffs == null ||
        widget.controller.comment.value!.taggedGiffs!.isEmpty) {
      return Container();
    }
    final Giff giff = widget.controller.comment.value!.taggedGiffs![0];
    Widget giphyBranding = const SizedBox.shrink();
    var isGiphy = false;
    if (giff.url!.contains('giphy.com/media/')) {
      // giffs start wih media0.com or media2.com
      isGiphy = true;
      giphyBranding = Column(children: [
        const SizedBox(
          height: 4,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 0),
          child: Image.asset(
            Images.giphyBranding,
            height: 7,
          ),
        )
      ]);
    }

    return Container(
      margin: const EdgeInsets.only(top: 5),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxHeight: 130.0,
              maxWidth: 100.0,
            ),
            child: FullScreenWidget(
              url: giff.url,
              tag: widget.controller.id,
              child: Hero(
                  tag: widget.controller.id,
                  child: CachedNetworkImage(
                      imageUrl: giff.url!,
                      cacheManager: Get.find<IrisImageCacheManager>())),
            ),
          ),
          if (isGiphy) giphyBranding,
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      lowerBound: 0.0,
      upperBound: .75,
    )..addListener(_listener);
  }

  Widget title(String id) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        body(id),
        giffs(),
        files(),
        if (!widget.isHint) actionRow(),
      ],
    );
  }

  void _listener() {
    if (mounted) {
      setState(() {});
    }
  }
}
