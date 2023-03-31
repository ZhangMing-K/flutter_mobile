import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import '../groupchat_controller.dart';

class GroupChatHeader extends StatelessWidget {
  final GroupChatController controller;
  const GroupChatHeader({Key? key, required this.controller}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
          margin: const EdgeInsets.only(left: 20, right: 0),
          child: Row(
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: InkWell(
                      onTap: () {
                        controller.onBack();
                      },
                      child: Text(
                          controller.status$.value ==
                                  NEW_GROUP_CHAT_STATUS.CREATE
                              ? 'Back'
                              : '',
                          style: TextStyle(
                              // color: Color.fromRGBO(142, 157, 177, 1.0),
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.w500)))),
              Expanded(
                flex: 2,
                child: Text(
                  controller.status$.value == NEW_GROUP_CHAT_STATUS.NEW
                      ? 'Create a chat'
                      : controller.status$.value ==
                              NEW_GROUP_CHAT_STATUS.PARTICIPANTS
                          ? 'Add Participants'
                          : 'Create a chat',
                  style: TextStyle(
                      color: context.theme.colorScheme.secondary,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                  flex: 1,
                  child: InkWell(
                      onTap: () {
                        // goto next or create
                        controller.onClickNext();
                      },
                      child: Container(
                          width: 44,
                          alignment: Alignment.center,
                          child: Text(
                              controller.status$.value ==
                                      NEW_GROUP_CHAT_STATUS.PARTICIPANTS
                                  ? 'Next'
                                  : controller.status$.value ==
                                          NEW_GROUP_CHAT_STATUS.CREATE
                                      ? 'Finish'
                                      : '',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: controller.status$.value ==
                                          NEW_GROUP_CHAT_STATUS.CREATE
                                      ? IrisColor.irisBlueLight
                                      : context.theme.colorScheme.secondary,
                                  fontWeight: FontWeight.w500))))),
            ],
          )),
    );
  }
}
