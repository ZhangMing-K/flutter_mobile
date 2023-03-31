import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:iris_mobile/app/modules/feed/shared/widgets/rich_text/rich_text_field.dart';
import 'package:iris_mobile/app/modules/feed/shared/widgets/text_card/SharedMessageText/index.dart';
import 'package:unicons/unicons.dart';

import '../../../modules/chat/modules/recent_orders/recent_orders_controller.dart';
import '../../../modules/chat/modules/recent_orders/recent_orders_view.dart';
import 'media_row.dart';
import 'message_input_controller.dart';
import 'resizeable_input.dart';

class MessageInput extends StatelessWidget {
  //possibly rename this to CreateTextInput
  final FocusNode focusNode;

  final Function(ReturnTextInfo?)? onEvent;

  final CreateTextType? createTextType;
  final Function(PostInputInfo info) onSubmit;
  final Function(TextModel? order)? setSharingOrder;
  final Rx<TextModel?>? sharedOrder;
  final String? hintText;
  final TextModel? text;
  final Function() onTyping;
  final bool? isFirstMessage;

  const MessageInput({
    Key? key,
    required this.focusNode,
    this.onEvent,
    this.hintText = "What's on your mind?",
    required this.onSubmit,
    this.text,
    this.createTextType, //The kind of text that will now be created
    required this.onTyping,
    this.setSharingOrder,
    required this.sharedOrder,
    this.isFirstMessage,
  }) : super(key: key);

  Widget addGiff(MessageInputController controller) {
    return keyboardItem(
      onTap: controller.mediaPickController.pickGiff,
      child: const Icon(
        Icons.gif,
        size: 40,
      ),
    );
  }

  Widget addPhoto(MessageInputController controller) {
    return keyboardItem(
        onTap: () async {
          setSharingOrder!(null);
          await controller.mediaPickController
              .pickMedia(controller.mediaPickController.handleImage);
        },
        child: const Icon(Icons.image));
  }

  Widget addVideo(MessageInputController controller) {
    return keyboardItem(
        onTap: () async {
          await controller.mediaPickController
              .pickMedia(controller.mediaPickController.handleVideo);
        },
        child: const Icon(Icons.videocam));
  }

  Widget attachmentView(MessageInputController controller) {
    return Container(
      color: Colors.transparent,
      // color: context.theme.scaffoldBackgroundColor.withOpacity(.5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            color: Colors.transparent,
            width: double.infinity,
            child: Obx(() {
              if (sharedOrder!.value is TextModel) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Builder(builder: (context) {
                      return Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.6,
                          ),
                          margin: const EdgeInsets.only(left: 10),
                          child: SharedMessageText(
                              text: sharedOrder!.value!,
                              scaleFactor: 0.8,
                              isCancellable: true,
                              irisEvent: Get.find(),
                              onCancelSharingOrder: () {
                                setSharingOrder!(null);
                              }));
                    }),
                    const SizedBox(height: 10),
                  ],
                );
              } else {
                return Container();
              }
            }),
          ),
          Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 100,
                    child: PostInputMediaRow(c: controller),
                  )
                ],
              )),
          Obx(() {
            if (controller.mediaPickController.mediaList$.isNotEmpty ||
                sharedOrder!.value is TextModel) return const Divider();
            return Container();
          })
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MessageInputController>(
      global: false,
      init: MessageInputController(
        text: text,
        onEvent: onEvent,
        createTextType: createTextType,
        focusNode: focusNode,
        onTyping: onTyping,
      ),
      builder: (controller) {
        return searchRow(controller);
      },
    );
  }

  Widget buttonItem({
    required Function onTap,
    Widget? child,
    Color? color,
  }) {
    return Material(
      borderRadius: BorderRadius.circular(5),
      color: color,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
          onTap: () {
            HapticFeedback.lightImpact();
            onTap();
          },
          child: Padding(
            padding: const EdgeInsets.all(3),
            child: child,
            // alignment: Alignment.center,
          )),
    );
  }

  Widget cashTag(MessageInputController controller) {
    return keyboardItem(
        onTap: () {
          controller.addToController(r'$');
        },
        child: const Text(r'$',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)));
  }

  Widget keyboardItem({
    required Function onTap,
    Widget? child,
    Color? color,
  }) {
    return Expanded(
      child: InkWell(
          onTap: () {
            HapticFeedback.lightImpact();
            onTap();
          },
          child: Container(
            color: color,
            child: child,
            alignment: Alignment.center,
          )),
    );
  }

  Widget search(MessageInputController controller) {
    return Builder(
        builder: (context) => Container(
            margin: const EdgeInsets.only(bottom: 5, top: 5, right: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                  width: 1.0,
                  color: context.theme.colorScheme.secondary.withOpacity(.3)),
              // border: Border.all(color: context.theme.primaryColor),
              // color: context.theme.scaffoldBackgroundColor,
            ),
            padding: const EdgeInsets.only(top: 3, bottom: 3),
            child: Column(
              children: [
                attachmentView(controller),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    textField(controller),
                  ],
                ),
              ],
            )));
  }

  Widget searchRow(MessageInputController controller) {
    return ResizeableInput(
      textEdittingController: controller.textEdittingController,
      actionMoreItem: Container(
          padding: const EdgeInsets.all(10.0),
          child: Material(
            borderRadius: BorderRadius.circular(5),
            color: Colors.grey.withOpacity(.2),
            clipBehavior: Clip.antiAlias,
            child: const Padding(
              padding: EdgeInsets.all(3),
              child: Icon(UniconsLine.arrow_right),
            ),
          )),
      actionItems: Row(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: buttonItem(
                  child: const Icon(UniconsLine.image_v),
                  color: Colors.grey.withOpacity(.2),
                  onTap: () async {
                    setSharingOrder!(null);
                    await controller.mediaPickController
                        .pickMedia(controller.mediaPickController.handleImage);
                  },
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              buttonItem(
                  child: const Icon(Icons.gif),
                  color: Colors.grey.withOpacity(.2),
                  onTap: () async {
                    setSharingOrder!(null);
                    await controller.mediaPickController.pickGiff();
                  }),
              const SizedBox(
                width: 10,
              ),
              buttonItem(
                child: Stack(
                  children: [
                    const Icon(UniconsLine.analytics),
                    Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          width: 10,
                          height: 10,
                          child: null,
                          decoration: BoxDecoration(
                              color: isFirstMessage!
                                  ? Colors.red
                                  : Colors.transparent,
                              shape: BoxShape.circle),
                        )),
                  ],
                ),
                color: Colors.grey.withOpacity(.2),
                onTap: () {
                  // show bottom sheet for recent orders
                  final RecentOrdersController recentOrderController =
                      RecentOrdersController(
                          chatRepository: Get.find(),
                          collectionKey: createTextType!.collectionKey!,
                          setSharingOrder: (TextModel order) {
                            if (setSharingOrder != null) {
                              setSharingOrder!(order);
                            }
                            // make sure we clear media list
                            controller.mediaPickController.mediaList$.clear();
                          });
                  Get.bottomSheet(
                    DraggableScrollableSheet(
                      minChildSize: 0.4,
                      maxChildSize: 0.8,
                      initialChildSize: 0.8,
                      expand: true,
                      builder: (context, scrollController) {
                        return RecentOrdersView(
                            controller: recentOrderController,
                            scrollController: scrollController);
                      },
                    ),
                    isScrollControlled: true,
                  );
                },
              )
            ],
          ),
        ],
      ),
      child: search(controller),
    );
  }

  Widget submitButton(MessageInputController controller) {
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
              onTap: () {
                onSubmit(PostInputInfo(
                    textModel: controller.text.obs,
                    textEditingController: controller.textEdittingController,
                    isEdited: controller.mediaPickController.isEdited$.value,
                    mediaList: controller.mediaPickController.mediaList$,
                    deletedMedia:
                        controller.mediaPickController.deletedMedia$.value,
                    createTextType: createTextType,
                    textType: createTextType!.textType!,
                    sharedText: sharedOrder));
              },
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

  Widget textField(MessageInputController controller) {
    return Flexible(
      child: Obx(
        () => Stack(
          children: [
            RichTextField(
              //textInputAction: TextInputAction.go,
              suffix: const SizedBox(width: 28, height: 28),
              // empty container
              focusNode: focusNode,
              maxLines: controller.expanded.isTrue ? 10 : 2,
              textEditingController: controller.textEdittingController,
              hintText: hintText,
              createTextType: createTextType!,
              onTyping: onTyping,
            ),
            Positioned(bottom: 1, right: 0, child: submitButton(controller))
          ],
        ),
      ),
    );
  }

  Widget userMention(MessageInputController controller) {
    return keyboardItem(
        onTap: () {
          controller.addToController(r'@');
        },
        child: const Text(r'@',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)));
  }

  static show({
    required FocusNode focusNode,
    TEXT_TYPE textType = TEXT_TYPE.POST,
    CreateTextType? createTextType,
    TextModel? text,
    String? hintText,
    required VoidCallback onTyping,
    required Function(PostInputInfo info) onSubmit,
    Function(TextModel? order)? setSharingOrder,
    required Rx<TextModel?>? sharedOrder,
    Function(ReturnTextInfo?)? onEvent,
    bool? isFirstMessage,
  }) {
    Get.bottomSheet(
      MessageInput(
        focusNode: focusNode,
        createTextType: createTextType,
        onEvent: onEvent,
        onTyping: onTyping,
        text: text,
        hintText: hintText,
        onSubmit: onSubmit,
        sharedOrder: sharedOrder,
        setSharingOrder: setSharingOrder,
        isFirstMessage: isFirstMessage,
      ),
      backgroundColor: Colors.transparent,
    );
  }
}
