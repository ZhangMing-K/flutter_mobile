import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import '../group_details_controller.dart';

class GroupSettingsSheet extends GetWidget<GroupDetailsController> {
  final User user;

  const GroupSettingsSheet({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: context.theme.backgroundColor,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          children: [
            PannelTile(
              leading: const Icon(Icons.delete),
              textAlignment: Alignment.centerLeft,
              color: context.theme.colorScheme.secondary,
              text: 'Remove User',
              onTap: () {
                controller.showRemoveConfirmation(user.fullName, user.userKey!);
              },
            ),
          ],
        ));
  }
}
