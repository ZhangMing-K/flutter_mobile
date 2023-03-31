import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:iris_mobile/app/modules/feed/shared/widgets/text_card/text_card.dart';

import '../../shared/widgets/post_input/post_input.dart';
import 'text_controller.dart';

class TextMobileScreen extends GetWidget<TextController> {
  const TextMobileScreen({Key? key}) : super(key: key);

  Widget body() {
    return Column(
      children: [
        Expanded(
          child: controller.obx(
            (state) => ScrollListView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              scrollController: controller.scrollController,
              children: [
                TextCard(
                  text: controller.text$,
                  textCardDisplayType: TEXT_CARD_DISPLAY_TYPE.FULL,
                ),
              ],
            ),
            onLoading: const IrisLoading(),
            onEmpty: Container(),
          ),
        ),
        input()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      color: context.theme.backgroundColor,
      padding: context.isKeyboardOpen
          ? EdgeInsets.zero
          : const EdgeInsets.only(bottom: 36.0),
      child: SafeArea(
        top: false,
        child: Scaffold(
          body: IrisTabView.expanded(
            showBackButton: true,
            keyboardHidesTabbar: false,
            horizontalPadding: 0,
            tabs: [
              IrisTab(
                text: controller.titleText,
                body: main(),
              )
            ],
            backgroundColor: context.theme.scaffoldBackgroundColor,
          ),
        ),
      ),
    );
  }

  Widget main() {
    return Obx(
        () => controller.notAvailable$.value == true ? deleted() : body());
  }

  Widget deleted() {
    return Obx(() {
      final text = controller.notAvailableText$.value;
      return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Container(
                padding: const EdgeInsets.only(bottom: 40, top: 20),
                child: Builder(builder: (context) {
                  return Text(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: context.theme.colorScheme.secondary,
                      fontWeight: FontWeight.w700,
                    ),
                  );
                })),
            const IrisEmpty(
              emptyText: 'Sorry!',
            )
          ]));
    });
  }

  Widget input() {
    return PostInput(
      submitName: 'Comment',
      controller: controller.postInput,
      isComment: controller.isComment$.value,
      hintText: 'Comment...',
      onTyping: () {},
    );
  }
}
