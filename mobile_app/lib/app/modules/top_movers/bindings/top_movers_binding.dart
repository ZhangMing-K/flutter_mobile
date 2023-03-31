import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import '../controllers/top_movers_controller.dart';
import '../modules/day/controllers/day_controller.dart';
import '../modules/month/controllers/month_controller.dart';
import '../modules/week/controllers/week_controller.dart';
import '../modules/year/controllers/year_controller.dart';

class TopMoversBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ITopMoversRepository>(TopMoversRepository(
      //localProvider: Get.find(),
      remoteProvider: Get.find(),
    ));
    Get.put(DayController(repository: Get.find()));
    Get.put(WeekController(repository: Get.find()));
    Get.put(MonthController(repository: Get.find()));
    Get.put(YearController(repository: Get.find()));
    Get.put(TopMoversController(
      dayController: Get.find(),
      weekController: Get.find(),
      monthController: Get.find(),
      yearController: Get.find(),
      repository: Get.find(),
    ));
  }
}
