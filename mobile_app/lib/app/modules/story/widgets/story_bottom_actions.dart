import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:iris_common/shared/widgets/like_button/like_button.dart';
import 'package:iris_mobile/app/routes/pages.dart';
import 'package:unicons/unicons.dart';

import '../../feed/shared/widgets/text_card/share_text_bottom_sheet/share_text_controller.dart';
import '../../feed/shared/widgets/text_card/share_text_bottom_sheet/share_text_view.dart';

class StoryBottomActions extends StatelessWidget {
  const StoryBottomActions({
    Key? key,
    required this.text$,
    this.animationController,
    required this.onLike,
  }) : super(key: key);
  final Rx<TextModel> text$;
  final AnimationController? animationController;
  final void Function() onLike;

  @override
  Widget build(BuildContext context) {
    return (text$.value.textKey == null)
        ? Center(child: Container())
        : Container(
            color: Colors.transparent,
            margin: const EdgeInsets.symmetric(
              horizontal: 32,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                comment(text$),
                LikeButton(
                    hasCircle: true,
                    color: IrisColor.lighterPrimaryColor,
                    height: 40,
                    // kIconSize * 1.5,
                    text$: text$,
                    onPressed: (reaction) => onLike()),
                share(text$)
              ],
            ),
          );
  }

  Widget share(Rx<TextModel> text) {
    return Builder(
        builder: (context) => InkWell(
              onTap: () {
                final ShareTextController sharedTextController =
                    ShareTextController(
                        inboxRepository: Get.find(),
                        chatRepository: Get.find(),
                        sharedText: text);
                Get.bottomSheet(
                  DraggableScrollableSheet(
                    minChildSize: 0.5,
                    maxChildSize: 0.8,
                    initialChildSize: 0.6,
                    expand: true,
                    builder: (context, scrollController) {
                      return ShareTextView(
                          controller: sharedTextController,
                          scrollController: scrollController);
                    },
                  ),
                  isScrollControlled: true,
                );
              },
              child: Row(
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        color: context.theme.backgroundColor,
                        borderRadius: BorderRadius.circular(30)),
                    child: Icon(
                      UniconsLine.upload,
                      size: kIconSize,
                      color:
                          context.theme.colorScheme.secondary.withOpacity(.8),
                    ),
                  ),
                ],
              ),
            ));
  }

  Widget comment(Rx<TextModel> text) {
    return Builder(
        builder: (context) => InkWell(
              onTap: () {
                Navigator.pop(context);
                Get.toNamed(Paths.Text.createPath([text.value.textKey]),
                    arguments: TextScreenArgs(text: text, isComment: true),
                    id: 1);
              },
              child: Row(
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        color: context.theme.backgroundColor,
                        borderRadius: BorderRadius.circular(30)),
                    child: Icon(
                      UniconsLine.comment,
                      size: kIconSize,
                      color:
                          context.theme.colorScheme.secondary.withOpacity(.8),
                    ),
                  ),
                ],
              ),
            ));
  }
}
