import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'groupchat_controller.dart';
import 'groupchat_view.dart';

class GroupChatScreen extends StatelessWidget {
  const GroupChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GroupChatController>(
      init: GroupChatController(),
      builder: (controller) {
        return GroupChatView(
          controller: controller,
        );
      },
    );
  }
}
