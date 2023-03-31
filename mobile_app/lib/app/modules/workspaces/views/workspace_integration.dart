import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import '../controllers/workspaces_controller.dart';
import '../shared/workspaces_utils.dart';

class WorkspaceIntegrationView extends GetView<WorkspacesController> {
  @override
  final String tag =
      '${WorkspacesUtils.getCurrentWorkspaceSource} ${WorkspacesUtils.getCurrentProfileKey}';

  WorkspaceIntegrationView({Key? key}) : super(key: key);

  Widget body(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: const Text(
            'Are you: ',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.start,
          ),
        ),
        pannels(context)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return main(context);
  }

  instructionText(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 30, left: 4, right: 4),
      child: const Text(
          'Now you can connect your portfolios to enabled Discord channels and automatically post real-time trades!',
          style: TextStyle(fontSize: 16)),
    );
  }

  irisIntegration(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(Images.logoNoText),
          const Icon(Icons.add),
          Image.asset(
            IconPath.discord,
            width: 100,
          )
        ],
      ),
    );
  }

  main(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
            margin: const EdgeInsets.only(top: 15, left: 38, right: 38),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                irisIntegration(context),
                instructionText(context),
                body(context)
              ],
            )));
  }

  Widget pannels(BuildContext context) {
    return Column(
      children: [
        IrisDescriptionCard(
          title: 'Admin / Owner',
          description:
              'Enable the Iris bot in your channels, select portfolios and set permissions.',
          image: Images.onboardingPosts,
          onTap: () async => {
            HapticFeedback.lightImpact(),
            await controller.workspaceAuth(bot: true)
          },
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: const Text(
            'or',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
        IrisDescriptionCard(
          title: 'Member',
          description:
              'See what channels have the Iris bot enabled and connect your portfolios.',
          image: Images.onboardingPosts,
          onTap: () async => {
            HapticFeedback.lightImpact(),
            await controller.workspaceAuth(bot: false)
          },
        )
      ],
    );
  }
}
