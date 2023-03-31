import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import '../../../controllers/feed_controller.dart';

class PostInputController extends GetxController {
  PostInputController(
      {this.text,
      required this.onSubmit,
      this.createTextType,
      required this.textType,
      this.focusNode}) {
    if (text?.value?.value != null && text!.value!.value!.isNotEmpty) {
      textEdittingController.text = text!.value!.value!;
    }
    mediaPickController = MediaPickController(text: text);
    changeActionRowVisitbility();
    focusNode!.addListener(() {
      changeActionRowVisitbility();
    });
  }

  final Function(PostInputInfo info)? onSubmit;
  TextEditingController textEdittingController = TextEditingController();
  late MediaPickController mediaPickController;
  // final TextCardController textCardController;

  final FeedController feedController = Get.find();
  final TEXT_TYPE textType;

  IAuthUserService authUserStore = Get.find();

  Rx<ReturnTextInfo?> returnTextInfo$ = Rx(null);
  Rx<TextModel?>? text;
  Function(ReturnTextInfo)? onEvent;
  CreateTextType? createTextType;

  changeActionRowVisitbility() {
    if (focusNode!.hasFocus) {
      showActionRow.value = true;
    } else {
      showActionRow.value = false;
    }
  }

  FocusNode? focusNode;

  RxBool showActionRow = false.obs;

  RxBool showPostButton = true.obs;

  onSend() async {
    await onSubmit!(PostInputInfo(
      textModel: text,
      textEditingController: textEdittingController,
      isEdited: mediaPickController.isEdited$.value,
      mediaList: mediaPickController.mediaList$,
      deletedMedia: mediaPickController.deletedMedia$.value,
      createTextType: createTextType,
      textType: textType,
    ));
    if (textType != TEXT_TYPE.COMMENT) {
      Get.back();
    }
  }

  addToController(String str) {
    final int currentPosition =
        textEdittingController.selection.start.isNegative
            ? 0
            : textEdittingController.selection.start;
    final String currentText = textEdittingController.text;
    if (currentPosition == currentText.length) {
      // cash tag at the end of the text
      final String newText = currentText + str;
      textEdittingController.value = TextEditingValue(
          text: newText,
          selection: TextSelection(
              baseOffset: newText.length, extentOffset: newText.length));
    } else {
      // cash tag in the middle of the text
      final prevText = currentText.substring(0, currentPosition);
      final nextText =
          currentText.substring(currentPosition, currentText.length);
      final String newText = prevText + str + nextText;
      textEdittingController.value = TextEditingValue(
          text: newText,
          selection: TextSelection(
              baseOffset: currentPosition + str.length,
              extentOffset: currentPosition + str.length));
    }
  }
}
