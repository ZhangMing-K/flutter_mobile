import 'package:flutter/material.dart';

import 'contacts_list.dart';
import 'header.dart';
import 'invite_chat_controller.dart';
import 'search_input.dart';
import 'selected_contacts.dart';

class ChatInviteView extends StatelessWidget {
  final InviteChatController controller;
  final ScrollController scrollController;
  const ChatInviteView(
      {Key? key, required this.controller, required this.scrollController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: Theme.of(context).backgroundColor,
        ),
        child: PrimaryScrollController(
            controller: scrollController,
            child: Column(children: [
              InviteChatHeader(controller: controller),
              InviteSearchInput(controller: controller),
              InviteSelectedContactsList(controller: controller),
              InviteContactsListView(controller: controller)
            ])));
  }
}
