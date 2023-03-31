import 'package:get/get.dart';

class ProfileMiddleware extends GetMiddleware {
  // @override
  // GetPage? onPageCalled(GetPage? page) {
  //   final profileUtils = ProfileUtils(authUserStore: Get.find());
  //   final profileKey = profileUtils.getProfileKeyFromArguments;
  //   if (profileKey != null) {
  //     final newPage = page?.copy(
  //         transition: Transition.cupertino,
  //         transitionDuration: const Duration(milliseconds: 400));

  //     return super.onPageCalled(newPage);
  //   } else {
  //     final newPage = page?.copy(
  //       transitionDuration: Duration.zero,
  //       transition: Transition.noTransition,
  //     );
  //     return super.onPageCalled(newPage);
  //   }
  // }
}
