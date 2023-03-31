import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import 'invite_chat_controller.dart';

class InviteSearchInput extends StatelessWidget {
  final InviteChatController controller;
  //TextEditingController textEditingController = TextEditingController();
  const InviteSearchInput({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.status$.value != NEW_GROUP_CHAT_STATUS.CREATE
        ? Container(
            margin: const EdgeInsets.all(12),
            child: CupertinoSearchTextField(
              onChanged: (value) {
                controller.search(value);
              },
              onSubmitted: (value) {
                controller.search(value);
              },
              // controller: textEditingController,
              prefixInsets: const EdgeInsets.all(10),
              placeholder: 'Search by name or phone number',
              placeholderStyle: TextStyle(
                  color: context.theme.colorScheme.secondary.withOpacity(0.7)),
              style: TextStyle(
                  color: context.theme.colorScheme.secondary.withOpacity(0.7)),
            ),
          )
        : Container();
  }
}
