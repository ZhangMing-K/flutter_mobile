import 'package:get/get.dart';

import '../controllers/pending_invites_controller.dart';

class PendingInvitesBinding extends Bindings {
  @override
  void dependencies() {
    Get.create(() => PendingInvitesController());
  }
}
