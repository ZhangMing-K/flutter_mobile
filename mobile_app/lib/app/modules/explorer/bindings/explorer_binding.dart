import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import '../controllers/explorer_controller.dart';
import '../modules/order_flow_summary/controller/order_flow_summary_controller.dart';
import '../modules/stocks/controllers/stocks_controller.dart';
import '../modules/top_investors/controllers/top_investors_controller.dart';
import '../modules/who_to_follow/controllers/who_to_follow_controller.dart';

class ExplorerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ITagAnalysisRepository>(TagAnalysisRepository(
      remoteProvider: Get.find(),
      repository: Get.find(),
    ));

    Get.put<ITradeAnalysisRepository>(TradeAnalysisRepository(
      remoteProvider: Get.find(),
      repository: Get.find(),
    ));
    Get.put<ISearchRepository>(SearchRepository(
      remoteProvider: Get.find(),
      repository: Get.find(),
    ));
    Get.put(WhoToFollowController(repository: Get.find(), storage: Get.find()));
    Get.put<IAnalyticsOrderFlowRepository>(AnalyticsOrderFlowRepository(
        remoteProvider: Get.find(), repository: Get.find()));
    Get.put(OrderFlowSummaryController(
        irisEvent: Get.find(), repository: Get.find()));

    Get.put(TopInvestorsController(repository: Get.find()));
    Get.put(
        StocksController(repository: Get.find(), tradeRepository: Get.find()));
    Get.put(ExplorerController(
      repository: Get.find(),
      whoToFollowController: Get.find(),
      //  stocksController: Get.find(),
      irisEvent: Get.find(),
      storage: Get.find(),
    ));
  }
}
