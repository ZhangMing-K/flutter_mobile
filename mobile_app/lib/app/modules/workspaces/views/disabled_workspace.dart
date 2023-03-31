import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/workspaces_controller.dart';
import '../shared/workspaces_utils.dart';

class DisabledWorkspaceView extends GetView<WorkspacesController> {
  @override
  final String tag =
      '${WorkspacesUtils.getCurrentWorkspaceSource} ${WorkspacesUtils.getCurrentProfileKey}';

  DisabledWorkspaceView({Key? key}) : super(key: key);

  Widget header(BuildContext context) {
    return Text(
      'Are you an Admin of this server',
      style: TextStyle(
          fontWeight: FontWeight.w700,
          color: context.theme.colorScheme.secondary,
          fontSize: 20),
    );
  }

  Widget subHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8, left: 25, right: 25),
      child: Text(
        'You need to verify your discord login again to enable the Iris bot',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 14, color: context.theme.hintColor),
      ),
    );
  }

  Widget content(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              await controller.workspaceAuth(bot: true);
            },
            child: const Text(
              'Enable Iris Bot',
              style: TextStyle(
                color: Colors.white, //context.theme.colorScheme.secondary,
              ),
            ),
          ),
          resync(context)
        ],
      ),
    );
  }

  resync(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      child: GestureDetector(
        onTap: () async => await controller.workspaceAuth(bot: false),
        child: Text('Something wrong? Try Resyncing',
            style: TextStyle(
              color: context.theme.primaryColor,
              decoration: TextDecoration.underline,
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        header(context),
        subHeader(context),
        content(context),
      ],
    );
  }
}
