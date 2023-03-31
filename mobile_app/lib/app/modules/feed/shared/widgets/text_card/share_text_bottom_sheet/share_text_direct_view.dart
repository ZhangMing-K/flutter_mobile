import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:iris_mobile/app/modules/feed/shared/widgets/rich_text/rich_text_field.dart';

import 'share_text_controller.dart';

class ShareTextDirectView extends StatelessWidget {
  final ShareTextController controller;
  final ScrollController? scrollController;
  final int userKey;

  final reactionList = const <String>[
    '💎🤲',
    '🚀',
    '🤑',
    '🧻🤲',
    '🦍',
    '🎉',
  ];

  const ShareTextDirectView(
      {Key? key,
      required this.controller,
      required this.userKey,
      this.scrollController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        //padding: const EdgeInsets.only(top: 20),
        color: Colors.transparent,
        child: listView(context));
  }

  Widget listView(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
            ),
          ),
          Container(
              color: context.theme.scaffoldBackgroundColor,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(height: 10),
                  quickReactions(context),
                  const SizedBox(height: 45),
                  Container(
                    margin: const EdgeInsets.only(
                        left: 10, bottom: 5, top: 5, right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          width: 1.0,
                          color: context.theme.colorScheme.secondary
                              .withOpacity(.3)
                          // color: Colors.white,
                          ),
                    ),
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    child: textField(context),
                  ),
                ],
              )),
        ]);
  }

  Widget quickReactions(BuildContext context) {
    return Column(
      children: [
        Text('Quick Reactions',
            style: TextStyle(
                fontSize: 20, color: context.theme.colorScheme.secondary)),
        const SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: reactionList
              .getRange(0, (reactionList.length / 2).round())
              .map((reactionName) => reaction(icon: reactionName))
              .toList(),
        ),
        const SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: reactionList
              .getRange((reactionList.length / 2).round(), reactionList.length)
              .map((reactionName) => reaction(icon: reactionName))
              .toList(),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget reaction({required String icon, double height = 40}) {
    return GestureDetector(
        onTap: () {
          Get.back();
          controller.directShare(userKey, icon: icon);
        },
        child: Text(
          icon,
          style: const TextStyle(fontSize: 35),
        ));
  }

  Widget sendBtn(BuildContext context) {
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
                Get.back();
                controller.directShare(userKey);
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

  Widget textField(BuildContext context) {
    return Stack(
      children: [
        RichTextField(
          textEditingController: controller.textEdittingController,
          hintText: 'Send Message',
          // hintColor: Colors.white,
          onTyping: () {},
          suffix: const SizedBox(width: 28, height: 28), // empty container
        ),
        Positioned(bottom: 1, right: 0, child: sendBtn(context))
      ],
    );
  }
}
