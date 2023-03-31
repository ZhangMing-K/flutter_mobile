import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import 'components/contacts_list_view.dart';
import 'components/header.dart';
import 'components/search_input.dart';
import 'components/selected_contacts_list_view.dart';
import 'groupchat_controller.dart';
import 'groupchat_create_info.dart';

class GroupChatView extends StatelessWidget {
  final GroupChatController controller;
  const GroupChatView({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // controller.context = context;
    return Obx(() {
      if (controller.status$.value == NEW_GROUP_CHAT_STATUS.CREATE) {
        return ListView(
          shrinkWrap: true,
          children: [
            Column(children: [
              GroupChatHeader(controller: controller),
              GroupChatSearchInput(controller: controller),
              GroupChatCreateInfo(controller: controller)
            ])
          ],
        );
      } else {
        return Column(children: [
          GroupChatHeader(controller: controller),
          GroupChatSearchInput(controller: controller),
          _buildHeader(),
          ContactsListView(controller: controller)
        ]);
      }
    });
  }

  Widget _buildHeader() {
    return controller.status$.value == NEW_GROUP_CHAT_STATUS.NEW
        ? Container()
        : SelectedContactsList(controller: controller);
  }
}
