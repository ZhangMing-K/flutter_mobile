import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:iris_mobile/app/modules/referrals/referrals.dart';

import '../../../../../../routes/pages.dart';
import '../../../../../profile/controllers/profile_controller.dart';
import '../../../../classes/connect_institution_arts.dart';

class TDAmeritradeLoginController extends GetxController {
  RxInt activeTab$ = 0.obs;
  String? email;
  Rx<DateTime?> dateTime$ = Rx(null);
  int? portfolioKey;
  Rx<API_STATUS> apiStatus$ = API_STATUS.NOT_STARTED.obs;
  Rx<InstitutionConnectResponse?> connectResponse$ =
      Rx<InstitutionConnectResponse?>(null);

  RxBool invalidCreds$ = RxBool(false);

  RxBool invalidVerificationCode$ = RxBool(false);
  RxString errorText$ = RxString('');
  RxString institutionConnectErrorText$ = RxString('');
  final RxInt currentStep$ = RxInt(0);

  final InstitutionService institutionService = Get.find();

  Rx<Map<String?, bool?>> accountSelectedMap$ = Rx({});

  TDAmeritradeLoginController({this.portfolioKey, int? selectedTab}) {
    if (selectedTab != null) activeTab$.value = selectedTab;
    Timer(const Duration(milliseconds: 750), connectOauth);
  }

  addAccounts() async {
    final List<String?> accountIds = [];
    accountSelectedMap$.value.forEach((key, value) {
      if (value!) {
        accountIds.add(key);
      }
    });

    if (accountIds.isEmpty) {
      Get.dialog(IrisDialog(
          title: 'No accounts selected',
          onConfirm: () => Get.back(),
          subtitle: 'Please select an account to connect'));
      return;
    }
    try {
      await overlayLoader(
        context: Get.overlayContext!,
        asyncFunction: () async {
          try {
            final accounts = await institutionService.addAccounts(
                accountIds: accountIds,
                institutionKey:
                    connectResponse$.value!.institution!.institutionKey);

            int? portfolioKey;
            if (accounts!.isNotEmpty == true) {
              portfolioKey = accounts[0].portfolio!.portfolioKey;
            }
            await complete(portfolioKey: portfolioKey);
          } catch (err) {
            Get.dialog(IrisDialog(
                title: 'Error adding account',
                onConfirm: () => Get.back(),
                subtitle: err.toString()));
          }
        },
        opacity: .7,
        loaderColor: IrisColor.primaryColor,
      );
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  // TODO: remove if not needed
  cancelAddAccounts() {
    Get.back();
  }

  complete({int? portfolioKey}) async {
    if (Get.isRegistered<ProfileController>()) {
      final ProfileController profilePortfolioController = Get.find();

      await profilePortfolioController.portfoliosNotifier.updatePortfolios();
    }

    if (portfolioKey == null) {
      return debugPrint('portfolioKey not given, cannot redirect');
    }

    var args = Get.arguments;
    INSTITUTION_CONNECTED_FROM connectedFrom =
        INSTITUTION_CONNECTED_FROM.PROFILE;
    if (args != null && args is ConnectInstitutionArgs) {
      connectedFrom = args.from;
    }
    if (connectedFrom == INSTITUTION_CONNECTED_FROM.ONBOARDING) {
      Get.toNamed(Paths.ContactsPermission);
      // Get.until((route) => route.settings.name == Paths.PortfolioConnect);
    } else {
      Get.until((route) => route.settings.name == Paths.Feed);
    }
  }

  connectInstitutionOauth({String? oAuthKey, BROKER_NAME? brokerName}) async {
    var args = Get.arguments;
    INSTITUTION_CONNECTED_FROM connectedFrom =
        INSTITUTION_CONNECTED_FROM.PROFILE;
    if (args != null && args is ConnectInstitutionArgs) {
      connectedFrom = args.from;
    }
    await overlayLoader(
      context: Get.overlayContext!,
      asyncFunction: () async {
        final institutionConnectResponse = await institutionService.connect(
            institutionName: INSTITUTION_NAME.TD_AMERITRADE,
            oauthKey: oAuthKey,
            username: '',
            password: '',
            connectedFrom: connectedFrom);
        setConnectResponse(institutionConnectResponse);
      },
      opacity: .7,
      loaderColor: Get.context!.theme.primaryColor,
    );
  }

  connectOauth() async {
    final oauthUrl =
        ENV.GRAPHQL_API_URL!.replaceAll('graphql', 'broker/td/login');
    final oAuthKey = await Get.to(
        () => OauthWebViewContainer(
              url: oauthUrl,
              brokerName: BROKER_NAME.TD_AMERITRADE,
            ),
        transition: Transition.cupertino);
    if (oAuthKey != null) {
      await connectInstitutionOauth(
          oAuthKey: oAuthKey, brokerName: BROKER_NAME.TD_AMERITRADE);
    }
  }

  void doneProcess() {
    Get.offAndToNamed(ReferralsScreen.routeName());
  }

  formatDate(String datePartial) {
    if (datePartial.length == 1) {
      return '0$datePartial';
    } else {
      return datePartial;
    }
  }

  handleError(String message) {
    if (message.contains('frequent')) {
      Get.dialog(IrisDialog(
          title:
              'Robinhood is having issues sending verification codes for your account',
          onConfirm: () {
            Get.back();
          },
          subtitle: 'Try authenticating with your email'));
    } else {
      invalidCreds$.value = true;
    }
  }

  void next() {
    currentStep$.value = currentStep$.value + 1;
  }

  setAccountSelectedMap() {
    if (connectResponse$.value?.institution?.institutionAccounts != null) {
      for (var element
          in connectResponse$.value!.institution!.institutionAccounts!) {
        if (element.isBrokerage == true) {
          if (element.portfolio != null) {
            accountSelectedMap$.value[element.accountId] = true;
          } else {
            accountSelectedMap$.value[element.accountId] = true;
          }
        }
      }
    }
  }

  setConnectResponse(InstitutionConnectResponse? res,
      {String? errorText = 'Invalid code'}) {
    if (res != null && res.institution != null) {
      connectResponse$.value = res;
      setRobinhoodFlowIndex();
    } else {
      debugPrint('ERROR $errorText');
      errorText$.value = errorText!;
    }
  }

  setRobinhoodFlowIndex() {
    if (connectResponse$.value == null) {
      currentStep$.value = 0;
      return;
    }

    if (connectResponse$.value!.connectStep ==
        INSTITUTION_CONNECT_STEP.LOGIN_COMPLETE) {
      setAccountSelectedMap();
      currentStep$.value = 1;
      return;
    }
  }
}
