import 'package:get/get.dart';
import '../modules/channel_tile/controllers/channel_tile_controller.dart';

import '../controllers/workspaces_controller.dart';
import '../shared/workspaces_utils.dart';

class WorkspacesBinding extends Bindings {
  @override
  void dependencies() {
    final workspaceUtils = WorkspacesUtils(authUserStore: Get.find());
    Get.create<ChannelTileController>(() =>
        ChannelTileController()); // different instances for different list items
    Get.put<WorkspacesController>(
      WorkspacesController(
          authUserKey: workspaceUtils.getAuthUserProfileKey,
          workspaceSource: workspaceUtils.getWorkspaceSource,
          integration: workspaceUtils.getAuthUserWorkspaceIntegration),
      permanent: true,
      tag:
          '${workspaceUtils.getWorkspaceSource} ${workspaceUtils.getAuthUserProfileKey}',
    );
  }
}
