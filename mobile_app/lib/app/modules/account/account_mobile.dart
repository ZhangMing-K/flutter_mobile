import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:iris_mobile/app/modules/account_portfolios/account_portfolios.dart';
import 'package:iris_mobile/app/modules/deactivate/deactivate.dart';

import 'account_controller.dart';

class ListTileWidget extends StatelessWidget {
  const ListTileWidget({Key? key, this.title, this.trailing, this.onTap})
      : super(key: key);

  final String? title;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      trailing: trailing,
      title: Container(
        height: 56.0,
        width: double.infinity,
        alignment: Alignment.centerLeft,
        child: Text(
          title!,
          style: TextStyle(
              color: context.theme.colorScheme.secondary,
              fontSize: 16,
              fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

class AccountMobile extends GetView<AccountController> {
  const AccountMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTileWidget(
            title: 'Personal Information',
            onTap: () => Get.toNamed(Paths.EditProfile),
            trailing: Icon(
              Icons.chevron_right,
              color: context.textTheme.subtitle1!.color,
            )),
        ListTileWidget(
            title: 'Deactivate Your Account',
            onTap: () => Get.toNamed(DeactivateScreen.routeName()),
            trailing: Icon(
              Icons.chevron_right,
              color: context.textTheme.subtitle1!.color,
            )),
        ListTileWidget(
            title: 'Portfolios',
            onTap: () => Get.toNamed(AccountPortfoliosScreen.routeName()),
            trailing: Icon(
              Icons.chevron_right,
              color: context.textTheme.subtitle1!.color,
            )),
        ListTileWidget(
            title: 'Notification Settings',
            onTap: () => Get.toNamed(Paths.NotificationSettings),
            trailing: Icon(
              Icons.chevron_right,
              color: context.textTheme.subtitle1!.color,
            )),
        ListTileWidget(
            title: 'Payment Methods',
            onTap: () => Get.toNamed(Paths.PaymentMethods),
            trailing: Icon(
              Icons.chevron_right,
              color: context.textTheme.subtitle1!.color,
            )),
      ],
    );
  }
}
