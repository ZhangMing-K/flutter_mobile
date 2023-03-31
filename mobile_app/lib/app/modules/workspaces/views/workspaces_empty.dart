import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import '../controllers/workspaces_controller.dart';
import '../shared/workspaces_utils.dart';

class WorkspacesEmpty extends GetView<WorkspacesController> {
  @override
  final String tag =
      '${WorkspacesUtils.getCurrentWorkspaceSource} ${WorkspacesUtils.getCurrentProfileKey}';
  final String? emptyText;

  final double? imageSize;
  final bool? enableAddBot;
  final bool? enableResync;

  WorkspacesEmpty({
    Key? key,
    this.emptyText,
    this.imageSize = 200,
    this.enableAddBot,
    this.enableResync,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    resync(BuildContext context) {
      return Container(
        padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  await controller.workspaceAuth(bot: false);
                },
                child: Text(
                  'Resync your discord workspaces',
                  style: TextStyle(color: context.theme.colorScheme.secondary),
                ),
              ),
            ),
          ],
        ),
      );
    }

    addBot(BuildContext context) {
      return Container(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () async {
                  await controller.workspaceAuth(bot: true);
                },
                child: Text('Add Iris Bot',
                    style: TextStyle(color: context.theme.primaryColor)),
              ),
            ),
          ],
        ),
      );
    }

    main(BuildContext context) {
      final buttons = [];

      if (enableResync == true) buttons.add(resync(context));

      if (enableResync == true && enableAddBot == true) {
        buttons.add(
          Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: const Text('or')),
        );
      }

      if (enableAddBot == true) buttons.add(addBot(context));
      return Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IrisEmpty(
                emptyText: emptyText!,
                imagePath: Images.discordDisabled,
                imageSize: imageSize),
            ...buttons
          ],
        ),
      );
    }

    return Container(
      child: main(context),
    );
  }
}
