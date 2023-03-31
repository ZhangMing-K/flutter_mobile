import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'invite_chat_controller.dart';

class InviteChatHeader extends StatelessWidget {
  const InviteChatHeader({Key? key, required this.controller})
      : super(key: key);
  final InviteChatController controller;
  @override
  build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 20, right: 20),
        child: Row(
          children: <Widget>[
            Expanded(
                flex: 1,
                child: InkWell(
                    onTap: () {
                      controller.onBack();
                    },
                    child: Text('Cancel',
                        style: TextStyle(
                            color: Colors.grey.shade500,
                            fontWeight: FontWeight.w500)))),
            Expanded(flex: 2, child: Container()),
            Expanded(
                flex: 1,
                child: InkWell(
                    onTap: () {
                      // goto next or create
                      controller.onInvite();
                    },
                    child: Text('Invite',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            color: context.theme.colorScheme.secondary,
                            fontWeight: FontWeight.w500)))),
          ],
        ));
  }
}
