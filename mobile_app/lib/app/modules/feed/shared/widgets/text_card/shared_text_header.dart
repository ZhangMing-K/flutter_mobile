import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_mobile/app/routes/pages.dart';

class SharedTextHeader extends StatelessWidget {
  const SharedTextHeader({Key? key, required this.text}) : super(key: key);

  final TextModel text;

  autoPilotOrderBadge() {
    if (text.order?.autoPilotOrder == null) {
      return Container();
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          IconPath.autoPilotIcon,
          height: 15,
        ),
        const SizedBox(width: 5),
        const Text(
          'Autopiloted ',
          style: TextStyle(fontSize: 12, color: IrisColor.dateFromColor),
        ),
        if (text.order!.autoPilotOrder!.masterUser != null)
          UserName(
            user: text.order!.autoPilotOrder!.masterUser!,
            fontSize: 12,
          )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 20, left: 16, right: 16),
      child: Row(
        children: [
          UserImage(
            user: text.user!,
            radius: 25,
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      UserName(
                          user: text.user,
                          fontWeight: FontWeight.w500,
                          fontSize: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              if (text.textType == TEXT_TYPE.ORDER)
                                Text('Verified by ',
                                    style: TextStyle(
                                        color: context
                                            .theme.colorScheme.secondary
                                            .withOpacity(0.6))),
                              SizedBox(
                                height: 19,
                                width: 35,
                                child: Image.asset(
                                    Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Images.irisWhiteLogo
                                        : Images.irisLogo3x),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    text.dateAndTimeLocal,
                    style: const TextStyle(
                        fontSize: 12, color: IrisColor.dateFromColor),
                  ),
                  autoPilotOrderBadge()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
