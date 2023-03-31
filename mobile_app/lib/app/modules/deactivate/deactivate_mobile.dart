import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import 'deactivate_controller.dart';

class DeactivateMobile extends GetView<DeactivateController> {
  const DeactivateMobile({Key? key}) : super(key: key);

  Widget body() {
    return Column(
      children: const [
        ListTileWidget(
            title: 'This will deactivate your accout',
            subtitle:
                "You're about to start the process of deactivating your Iris account.  Your display name, username, and public profile will no longer be viewable on our platform."),
        Padding(
          padding: EdgeInsets.only(top: 20),
          child: ListTileWidget(
              title: 'What else you should know',
              subtitle:
                  "You can restore your Iris account if it was accidentally or wrongfully deactivated by logging back in with the email attached to this account. \n \n If you just want to change your @username, you don't need to deactivate your account - edit it in your settings. \n \n To use your current @username with a different Iris account, change it before you deactivate this account."),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        body(),
        Column(
          children: [
            deactivate(context),
            const SizedBox(
              height: 20,
            )
          ],
        )
      ],
    );
  }

  Widget confirmation() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Builder(builder: (context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              'Deactive your Iris Account',
              style: TextStyle(
                fontSize: 20,
                color: context.textTheme.bodyText1!.color,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Are you sure you want to deactive this account?',
              style: TextStyle(
                  fontSize: 14,
                  color: context.textTheme.subtitle1!.color,
                  fontWeight: FontWeight.w300),
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                child: const Text(
                  'Deactivate',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        context.theme.primaryColor),
                    textStyle: MaterialStateProperty.all<TextStyle>(
                        const TextStyle(color: Colors.white, fontSize: 12))),
                onPressed: controller.deactivate,
              ),
            ),
            const SizedBox(height: 12),
          ],
        );
      }),
    );
  }

  Widget deactivate(BuildContext context) {
    return ListTile(
      onTap: () {
        Get.bottomSheet(
          CustomBottomSheet(
            maxHeight: .3,
            child: confirmation(),
          ),
          isScrollControlled: true,
          enableDrag: true,
        );
      },
      title: Container(
        height: 40,
        width: double.infinity,
        color: context.theme.backgroundColor,
        alignment: Alignment.center,
        child: const Text(
          'Deactivate',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: IrisColor.sellColor),
        ),
      ),
    );
  }
}

class ListTileWidget extends StatelessWidget {
  final String? title;
  final String? subtitle;

  const ListTileWidget({
    Key? key,
    this.title,
    this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(title!,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: context.textTheme.bodyText1!.color,
              ))),
      subtitle: Text(
        subtitle!,
        style: TextStyle(
          color: context.textTheme.subtitle1!.color,
        ),
      ),
    );
  }
}
