import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_mobile/app/modules/account/account.dart';
import 'package:iris_mobile/app/modules/referrals/referrals.dart';
import 'package:unicons/unicons.dart';

class SettingsMobile extends StatelessWidget {
  const SettingsMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ListTileWidget(
            leading: Icon(UniconsLine.user,
                color: context.theme.colorScheme.secondary),
            title: 'Account',
            onTap: () => Get.toNamed(AccountScreen.routeName())),
        _ListTileWidget(
            leading: Icon(
              UniconsLine.users_alt,
              color: context.theme.colorScheme.secondary,
            ),
            title: 'Follow and Invite Friends',
            onTap: () => Get.toNamed(ReferralsScreen.routeName())),
        // _ListTileWidget(
        //     leading: Icon(
        //       UniconsLine.feather,
        //       color: context.theme.colorScheme.secondary,
        //     ),
        //     title: 'Themes',
        //     onTap: () => Get.toNamed(Paths.Themes)),
      ],
    );
  }
}

class _ListTileWidget extends StatelessWidget {
  final Widget? leading;
  final String? title;
  final Function? onTap;
  const _ListTileWidget({Key? key, this.leading, this.title, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap as void Function()?,
      leading:
          Container(width: 50, alignment: Alignment.centerLeft, child: leading),
      trailing: Icon(
        Icons.chevron_right,
        color: context.theme.colorScheme.secondary,
      ),
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
