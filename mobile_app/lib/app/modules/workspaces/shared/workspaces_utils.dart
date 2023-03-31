import 'package:enum_to_string/enum_to_string.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

class WorkspacesUtils {
  static int? get getCurrentProfileKey {
    return WorkspacesUtils(authUserStore: Get.find()).getAuthUserProfileKey;
  }

  static WORKSPACE_SOURCE? get getCurrentWorkspaceSource {
    return WorkspacesUtils(authUserStore: Get.find()).getWorkspaceSource;
  }

  final IAuthUserService authUserStore;

  WorkspacesUtils({required this.authUserStore});

  int? get getAuthUserProfileKey {
    return authUserStore.loggedUser?.userKey;
  }

  Integration? get getAuthUserWorkspaceIntegration {
    final User authUser = authUserStore.loggedUser!;
    final Integration? integration = authUser.integrations!.firstWhereOrNull(
        (i) => i.source == convertWorkspaceToSocial(getWorkspaceSource));

    return integration;
  }

  WORKSPACE_SOURCE? get getWorkspaceSource {
    WORKSPACE_SOURCE? workspaceSource;

    if (Get.parameters['workspace'] != null &&
        Get.parameters['workspace'] != '') {
      workspaceSource = EnumToString.fromString(
          WORKSPACE_SOURCE.values, Get.parameters['workspace']!);
    }
    return workspaceSource;
  }
}
