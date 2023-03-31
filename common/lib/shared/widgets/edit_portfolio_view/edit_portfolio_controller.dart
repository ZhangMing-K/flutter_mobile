import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../../../iris_common.dart';

class EditPortfolioViewController extends GetxController {
  Portfolio? portfolio;
  GlobalKey<FormBuilderState>? fbKey;
  final PortfolioService portfolioService = Get.find();

  ISecureStorage secureStorage = Get.find();
  Rx<Portfolio?> portfolio$ = Rx(null);
  final IAuthUserService authUserStore = Get.find();
  final Events events = Get.find();

  EditPortfolioViewController({required this.portfolio}) {
    portfolio$.value = portfolio;
  }

  changePortfolioName() async {
    // portfolio$.value = await portfolioService.portfolioUpdate(
    //     portfolioKey: portfolio$.value.portfolioKey,
    //     portfolioName: portfolioNameController.value.text);
  }

  void deletePost() async {
    await portfolioService.portfolioDelete(
        portfolioKey: portfolio$.value!.portfolioKey);
    Get.back(result: SELECT_ITEM_MENU.DELETE);
    final List<Portfolio> authUserPortfolios = authUserStore
        .loggedUser!.portfolios!
        .where(
            (element) => element.portfolioKey != portfolio$.value!.portfolioKey)
        .toList();
    authUserStore.editUserData(
        authUserStore.loggedUser!.copyWith(portfolios: authUserPortfolios));
    events.portfolioDeleted(PortfolioDeletedEvent(portfolio: portfolio$.value));
  }

  disconnectPortfolio() async {
    portfolio$.value = portfolio$.value!
        .copyWith(connectionStatus: CONNECTION_STATUS.DISCONNECTED);
    portfolio$.value = await overlayLoader(
      context: Get.overlayContext!,
      asyncFunction: () {
        return portfolioService.disconnect(
            portfolioKey: portfolio$.value!.portfolioKey);
      },
    );
  }

  getPortfolio() async {
    portfolio$.value = await portfolioService.portfolioGet(
        portfolioKey: portfolio$.value!.portfolioKey, requestedFields: '''
         portfolios{
          brokerName
          portfolioName
        }
        ''');
  }

  Future<ConnectInstitutionTabArgs?> getReconnectArgs(int portfolioKey) async {
    final String activeTabKey = 'iris-active-tab-$portfolioKey';
    final String? selectedTabString =
        await secureStorage.read(key: activeTabKey);

    if (selectedTabString != null) {
      return ConnectInstitutionTabArgs(
          selectedTab: int.parse(selectedTabString));
    }
    return null;
  }

  onChangedPublic() async {
    final mapValues = fbKey!.currentState!.value;
    portfolio$.value = await portfolioService.portfolioUpdate(
        portfolioKey: portfolio$.value!.portfolioKey,
        portfolioName: mapValues['portfolioName'],
        portfolioVisibilitySetting: mapValues['portfolioVisibilitySetting'],
     );
    Get.back(result: portfolio$.value);
  }

  onDeleteTap() async {
    final res = await Get.dialog(
      IrisDialog(
        title: 'Delete Portfolio?',
        subtitle:
            'Are you sure you want to delete this portfolio? You can always sync again later.',
        onCancel: () => Get.back(),
        confirmButtonText: 'Delete',
        confirmIsDestructive: true,
        onConfirm: () => deletePost(),
      ),
    );

    if (res == SELECT_ITEM_MENU.DELETE) Get.back(result: true);
  }

  onSubmit() {
    if (fbKey!.currentState!.saveAndValidate()) {
      onChangedPublic();
    }
  }

  reconnectPortfolio() async {
    BROKER_NAME brokerName = portfolio$.value!.brokerName!;
    dynamic args = await getReconnectArgs(portfolio$.value!.portfolioKey!);

    Get.toNamed(
        Paths.ConnectInstitution.createPath([
          describeEnum(brokerName),
          portfolio$.value!.portfolioKey,
        ]),
        arguments: args);
  }
}
