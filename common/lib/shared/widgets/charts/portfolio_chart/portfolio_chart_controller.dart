import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

class PortfolioChartController extends GetxController {
  int portfolioKey;
  Rx<Asset?> asset$ = Rx<Asset?>(null);

  Rx<API_STATUS> apiStatus$ = Rx(API_STATUS.NOT_STARTED);
  final AssetService assetService = Get.find();
  PortfolioChartController({required this.portfolioKey});
}
