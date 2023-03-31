import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../../../../routes/pages.dart';
import '../../classes/connect_institution_arts.dart';

class ConnectInstitutionController extends GetxController {
  INSTITUTION_NAME? institutionName;
  int? institutionKey;
  final InstitutionService institutionService = Get.find();
  Rx<InstitutionConnectResponse?> connectResponse$ =
      Rx<InstitutionConnectResponse?>(null);

  GlobalKey<FormBuilderState> loginFormKey = GlobalKey<FormBuilderState>();
  Rx<API_STATUS> apiStatus$ = API_STATUS.NOT_STARTED.obs;

  AnimationController? animationController;
  Map<INSTITUTION_NAME, Duration> brokerDurationLoading = {
    INSTITUTION_NAME.FIDELITY: const Duration(seconds: 30)
  };

  RxBool passwordIncorrect$ = false.obs;

  Rx<Map<String?, bool?>> accountSelectedMap$ = Rx({});

  ConnectInstitutionController(
      {required this.institutionName, this.institutionKey});

  List<InstitutionAccount>? get institutionAccounts {
    if (connectResponse$.value?.institution?.institutionAccounts == null) {
      return <InstitutionAccount>[];
    }
    return connectResponse$.value?.institution?.institutionAccounts
        ?.where((element) => element.isBrokerage == true)
        .toList();
  }

  Duration? get loginDuration {
    return brokerDurationLoading[institutionName!];
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
      apiStatus$.value = API_STATUS.PENDING;
      await institutionService.addAccounts(
          accountIds: accountIds,
          institutionKey: connectResponse$.value!.institution!.institutionKey);
      apiStatus$.value = API_STATUS.FINISHED;

      Get.until((route) => route.settings.name == Paths.Feed);
    } catch (err) {
      apiStatus$.value = API_STATUS.FINISHED;
      Get.dialog(IrisDialog(
          title: 'Error adding account',
          onConfirm: () => Get.back(),
          subtitle: err.toString()));
    }
  }

  cancelAddAccounts() {
    Get.back();
  }

  connect() async {
    loginFormKey.currentState!.save();
    if (!loginFormKey.currentState!.validate()) {
      return;
    }

    apiStatus$.value = API_STATUS.PENDING;
    final val = loginFormKey.currentState!.value;
    final String? username = val['username'];
    final String? password = val['password'];

    var args = Get.arguments;
    INSTITUTION_CONNECTED_FROM connectedFrom =
        INSTITUTION_CONNECTED_FROM.PROFILE;
    if (args != null && args is ConnectInstitutionArgs) {
      debugPrint("GOTTEN FROM ARGS ${args.from}");
      connectedFrom = args.from;
    }

    try {
      connectResponse$.value = await institutionService.connect(
          institutionName: institutionName!,
          username: username,
          password: password,
          connectedFrom: connectedFrom);

      setAccountSelectedMap();
      apiStatus$.value = API_STATUS.FINISHED;
    } catch (err) {
      apiStatus$.value = API_STATUS.FINISHED;
      debugPrint(err.toString());
      if (err is InstitutionError) {
        passwordIncorrect$.value = true;
      }
    }
  }

  setAccountSelectedMap() {
    for (var element in institutionAccounts!) {
      if (element.portfolio != null) {
        accountSelectedMap$.value[element.accountId] = true;
      } else {
        accountSelectedMap$.value[element.accountId] = true;
      }
    }
  }
}
