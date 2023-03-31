import 'package:get/get.dart';

import '../../data/services/auth_user/auth_user_service.dart';

///used in controllers where we need to track the current step(index) for something like a PageTransitionSwitcher
mixin IndexedStepMixin {
  ///index for the pageTransitions

  final RxInt currentStep$ = RxInt(0);

  final IAuthUserService authUserStore = Get.find();

  /// Indicates whether we're going forward or backward in terms of the index we're changing.
  /// This is for the page transition directions.
  bool reverse = false;

  void backButtonPressed() {
    if (currentStep$.value > 0) {
      if (authUserStore.loggedIn && currentStep$ < 3) {
        Get.snackbar(
            'Not allowed!', 'You have already started creating your account');
        return;
      }
      previousStep();
    } else {
      // resetSteps();
      Get.back();
    }
  }

  void nextStep() {
    setIndex(currentStep$.value + 1);
  }

  void previousStep() {
    setIndex(currentStep$.value - 1);
  }

  void setIndex(int value) {
    if (value < currentStep$.value) {
      reverse = true;
    } else {
      reverse = false;
    }
    currentStep$.value = value;
  }
}
