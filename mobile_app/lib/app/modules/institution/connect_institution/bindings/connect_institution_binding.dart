import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:iris_mobile/app/modules/institution/connect_institution/modules/etrade/controllers/etrade_login_controller.dart';

import '../controllers/connect_institution_controller.dart';
import '../modules/fidelity/controllers/fidelity_login_controller.dart';
import '../modules/robinhood/controllers/robinhood_login_controller.dart';
import '../modules/schwab/controllers/schwab_login_controller.dart';
import '../modules/td_ameritrade/controllers/td_ameritrade_login_controller.dart';
import '../modules/webull_login/controllers/webull_login_controller.dart';

class ConnectInstitutionsBinding extends Bindings {
  @override
  void dependencies() {
    final String? institutionNameStr = Get.parameters['institutionName'];
    final String? institutionKeyStr = Get.parameters['institutionKey'];
    final args = Get.arguments;

    int? portfolioKey;
    int? institutionKey;
    int? selectedTab;

    if (Get.parameters['portfolioKey'] != null &&
        Get.parameters['portfolioKey'] != '') {
      portfolioKey = int.tryParse(Get.parameters['portfolioKey']!);
    }

    if (args is ConnectInstitutionTabArgs) {
      selectedTab = args.selectedTab;
    }

    if (institutionKeyStr != null) {
      institutionKey = int.tryParse(institutionKeyStr);
    }
    final INSTITUTION_NAME? institutionName = enumFromString<INSTITUTION_NAME>(
        INSTITUTION_NAME.values, institutionNameStr);

    Get.lazyPut<IProfileRepository>(
      () => ProfileRepository(
        remoteProvider: Get.find(),
      ),
      fenix: true,
    );

    Get.put(ConnectInstitutionController(
      institutionName: institutionName,
      institutionKey: institutionKey,
    ));
    switch (institutionName) {
      case INSTITUTION_NAME.WEBULL:
        Get.put(WebullLoginController(
            portfolioKey: portfolioKey, selectedTab: selectedTab));
        break;
      case INSTITUTION_NAME.ROBINHOOD:
        Get.put(RobinhoodLoginController(portfolioKey: portfolioKey));
        break;
      case INSTITUTION_NAME.TD_AMERITRADE:
        Get.put(TDAmeritradeLoginController(portfolioKey: portfolioKey));
        break;
      case INSTITUTION_NAME.FIDELITY:
        Get.put(FidelityLoginController(portfolioKey: portfolioKey));
        break;
      case INSTITUTION_NAME.ETRADE:
        Get.put(EtradeLoginController(portfolioKey: portfolioKey));
        break;
      case INSTITUTION_NAME.SCHWAB:
        Get.put(SchwabLoginController(portfolioKey: portfolioKey));
        break;
      default:
        Get.put(WebullLoginController(
            portfolioKey: portfolioKey, selectedTab: selectedTab));
        break;
    }
  }
}
