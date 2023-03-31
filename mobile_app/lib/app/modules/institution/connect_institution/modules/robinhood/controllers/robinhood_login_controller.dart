import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:graphql/client.dart';
import 'package:iris_mobile/app/modules/institution/classes/connect_institution_arts.dart';
import 'package:iris_mobile/app/modules/referrals/referrals.dart';

import '../../../../../../routes/pages.dart';
import '../../../../../profile/controllers/profile_controller.dart';

class RobinhoodLoginController extends GetxController {
  RxInt activeTab$ = 0.obs;
  final formKey = GlobalKey<FormBuilderState>();
  String? email;
  Rx<DateTime?> dateTime$ = Rx(null);
  String? password;
  int? portfolioKey;
  Rx<API_STATUS> apiStatus$ = API_STATUS.NOT_STARTED.obs;
  LocalAuthenticationService localAuth = Get.find();
  ISecureStorage secureStorage = Get.find();
  List<INSTITUTION_CONNECT_CHALLENGE_TYPE> verifyCodeChallengeTypes = [
    INSTITUTION_CONNECT_CHALLENGE_TYPE.EMAIL,
    INSTITUTION_CONNECT_CHALLENGE_TYPE.SMS,
    INSTITUTION_CONNECT_CHALLENGE_TYPE.APP,
  ];
  Rx<InstitutionConnectResponse?> connectResponse$ =
      Rx<InstitutionConnectResponse?>(null);
  Rx<Color> pinColorCode$ = Colors.transparent.obs;

  FocusNode pinFocusNode = FocusNode();
  FocusNode tradPinFocusNode = FocusNode();
  RxBool timeExpired$ = RxBool(false);
  RxString dialCode$ = RxString('+1');
  RxBool invalidCreds$ = RxBool(false);
  RxBool invalidVerificationCode$ = RxBool(false);
  RxString errorText$ = RxString('');
  RxString institutionConnectErrorText$ = RxString('');
  TextEditingController pinCodeController = TextEditingController();

  TextEditingController pinCodeTradLoginController = TextEditingController();
  final RxInt currentStep$ = RxInt(0);
  final RxInt secondsRemaining$ = RxInt(120);
  final InstitutionService institutionService = Get.find();

  Rx<Map<String?, bool?>> accountSelectedMap$ = Rx({});

  bool get isApp =>
      connectResponse$.value?.challengeType ==
      INSTITUTION_CONNECT_CHALLENGE_TYPE.APP;

  RobinhoodLoginController({this.portfolioKey, int? selectedTab}) {
    if (selectedTab != null) activeTab$.value = selectedTab;
  }

  addAccounts() async {
    debugPrint('starting to add accounts');
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

    final String brokerUsernameKey = 'iris-username-portfolio-$portfolioKey';
    final String brokerPasswordKey = 'iris-password-portfolio-$portfolioKey';
    final String activeTabKey = 'iris-active-tab-$portfolioKey';

    String? userNameValue;
    String? password;

    final res = getUsernamePassword();

    userNameValue = res?.first;
    password = res?.last;
    Future.wait([
      secureStorage.upsert(key: brokerUsernameKey, value: userNameValue),
      secureStorage.upsert(key: brokerPasswordKey, value: password),
      secureStorage.upsert(
          key: activeTabKey, value: activeTab$.value.toString()),
    ]);

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

  connect({bool? navigateWhenLinked}) async {
    try {
      final res = await submit();
      setConnectResponse(res, errorText: 'Invalid Creds');
    } catch (err) {
      if (err is InstitutionError) {
        invalidCreds$.value = true;
      }
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

  String formatSeconds(int seconds) {
    return '$seconds';
  }

  getPortfolioLogin() async {
    if (portfolioKey == null) {
      return;
    }
    final String brokerUsernameKey = 'iris-username-portfolio-$portfolioKey';
    final String brokerPasswordKey = 'iris-password-portfolio-$portfolioKey';
    final List<String?> data = await Future.wait([
      secureStorage.read(key: brokerUsernameKey),
      secureStorage.read(key: brokerPasswordKey),
    ]);
    final String? keychainUsername = data[0];
    final String? keychainPassword = data[1];

    if (keychainUsername != null) {
      formKey.currentState!.fields['username']!.didChange(keychainUsername);
    }

    if (keychainPassword != null) {
      formKey.currentState!.fields['password']!.didChange(keychainPassword);
    }
  }

  Set<String?>? getUsernamePassword() {
    String? userNameValue;
    String? password;
    if (!formKey.currentState!.validate()) {
      return null;
    }
    final val = formKey.currentState!.fields;
    userNameValue = val['username']?.value;
    password = val['password']?.value;

    return {userNameValue, password};
  }

  void handleError(String message) {
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

  @override
  void onInit() {
    getPortfolioLogin();
    super.onInit();
  }

  Future<void> resendCode() async {
    timeExpired$.value = false;
    final res = await submit();
    connectResponse$.value = res;
    resetTimer();
    invalidVerificationCode$.value = false;
  }

  void resetTimer() {
    secondsRemaining$.value++;
  }

  Future<InstitutionConnectResponse?> respondToChallenge(
      String challengeValue) async {
    try {
      final challengeId = connectResponse$.value!.challengeId ?? '';
      final InstitutionConnectResponse? res = await overlayLoader(
        context: Get.overlayContext!,
        asyncFunction: () async {
          try {
            return await institutionService.respondToChallenge(
              challengeId: challengeId,
              challengeResponseValue: challengeValue,
              institutionKey:
                  connectResponse$.value!.institution!.institutionKey!,
            );
          } catch (err) {
            rethrow;
          }
        },
        opacity: .7,
        loaderColor: IrisColor.primaryColor,
      );
      return res;
    } catch (err) {
      rethrow;
    }
  }

  void setAccountSelectedMap() {
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

  void setConnectResponse(InstitutionConnectResponse? res,
      {String? errorText = 'Invalid code'}) {
    if (res != null && res.institution != null) {
      connectResponse$.value = res;
      setRobinhoodFlowIndex();
    } else {
      debugPrint('ERROR $errorText');
      errorText$.value = errorText!;
    }
  }

  void setRobinhoodFlowIndex() {
    if (connectResponse$.value == null) {
      currentStep$.value = 0;
      return;
    }

    final INSTITUTION_CONNECT_CHALLENGE_TYPE? challengeType =
        connectResponse$.value!.challengeType;

    if (verifyCodeChallengeTypes.contains(challengeType)) {
      currentStep$.value = 1;
      pinFocusNode.requestFocus();
      return;
    }

    if (connectResponse$.value!.connectStep ==
        INSTITUTION_CONNECT_STEP.LOGIN_COMPLETE) {
      setAccountSelectedMap();
      currentStep$.value = 2;
      return;
    }
  }

  Future<InstitutionConnectResponse?> submit() async {
    invalidVerificationCode$.value = false;
    institutionConnectErrorText$.value = '';
    errorText$.value = '';
    String? userNameValue;
    String? password;

    final res = getUsernamePassword();

    userNameValue = res?.first;
    password = res?.last;

    var args = Get.arguments;
    INSTITUTION_CONNECTED_FROM connectedFrom =
        INSTITUTION_CONNECTED_FROM.PROFILE;
    if (args != null && args is ConnectInstitutionArgs) {
      connectedFrom = args.from;
    }
    try {
      if (userNameValue != null && password != null) {
        final InstitutionConnectResponse? res = await overlayLoader(
          context: Get.overlayContext!,
          asyncFunction: () async {
            try {
              return await institutionService.connect(
                  institutionName: INSTITUTION_NAME.ROBINHOOD,
                  username: userNameValue,
                  password: password,
                  connectedFrom: connectedFrom);
            } catch (err) {
              if (err is InstitutionError) {
                handleError(err.message);
              }
            }
            return null;
          },
          opacity: .7,
          loaderColor: IrisColor.primaryColor,
        );
        return res;
      }
    } catch (err) {
      debugPrint(err.toString());
    }
    return null;
  }

  Future<void> verifyCode(String challengeValue) async {
    try {
      invalidVerificationCode$.value = false;
      institutionConnectErrorText$.value = '';
      errorText$.value = '';
      final res = await respondToChallenge(challengeValue);
      setConnectResponse(res, errorText: 'Invalid Code!');
    } catch (err) {
      final errors = err as List;
      final GraphQLError error = errors[0];
      String message = '';
      if (error.message.contains('Please input correct verification')) {
        message = 'Invalid Code!';
      } else {
        message = error.message;
      }
      institutionConnectErrorText$.value = message;
    }
  }
}
