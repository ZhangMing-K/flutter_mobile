import 'package:get/get.dart';

import '../../../iris_common.dart';

class SocialLinkButtonController extends GetxController {
  final SocialService socialService = Get.find();
  SOCIAL_SOURCE? source;
  int? userKey;
  String? urlToLaunch;
  late Rx<Integration?> integration$;
  final IAuthUserService authUserStore = Get.find();

  getUrlToLaunch() {
    switch (source) {
      case SOCIAL_SOURCE.TWITTER:
        return 'https://twitter.com/${integration$.value?.username}';
      default:
    }
  }

  launchUrl() async {
    final urlToLaunch = getUrlToLaunch();

    UrlUtils.open(urlToLaunch);
  }

  setIntegration(Integration? integration) {
    integration$ =
        integration != null ? integration.obs : Rx<Integration?>(null);
  }
}
