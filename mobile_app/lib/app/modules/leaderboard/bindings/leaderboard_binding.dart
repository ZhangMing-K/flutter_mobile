import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import '../controllers/leaderboard_controller.dart';
import '../modules/portfolios/controllers/portfolios_controller.dart';

class LeaderboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ILeaderboardRepository>(LeaderboardRepository(
      remoteProvider: Get.find(),
      repository: Get.find(),
    ));

    Get.put(PortfoliosLeaderboardController(repository: Get.find()));
    Get.put(LeaderboardController(
      repository: Get.find(),
      portfoliosLeaderboardController: Get.find(),
      irisEvent: Get.find(),
    ));
  }
}
