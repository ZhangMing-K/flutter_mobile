import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../iris_common.dart';

//TODO:Refactor this
//Change "c" to "controller"
class LinkSocialsView extends StatelessWidget {
  LinkSocialsViewController c = Get.put(LinkSocialsViewController());

  LinkSocialsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [title(), socialTile(SOCIAL_SOURCE.TWITTER, context)],
      ),
    );
  }

  confirmation(source, BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Unlink ${getTitle(source)}',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                'Are you sure you want to disconnect your ${getTitle(source)} from Iris?',
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
              ),
              Container(
                  padding: const EdgeInsets.all(20),
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary:
                          context.theme.colorScheme.secondary.withOpacity(.13),
                    ),
                    child: const Text(
                      'Unlink',
                      style:
                          TextStyle(fontSize: 20, color: IrisColor.sellColor),
                    ),
                    onPressed: () async {
                      c.socialLogin(source);
                    },
                  )),
            ]));
  }

  String getTitle(source) {
    switch (source) {
      case SOCIAL_SOURCE.TWITTER:
        return 'Twitter';

      default:
        return 'Twitter';
    }
  }

  Widget socialTile(SOCIAL_SOURCE source, context) {
    return Obx(() {
      final text = c.currentIntegrations$.contains(source) ? 'Unlink' : 'Link';
      return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(getTitle(source),
            style: TextStyle(
              fontSize: ScreenUtil().setSp(16),
            )),
        const SizedBox(width: 5),
        GestureDetector(
          onTap: () async => {
            if (c.currentIntegrations$.contains(source))
              {
                Get.bottomSheet(
                    CustomBottomSheet(
                        child: confirmation(source, context), maxHeight: 0.3),
                    isScrollControlled: true,
                    enableDrag: true)
              }
            else
              await c.socialLogin(source)
          },
          child: Text(text,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: c.currentIntegrations$.contains(source)
                    ? IrisColor.sellColor
                    : IrisColor.buyColor,
                fontSize: ScreenUtil().setSp(16),
              )),
        )
      ]);
    });
  }

  Widget title() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [Text('Linked Accounts')]);
  }
}
