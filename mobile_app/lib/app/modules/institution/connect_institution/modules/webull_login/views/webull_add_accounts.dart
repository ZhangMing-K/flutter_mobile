import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import '../../../views/institution_image.dart';
import '../../../views/loading_institution.dart';
import '../controllers/webull_login_controller.dart';

class WebullAddAccounts extends GetView<WebullLoginController> {
  const WebullAddAccounts({Key? key}) : super(key: key);

  Widget actionButtons(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () {
                controller.cancelAddAccounts();
              },
              child: Text('Cancel',
                  style: TextStyle(
                      color: context.theme.primaryColor, fontSize: 16)),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: ElevatedButton(
                onPressed: () => {controller.addAccounts()},
                child: const Text('Submit',
                    style: TextStyle(color: Colors.white, fontSize: 16))),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [main(context), runLoading()],
    );
  }

  Widget checkAccountCard(InstitutionAccount account, BuildContext context) {
    return Obx(() {
      if (controller.accountSelectedMap$.value[account.accountId] != null) {
        return CheckboxListTile(
          activeColor: context.theme.primaryColor,
          value: controller.accountSelectedMap$.value[account.accountId],
          onChanged: (bool? value) {
            controller.accountSelectedMap$.value[account.accountId] = value;
            controller.accountSelectedMap$.refresh();
          },
          title: Text('Account: ${account.name}',
              style: TextStyle(color: context.theme.colorScheme.secondary)),
          subtitle: Text('ID: ******${account.accountId!.substring(5)}'),
          // selected: controller.accountSelectedMap$.value[account.accountId],
        );
      } else {
        return Container();
      }
    });
  }

  Widget content(BuildContext context) {
    return Obx(() {
      List<InstitutionAccount>? institutionAccounts = [];

      if (controller.connectResponse$.value?.institution?.institutionAccounts ==
          null) {
        institutionAccounts = <InstitutionAccount>[];
      } else {
        institutionAccounts = controller
            .connectResponse$.value?.institution?.institutionAccounts
            ?.where((element) => element.isBrokerage == false)
            .toList();
      }
      if (institutionAccounts!.isEmpty) {
        return Column(
          children: const [
            InstitutionImage(
              institionName: INSTITUTION_NAME.WEBULL,
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'No brokerage accounts on webull to connect',
              style: TextStyle(fontSize: 23),
            ),
          ],
        );
      }
      final int totalItemCount = institutionAccounts.length + 2;
      return ListView.builder(
          itemCount: totalItemCount,
          shrinkWrap: true,
          itemBuilder: (context, i) {
            if (i == 0) {
              return top();
            } else if (i == totalItemCount - 1) {
              return actionButtons(context);
            }
            return checkAccountCard(institutionAccounts![i - 1], context);
          });
    });
  }

  Widget main(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: content(context),
    );
  }

  Widget runLoading() {
    return Obx(() {
      if (controller.apiStatus$.value == API_STATUS.PENDING) {
        return const LoadingConnectInstitution(
          duration: Duration(seconds: 3),
        );
      }
      return Container();
    });
  }

  Widget top() {
    return Column(
      children: const [
        Text(
          'Please select all accounts you would like to link with Iris',
          style: TextStyle(fontSize: 23),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
