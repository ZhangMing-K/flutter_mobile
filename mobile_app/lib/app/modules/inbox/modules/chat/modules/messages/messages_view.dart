import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import '../../../../shared/widgets/iris_typing_widget.dart';
import '../../../../shared/widgets/message_input/message_input.dart';
import '../../../../shared/widgets/message_item_view.dart';
import '../../controllers/chat_controller.dart';

class MessagesView extends StatelessWidget {
  final ChatController controller;
  const MessagesView({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Obx(() => Column(
                children: [
                  Expanded(
                    child: IrisListView(
                      reverse: true,
                      keyboardHidesHeader: false,
                      header: Builder(
                        builder: (context) => Obx(
                          () => IrisTypingWidget(
                            showIndicator: controller.isTyping.value,
                            bubbleColor: context.isDarkMode
                                ? Colors.grey[900]!
                                : const Color(0xffdfdfdf),
                            //  context.isDarkMode
                            //     ? Colors.grey[900]!
                            //     : IrisColor.primaryColor,
                          ),
                        ),
                      ),
                      itemCount: controller.totalMessages$.length,
                      loadMore: controller.loadMore,
                      controller: controller.scrollController,
                      builder: (context, index) {
                        return Obx(() {
                          final data = controller.totalMessages$[index];
                          final before =
                              index < controller.totalMessages$.length - 1
                                  ? controller.totalMessages$[index + 1]
                                  : null;

                          return ScaleTransition(
                            scale: CurvedAnimation(
                              parent: data.animationController,
                              curve: Curves.easeOut,
                            ),
                            child: MessageItemView(
                              fromCollectionKey: controller.collectionKey,
                              showDate: controller.showDate(data.message.value,
                                  before?.message.value.createdAt),
                              isLast: index == 0,
                              isPrivateMessage: controller.isPrivateMessage,
                              message: data.message,
                              isSending:
                                  data.message.value.textCreateId != null,
                              type: controller.bubbleType(
                                index,
                                data.message.value,
                                before?.message.value,
                              ),
                              isSender:
                                  controller.isAuthUser(data.message.value),
                            ),
                          );
                        });
                      },
                    ),
                  ),
                ],
              )),
        ),
        Obx(() {
          if (controller.isFirstMessage) {
            return Column(
              children: [
                Text('Send your first message in the chat!',
                    style: TextStyle(
                        color: context.theme.colorScheme.secondary
                            .withOpacity(.5))),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                          color: Colors.red, shape: BoxShape.circle),
                    ),
                    const SizedBox(width: 8),
                    Text('Click the graph icon to see and send recent orders',
                        style: TextStyle(
                            color: context.theme.colorScheme.secondary
                                .withOpacity(.5)))
                  ],
                ),
                const SizedBox(height: 8),
              ],
            );
          }
          return Container();
        }),
        Obx(() {
          return MessageInput(
            focusNode: controller.focusNode,
            createTextType: CreateTextType(
              textType: TEXT_TYPE.MESSAGE,
              collectionKey: controller.collectionKey,
            ),
            hintText: 'Message...',
            onSubmit: controller.onSubmit,
            onTyping: controller.onUserTyping,
            setSharingOrder: controller.setSharingOrder,
            sharedOrder: controller.sharedOrder$,
            isFirstMessage: controller.isFirstMessage,
          );
        }),
      ],
    );
  }
}
