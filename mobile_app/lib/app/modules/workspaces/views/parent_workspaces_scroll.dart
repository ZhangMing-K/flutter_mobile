import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import '../controllers/workspaces_controller.dart';
import '../shared/workspaces_utils.dart';
import 'workspace_image.dart';

class ParentWorkspacesScrollView extends GetView<WorkspacesController> {
  @override
  final String tag =
      '${WorkspacesUtils.getCurrentWorkspaceSource} ${WorkspacesUtils.getCurrentProfileKey}';

  ParentWorkspacesScrollView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        header(context),
        main(context),
      ],
    );
  }

  Widget header(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 25, left: 20),
      alignment: Alignment.centerLeft,
      child: const Text(
        'Servers',
        textAlign: TextAlign.start,
        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
      ),
    );
  }

  Widget image(Workspace workspace, BuildContext context, double size) {
    return Obx(() {
      final bool selected = controller.selectedWorkspace$.value?.workspaceKey ==
          workspace.workspaceKey;

      return GestureDetector(
          onTap: () => {
                HapticFeedback.lightImpact(),
                controller.selectedWorkspace$.value = workspace
              },
          child: WorkspaceImage(
            workspace: workspace,
            height: size,
            selected: selected,
          ));
    });
  }

  Widget main(BuildContext context) {
    final List<Workspace> workspaces =
        controller.profileUser$.value!.workspaces!;

    return SizedBox(
        width: 500,
        height: 200,
        child: IrisListView(
          height: 300,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          onRefresh: () async => debugPrint('need to implement'),
          itemCount: workspaces.length,
          loadMore: controller.loadMore,
          builder: (BuildContext context, int index) {
            return Container(
                padding: const EdgeInsets.only(right: 8),
                child: image(workspaces[index], context, 70));
          },
        ));
  }
}
