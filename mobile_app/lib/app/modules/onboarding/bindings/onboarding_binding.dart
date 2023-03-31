// import 'package:get/get.dart';
// import 'package:iris_mobile/app/data/repositories/chat_repository/chat_repository_impl.dart';
// import 'package:iris_mobile/app/data/repositories/chat_repository/chat_repository_interface.dart';
// import 'package:iris_mobile/app/data/repositories/inbox_repository/inbox_repository_impl.dart';
// import 'package:iris_mobile/app/data/repositories/inbox_repository/inbox_repository_interface.dart';
// import 'package:iris_mobile/app/data/repositories/search_repository/search_repository_impl.dart';
// import 'package:iris_mobile/app/data/repositories/search_repository/search_repository_interface.dart';
// import 'package:iris_mobile/app/modules/inbox/controllers/inbox_controller.dart';

// import '../controllers/onboarding_controller.dart';

// class OnboardingBinding extends Bindings {
//   @override
//   void dependencies() {
//     Get.put<ISearchRepository>(SearchRepository(
//       remoteProvider: Get.find(),
//       repository: Get.find(),
//     ));

//     Get.put(OnboardingController(
//       authUserStore: Get.find(),
//       followService: Get.find(),
//       mfaContactService: Get.find(),
//       userService: Get.find(),
//     ));
//   }
// }
