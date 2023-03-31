import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../iris_common.dart';

//TODO: move to bindings
class SocialLinkButton extends StatelessWidget {
  SocialLinkButtonController c = SocialLinkButtonController();
  Rx<Integration>? integration$;

  SocialLinkButton({
    Key? key,
    SOCIAL_SOURCE? source,
    Integration? integration,
    int? userKey,
  }) : super(key: key) {
    c.userKey = userKey;
    c.setIntegration(integration);
    c.source = source;
  }

  @override
  Widget build(BuildContext context) {
    return main();
  }

  getSocialLogo({bool? invert}) {
    switch (c.source) {
      case SOCIAL_SOURCE.TWITTER:
        return invert == true
            ? Image.asset(
                Images.twitterWhite,
                width: 17,
                height: 17,
              )
            : Image.asset(Images.twitter, width: 17, height: 17);
      default:
    }
  }

  main() {
    return Obx(() {
      if (c.integration$.value?.source == c.source &&
          c.integration$.value!.token != null) return username();

      return Container();
    });
  }

  Widget username() {
    return Obx(() => Row(
          children: [
            getSocialLogo(),
            const SizedBox(width: 6),
            GestureDetector(
              onTap: c.launchUrl,
              child: Text(c.integration$.value?.username ?? '',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: IrisColor.buyColor,
                    fontSize: ScreenUtil().setSp(13),
                    fontWeight: FontWeight.w100,
                  )),
            )
          ],
        ));
  }
}
