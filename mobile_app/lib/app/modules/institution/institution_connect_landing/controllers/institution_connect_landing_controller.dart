import 'package:get/get.dart';

import '../../../../routes/pages.dart';
import '../../classes/connect_institution_arts.dart';

class InstitutionConnectLandingController extends GetxController {
  InstitutionConnectLandingController({required this.authUserStore});
  final IAuthUserService authUserStore;
  bool isOnboarding = false;

  bool get wasInvited {
    return authUserStore.loggedUser?.invitedByUser != null &&
        !didFollowInvitedByUser.value;
  }

  final RxBool didFollowInvitedByUser = RxBool(false);
  @override
  void onInit() {
    final args = Get.arguments;
    if (args is ConnectInstitutionArgs) {
      if (args.from == INSTITUTION_CONNECTED_FROM.ONBOARDING) {
        isOnboarding = true;
      }
    }
    super.onInit();
  }

  void onNext() {
    Get.toNamed(Paths.UserExperience);
  }
}
