import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

class MessageInputController extends SuperController
    with GetTickerProviderStateMixin {
  final VoidCallback onTyping;

  final textEdittingController = TextEditingController();

  final TextModel? text;
  final Function(ReturnTextInfo?)? onEvent;
  final CreateTextType? createTextType;
  late MediaPickController mediaPickController;

  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 350),
    lowerBound: 0.0,
    upperBound: 0.1,
  );

  final scale = 1.0.obs;

  late final Worker _worker;

  final expanded = false.obs;

  // final keyboardOpen = false.obs;

  FocusNode? focusNode;

  RxBool showActionRow = false.obs;

  MessageInputController({
    this.text,
    this.onEvent,
    this.createTextType,
    this.focusNode,
    required this.onTyping,
  });

  addToController(String str) {
    final String newText = textEdittingController.text + str;
    textEdittingController.value = TextEditingValue(
        text: newText,
        selection: TextSelection(
            baseOffset: newText.length, extentOffset: newText.length));
  }

  changeActionRowVisitbility() {
    if (focusNode!.hasFocus) {
      showActionRow.value = true;
    } else {
      showActionRow.value = false;
    }
  }

  void expandInput() {
    expanded.value = false;
  }

  // void keyboardListener(bool isKeyboardOpen) {
  //   keyboardOpen.value = isKeyboardOpen;
  //   if (!isKeyboardOpen) {
  //     expanded(false);
  //   }
  // }

  @override
  void onClose() {
    _worker.dispose();

    textEdittingController.removeListener(_textEditListener);
    super.onClose();
  }

  @override
  void onDetached() {}

  @override
  void onInactive() {}

  @override
  void onInit() {
    // addKeyboardListener(keyboardListener);

    _worker = ever<bool>(expanded,
        (value) => value ? _controller.forward() : _controller.reverse());

    if (text?.value != null && text?.value != '') {
      textEdittingController.text = text!.value!;
    }

    mediaPickController = MediaPickController(text: text.obs);

    changeActionRowVisitbility();
    focusNode!.addListener(() {
      changeActionRowVisitbility();
    });

    textEdittingController.addListener(_textEditListener);
    super.onInit();
  }

  @override
  void onPaused() {}

  @override
  void onResumed() {}

  void _textEditListener() {
    if (textEdittingController.text.length > 12) {
      expanded.value = true;
    } else if (textEdittingController.text.length < 12) {
      expanded.value = false;
    }
  }
}
