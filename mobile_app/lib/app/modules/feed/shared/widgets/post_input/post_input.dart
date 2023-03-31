import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:iris_mobile/app/modules/feed/shared/widgets/rich_text/rich_text_field.dart';
import 'package:unicons/unicons.dart';

import 'media_row.dart';
import 'post_input_controller.dart';

class PostInput extends StatelessWidget {
  final String? hintText;
  final VoidCallback onTyping;
  final bool isFullPage;
  final bool isComment;
  final String submitName;
  final PostInputController controller;
  const PostInput({
    Key? key,
    required this.controller,
    required this.submitName,
    required this.onTyping,
    this.hintText = "What's on your mind?",
    this.isFullPage = false,
    this.isComment = false,
  }) : super(key: key);

  static show({
    required FocusNode focusNode,
    TEXT_TYPE textType = TEXT_TYPE.POST,
    CreateTextType? createTextType,
    Rx<TextModel?>? text,
    String? hintText,
    required String submitName,
    required Function() onTyping,
    Function(PostInputInfo info)? onSubmit,
    bool isFullPage = false,
    bool isComment = false,
  }) {
    if (isFullPage) {
      Future(() {
        focusNode.requestFocus();
      });
      return Get.to(
        () => Scaffold(
          body: SafeArea(
            child: PostInput(
              controller: PostInputController(
                focusNode: focusNode,
                createTextType: createTextType,
                onSubmit: onSubmit,
                text: text,
                textType: textType,
              ),
              submitName: submitName,
              onTyping: onTyping,
              hintText: hintText,
              isFullPage: true,
            ),
          ),
        ),
      );

      /// Implement dialog for Web

      // return Get.dialog(
      //   Dialog(
      //     backgroundColor: Colors.transparent,
      //     child: Padding(
      //       padding: const EdgeInsets.symmetric(vertical: 30),
      //       child: ClipRRect(
      //         borderRadius: kBorderRadius,
      //         child: Theme(
      //           data: Get.theme.copyWith(
      //               scaffoldBackgroundColor: Get.theme.backgroundColor),
      //           child: Material(
      //             color: Get.theme.backgroundColor,
      //             child: KeyboardListener(
      //               resizeToAvoidBottomInset: false,
      //               child: PostInput(
      //                 focusNode: focusNode,
      //                 createTextType: createTextType,
      //                 onSubmit: onSubmit,
      //                 onTyping: onTyping,
      //                 text: text,
      //                 hintText: hintText,
      //                 isFullPage: true,
      //                 textType: textType,
      //                 //textCardController: textCardController,
      //               ),
      //             ),
      //           ),
      //         ),
      //       ),
      //     ),
      //   ),
      // );
    }
    // focusNode.requestFocus();
    return Get.bottomSheet(
      PostInput(
        submitName: submitName,
        controller: PostInputController(
          focusNode: focusNode,
          createTextType: createTextType,
          onSubmit: onSubmit,
          text: text,
          textType: textType,
        ),
        onTyping: onTyping,
        hintText: hintText,
        isComment: isComment,
      ),
      backgroundColor: Colors.transparent,
    );
  }

  Widget search() {
    return Expanded(
        child: Builder(
      builder: (context) => Container(
        margin: const EdgeInsets.only(bottom: 5, top: 5, right: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isFullPage
                  ? Colors.transparent
                  : context.theme.colorScheme.secondary.withOpacity(.2),
            ),
            color: context.theme.scaffoldBackgroundColor),
        padding: const EdgeInsets.only(top: 3, bottom: 3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [textField()],
        ),
      ),
    ));
  }

  Widget searchRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isFullPage)
          Row(children: [
            const SizedBox(width: 10),
            Obx(() => ProfileImage(
                  radius: 16,
                  url: controller.authUserStore.loggedUser?.profilePictureUrl,
                  // hasHero: false,
                  showFullScreen: false,
                  uuid: uuid.v4(),
                ))
          ])
        else
          const SizedBox(
            width: 60,
          ),
        search(),
      ],
    );
  }

  Widget keyboardItem({required Function onTap, Widget? child}) {
    return Expanded(
      child: InkWell(
        onTap: () {
          HapticFeedback.lightImpact();
          onTap();
        },
        child: Container(
          alignment: Alignment.center,
          child: child,
        ),
      ),
    );
  }

  Widget cashtag() {
    return keyboardItem(
      onTap: () => controller.addToController(r'$'),
      child: const Icon(UniconsLine.dollar_alt),
    );
  }

  Widget userMention() {
    return keyboardItem(
      onTap: () => controller.addToController(r'@'),
      child: const Icon(UniconsLine.at),
    );
  }

  Widget addPhoto() {
    return keyboardItem(
      onTap: () => controller.mediaPickController
          .pickMedia(controller.mediaPickController.handleImage),
      child: const Icon(UniconsLine.image),
    );
  }

  Widget addVideo() {
    return keyboardItem(
      onTap: () async {
        await controller.mediaPickController
            .pickMedia(controller.mediaPickController.handleVideo);
      },
      child: const Icon(UniconsLine.video),
    );
  }

  Widget addGiff() {
    return keyboardItem(
      onTap: controller.mediaPickController.pickGiff,
      child: const Icon(
        Icons.gif,
        size: 40,
      ),
    );
  }

  Widget actionRow() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        cashtag(),
        userMention(),
        addPhoto(),
        addVideo(),
        addGiff()
      ]),
    );
  }

  Widget textField() {
    if (kDebugMode) {
      print('iscomment: $isComment');
    }
    return Expanded(
      child: RichTextField(
        suffix: !isFullPage ? submitButton() : null,
        focusNode: controller.focusNode,
        // autofocus: false,
        autofocus: isComment,
        textEditingController: controller.textEdittingController,
        hintText: hintText,
        createTextType: controller.createTextType,
        onTyping: onTyping,
        isFullPage: isFullPage,
        maxLines: 50,
      ),
    );
  }

  Widget submitButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 3.0),
      child: ClipOval(
        child: Material(
          elevation: 0,
          color: IrisColor.irisBlue,
          child: SizedBox(
            height: 28,
            width: 28,
            child: InkWell(
              splashColor: Colors.red, // Splash color
              onTap: controller.onSend,
              child: const SizedBox(
                width: 10,
                height: 10,
                child: Icon(
                  Icons.arrow_upward,
                  color: Colors.white,
                  size: 23,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget header() {
    return Visibility(
      visible: isFullPage,
      child: Container(
        margin: const EdgeInsets.only(top: 5, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () => Get.back(), icon: const Icon(Icons.close)),
            Container(
              height: 36,
              width: 100,
              margin: const EdgeInsets.only(right: 10),
              child: Obx(() => Visibility(
                    visible: controller.showPostButton.value,
                    child: ElevatedButton(
                      onPressed: controller.onSend,
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                        ),
                      ),
                      child: Text(
                        submitName,
                        style:
                            const TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }

  Widget bodyPage() {
    return Expanded(
      child: Column(
        children: [
          Expanded(child: searchRow()),
          PostInputMediaRow(c: controller, isFullPage: isFullPage),
          actionRow(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: isFullPage
            ? Colors.transparent
            : context.theme.backgroundColor.withOpacity(.98),
        child: Column(
          mainAxisSize: isFullPage ? MainAxisSize.max : MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            header(),
            if (!isFullPage) ...[
              searchRow(),
              PostInputMediaRow(c: controller, isFullPage: isFullPage),
              actionRow(),
            ] else
              bodyPage(),
          ],
        ));
  }
}
