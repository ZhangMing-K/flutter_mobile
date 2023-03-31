import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:graphql/client.dart';
import 'package:iris_mobile/app/modules/referrals/referrals.dart';

import '../../../../../../routes/pages.dart';
import '../../../../../profile/controllers/profile_controller.dart';
import '../../../../classes/connect_institution_arts.dart';

class WebullLoginController extends GetxController {
  RxInt activeTab$ = 0.obs;
  final emailFormKey = GlobalKey<FormBuilderState>();
  final mobileFormKey = GlobalKey<FormBuilderState>();
  final questionFormKey = GlobalKey<FormBuilderState>();
  String? email;
  Rx<DateTime?> dateTime$ = Rx(null);
  String? password;
  int? portfolioKey;
  String? birthdayWebullQuestionId = '1001';
  Rx<API_STATUS> apiStatus$ = API_STATUS.NOT_STARTED.obs;
  LocalAuthenticationService localAuth = Get.find();
  ISecureStorage secureStorage = Get.find();
  List<INSTITUTION_CONNECT_CHALLENGE_TYPE> verifyCodeChallengeTypes = [
    INSTITUTION_CONNECT_CHALLENGE_TYPE.EMAIL,
    INSTITUTION_CONNECT_CHALLENGE_TYPE.SMS
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
  RxBool invalidTradeLogin$ = RxBool(false);
  RxString invalidAnswerErrorText$ = RxString('');
  RxString errorText$ = RxString('');
  RxString institutionConnectErrorText$ = RxString('');
  TextEditingController pinCodeController = TextEditingController();

  TextEditingController pinCodeTradLoginController = TextEditingController();
  final RxInt currentStep$ = RxInt(0);
  final RxInt secondsRemaining$ = RxInt(60);
  final InstitutionService institutionService = Get.find();

  RxBool passwordIncorrect$ = false.obs;
  Rx<Map<String?, bool?>> accountSelectedMap$ = Rx({});

  WebullLoginController({this.portfolioKey, int? selectedTab}) {
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

    userNameValue = res.first;
    password = res.last;
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
      setConnectResponse(res!, errorText: 'Invalid Creds');
    } catch (err) {
      debugPrint(err.toString());
      if (err is InstitutionError) {
        passwordIncorrect$.value = true;
      }
    }
  }

  void doneProcess() {
    Get.offAndToNamed(ReferralsScreen.routeName());
  }

  enterTradeLogin(String challengeValue) async {
    try {
      final res = await respondToChallenge(challengeValue);
      setConnectResponse(res!, errorText: 'Invalid Creds');
      invalidTradeLogin$.value = false;
    } catch (err) {
      debugPrint('ERROR $err');
      invalidTradeLogin$.value = true;
    }
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
      if (activeTab$.value == 0) {
        emailFormKey.currentState!.fields['email']!.didChange(keychainUsername);
      } else if (activeTab$.value == 1) {
        final String phoneNumber = keychainUsername.split('-')[1];
        mobileFormKey.currentState!.fields['mobile']!.didChange(phoneNumber);
      }
    }

    if (keychainPassword != null) {
      if (activeTab$.value == 0) {
        emailFormKey.currentState!.fields['password']!
            .didChange(keychainPassword);
      } else if (activeTab$.value == 1) {
        mobileFormKey.currentState!.fields['password']!
            .didChange(keychainPassword);
      }
    }
  }

  getUsernamePassword() {
    String? userNameValue;
    String? password;
    if (activeTab$.value == 0) {
      if (!emailFormKey.currentState!.validate()) {
        return null;
      }
      final val = emailFormKey.currentState!.fields;
      userNameValue = val['email']?.value;
      password = val['password']?.value;
    }
    if (activeTab$.value == 1) {
      if (!mobileFormKey.currentState!.validate()) {
        return null;
      }
      final val = mobileFormKey.currentState!.fields;
      userNameValue = val['mobile']?.value;
      password = val['password']?.value;

      userNameValue = '${dialCode$.value}-$userNameValue';
    }

    return {userNameValue, password};
  }

  handleError(String message) {
    if (message.contains('frequent')) {
      Get.dialog(IrisDialog(
          title:
              'Webull is having issues sending verification codes for your account',
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
  onInit() async {
    await getPortfolioLogin();
  }

  resendCode() async {
    timeExpired$.value = false;
    final res = await submit();
    connectResponse$.value = res;
    resetTimer();
    invalidVerificationCode$.value = false;
  }

  resetTimer() {
    secondsRemaining$.value++;
  }

  respondToChallenge(String challengeValue) async {
    try {
      final InstitutionConnectResponse? res = await overlayLoader(
        context: Get.overlayContext!,
        asyncFunction: () async {
          try {
            return await institutionService.respondToChallenge(
              challengeId: connectResponse$.value!.challengeId!,
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

  setAccountSelectedMap() {
    if (connectResponse$.value?.institution?.institutionAccounts != null) {
      for (var element
          in connectResponse$.value!.institution!.institutionAccounts!) {
        if (element.isBrokerage == false) {
          if (element.portfolio != null) {
            accountSelectedMap$.value[element.accountId] = true;
          } else {
            accountSelectedMap$.value[element.accountId] = true;
          }
        }
      }
    }
  }

  setConnectResponse(InstitutionConnectResponse res,
      {String? errorText = 'Invalid code'}) {
    if (res.institution != null) {
      connectResponse$.value = res;
      setWebullFlowIndex();
    } else {
      errorText$.value = errorText!;
    }
  }

  setWebullFlowIndex() {
    if (connectResponse$.value == null) {
      currentStep$.value = 0;
      return;
    }

    final INSTITUTION_CONNECT_CHALLENGE_TYPE? challengeType =
        connectResponse$.value!.challengeType;

    if (verifyCodeChallengeTypes.contains(challengeType) &&
        connectResponse$.value!.challengeOptions!.isEmpty) {
      currentStep$.value = 1;
      pinFocusNode.requestFocus();
      return;
    }

    if (challengeType == INSTITUTION_CONNECT_CHALLENGE_TYPE.SECURITY_QUESTION &&
        connectResponse$.value!.challengeOptions!.isNotEmpty) {
      currentStep$.value = 2;
      return;
    }

    if (challengeType == INSTITUTION_CONNECT_CHALLENGE_TYPE.TRADE_LOGIN) {
      currentStep$.value = 3;
      return;
    }

    if (connectResponse$.value!.connectStep ==
        INSTITUTION_CONNECT_STEP.LOGIN_COMPLETE) {
      setAccountSelectedMap();
      currentStep$.value = 4;
      return;
    }
  }

  Future<InstitutionConnectResponse?> submit() async {
    String? userNameValue;
    String? password;

    final res = getUsernamePassword();

    userNameValue = res.first;
    password = res.last;
    var args = Get.arguments;
    INSTITUTION_CONNECTED_FROM connectedFrom =
        INSTITUTION_CONNECTED_FROM.PROFILE;
    if (args != null && args is ConnectInstitutionArgs) {
      debugPrint("GOTTEN FROM ARGS ${args.from}");
      connectedFrom = args.from;
    }
    try {
      if (userNameValue != null && password != null) {
        final InstitutionConnectResponse? res = await overlayLoader(
          context: Get.overlayContext!,
          asyncFunction: () async {
            try {
              return await institutionService.connect(
                  institutionName: INSTITUTION_NAME.WEBULL,
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

  submitAnswer({bool? nextQuestion}) async {
    String answer;
    invalidAnswerErrorText$.value = '';
    if (nextQuestion == true) {
      answer = 'NEXT_QUESTION';
    } else {
      final bool isBirthdayQuestion =
          connectResponse$.value?.challengeId == birthdayWebullQuestionId;
      if (isBirthdayQuestion) {
        if (dateTime$.value == null) {
          return null;
        }
        final String month = dateTime$.value!.month.toString();
        final String day = dateTime$.value!.day.toString();

        answer = formatDate(month) + formatDate(day);
      } else {
        if (!questionFormKey.currentState!.validate()) {
          return null;
        }
        final val = questionFormKey.currentState!.fields;
        answer = val['answer']?.value;
      }
    }

    try {
      final res = await respondToChallenge(answer);
      setConnectResponse(res!, errorText: 'Invalid Answer');
    } catch (err) {
      final errors = err as List;

      final message = errors[0].message!;
      if (message.contains('verification attempts')) {
        invalidAnswerErrorText$.value =
            'Unavailable because of too many failed verification attempts. Please go to the Webull website to reset the security questions.';
      } else {
        invalidAnswerErrorText$.value = errors[0].message!;
      }
    }
  }

  verifyCode(String challengeValue) async {
    try {
      invalidVerificationCode$.value = false;
      final res = await respondToChallenge(challengeValue);
      setConnectResponse(res!, errorText: 'Invalid Creds');
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
