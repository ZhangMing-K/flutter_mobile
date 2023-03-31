import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../iris_common.dart';

class IrisPortfolioName extends StatelessWidget {
  const IrisPortfolioName(
      {Key? key,
      required this.portfolio,
      this.fontSize = 14,
      this.fontWeight = FontWeight.normal,
      this.route = true,
      this.color})
      : super(key: key);
  final Portfolio? portfolio;
  final double fontSize;
  final FontWeight fontWeight;
  final bool route;
  final Color? color;

  Widget main(BuildContext context) {
    return RichText(
      textScaleFactor: context.textScaleFactor,
      text: TextSpan(
        children: <InlineSpan>[
          TextSpan(
            text: portfolio?.portfolioName,
            style: TextStyle(
                fontWeight: fontWeight,
                fontSize: fontSize,
                color: color ?? context.theme.colorScheme.secondary),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (portfolio == null) {
      return Container();
    }
    if (route) {
      return InkWell(
          onTap: () {
            if (route) {
              Get.toNamed(
                Paths.Portfolio.createPath([portfolio!.portfolioKey]),
                id: 1,
              );
            }
          },
          child: main(context));
    }
    return main(context);
  }
}
