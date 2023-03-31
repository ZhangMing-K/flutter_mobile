import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/data/calc/index.dart';
import 'package:share_plus/share_plus.dart';

import '../../../data/services/auth_user/auth_user_service.dart';

class InviteLinkButton extends StatelessWidget {
  final IAuthUserService authUserStore = Get.find();

  InviteLinkButton({this.height, Key? key}) : super(key: key);
  final double? height;
  @override
  Widget build(BuildContext context) {
    if (authUserStore.loggedUser?.inviteLink == null) {
      return Container();
    }
    return SizedBox(
        width: double.infinity,
        height: height ?? 35,
        child: OutlinedButton(
          onPressed: () {
            Share.share(authUserStore.loggedUser!.inviteLink!);
          },
          style: ButtonStyle(
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            enableFeedback: true,
          ),
          child: Text(
            'Invite Friends',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: IrisScreenUtil.dFontSize(14),
                color: context.theme.colorScheme.secondary),
          ),
        ));
  }
}
