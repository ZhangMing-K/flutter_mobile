import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:iris_mobile/app/modules/feed/shared/mixins/scroll_controller_mixin.dart';
import 'package:iris_mobile/app/routes/pages.dart';

class OrderFlowSummaryController extends GetxController
    with ScrollControllerMixin {
  final IrisEvent irisEvent;
  final IAnalyticsOrderFlowRepository repository;

  RxList<OrderFlow> optionsOrderFlow = <OrderFlow>[].obs;
  RxList<OrderFlow> equityOrderFlow = <OrderFlow>[].obs;
  RxList<OrderFlow> cryptoOrderFlow = <OrderFlow>[].obs;

  Rx<API_STATUS> apiStatusOptions$ = Rx(API_STATUS.PENDING);
  Rx<API_STATUS> apiStatusEquity$ = Rx(API_STATUS.PENDING);
  Rx<API_STATUS> apiStatusCrypto$ = Rx(API_STATUS.PENDING);

  OrderFlowSummaryController({
    required this.repository,
    required this.irisEvent,
  });

  @override
  void onInit() {
    getOrderFlows(positionType: POSITION_TYPE.OPTION);
    getOrderFlows(positionType: POSITION_TYPE.EQUITY);
    getOrderFlows(positionType: POSITION_TYPE.CRYPTO);
    super.onInit();
  }

  void onError(err) {}

  Future<void> getOrderFlows({positionType = POSITION_TYPE.OPTION}) async {
    await repository.getOrderFlows(
        positionType: positionType,
        callback: onSuccessGetOrderFlows,
        assetKeys: [],
        limit: 5,
        onError: onError);
  }

  void onSuccessGetOrderFlows(AnalyticsOrderFlowData<OrderFlow> data) {
    final AnalyticsOrderFlowFilterFields filterFields = data.filterFields;
    final POSITION_TYPE positionType = filterFields.positionType;
    switch (positionType) {
      case POSITION_TYPE.OPTION:
        optionsOrderFlow.assignAll(data.list);
        apiStatusOptions$.value = API_STATUS.FINISHED;
        break;
      case POSITION_TYPE.EQUITY:
        equityOrderFlow.assignAll(data.list);
        apiStatusEquity$.value = API_STATUS.FINISHED;
        break;
      case POSITION_TYPE.CRYPTO:
        cryptoOrderFlow.assignAll(data.list);
        apiStatusCrypto$.value = API_STATUS.FINISHED;
        break;
      default:
        break;
    }
  }
}
