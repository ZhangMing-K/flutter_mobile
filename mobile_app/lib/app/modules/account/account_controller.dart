import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

class AccountController extends GetxController {
  AccountController(
      {required this.workspaceService, required this.authUserStore});
  final WorkspaceService workspaceService;
  final IAuthUserService authUserStore;
}
