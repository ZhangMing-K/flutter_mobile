import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../themes/colors.dart';

class IrisStepper extends StatelessWidget {
  const IrisStepper(
      {Key? key,
      required this.numberOfSteps,
      required this.curStep,
      required this.width,
      required Color color})
      : activeColor = color,
        assert(curStep >= 0 == true && curStep <= numberOfSteps),
        assert(width > 0),
        super(key: key);

  final double width;
  final double numberOfSteps;
  final int curStep;
  final Color activeColor;
  final Color inactiveColor = IrisColor.subTitle;
  final double lineWidth = 2.0;

  List<Widget> stepperView(BuildContext context) {
    final list = <Widget>[];

    for (var i = 0; i < numberOfSteps; i++) {
      final circleColor = (i == 0 || curStep > i)
          ? activeColor
          : context.theme.scaffoldBackgroundColor;

      final lineColor = curStep > i ? activeColor : inactiveColor;

      list.add(
        Container(
          width: 10.0,
          height: 10.0,
          padding: const EdgeInsets.all(0),
          decoration: BoxDecoration(
            color: circleColor,
            borderRadius: const BorderRadius.all(Radius.circular(25.0)),
            border: Border.all(
              color: context.theme.hintColor,
              width: 0.5,
            ),
          ),
        ),
      );

      if (i != numberOfSteps - 1) {
        list.add(Expanded(
            child: Container(
          height: lineWidth,
          color: lineColor,
        )));
      }
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(
          top: 32.0,
          left: 24.0,
          right: 24.0,
        ),
        width: width,
        child: Column(
          children: <Widget>[
            Row(
              children: stepperView(context),
            ),
          ],
        ));
  }
}
