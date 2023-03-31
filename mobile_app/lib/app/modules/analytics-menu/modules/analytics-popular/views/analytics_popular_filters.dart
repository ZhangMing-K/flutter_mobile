import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:iris_mobile/app/modules/analytics-menu/modules/analytics-popular/controllers/analytics_popular_filters_controller.dart';
import 'package:iris_mobile/app/modules/analytics-menu/shared/gold_gradient_wrapper/gold_gradient_wrapper.dart';

typedef ApplyCallback = void Function(bool isGold);

class PopularFiltersScreen extends StatelessWidget {
  PopularFiltersScreen(
      {Key? key,
      required this.controller,
      required this.appliedIsGold,
      required this.isGoldMember,
      required this.onApply})
      : super(key: key) {
    controller.currentIsGold.value = appliedIsGold;
  }
  final AnalyticsPopularFiltersController controller;
  final bool appliedIsGold;
  final ApplyCallback onApply;
  final bool isGoldMember;

  Widget applyButton() {
    return Obx(() {
      bool isVisible = false;
      int changedNumber = 0;
      if (appliedIsGold != controller.currentIsGold.value) {
        isVisible = true;
        changedNumber += 1;
      }
      return isVisible
          ? GestureDetector(
              onTap: () {
                onApply(
                  controller.currentIsGold.value,
                );
              },
              child: Builder(builder: (context) {
                return Container(
                  decoration: BoxDecoration(
                      color: context.theme.primaryColor,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  padding: EdgeInsets.all(ScreenUtil().setWidth(16)),
                  margin: EdgeInsets.all(ScreenUtil().setWidth(20)),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Apply',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: ScreenUtil().setSp(16),
                                fontWeight: FontWeight.w500)),
                        Text(' (' + changedNumber.toString() + ')',
                            style: const TextStyle(color: Colors.white)),
                        if (!isGoldMember)
                          Container(
                              padding: const EdgeInsets.only(left: 4),
                              child: const Icon(
                                Icons.lock,
                                color: Colors.white,
                              ))
                      ]),
                );
              }),
            )
          : Container();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            header(),
            Container(
              margin: EdgeInsets.only(
                  left: ScreenUtil().setWidth(20),
                  right: ScreenUtil().setWidth(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: ScreenUtil().setWidth(24)),
                  filterIsGold(),
                ],
              ),
            ),
          ],
        ),
        applyButton()
      ],
    );
  }

  Widget divider(BuildContext context) {
    return Container(
      height: 1,
      color: context.theme.colorScheme.secondary.withOpacity(0.3),
    );
  }

  Widget filterIsGold() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Builder(builder: (context) {
            return Row(
              children: [
                IrisGoldGradientRapper(child: title('Gold', context)),
                Text('  (top 10% of traders)',
                    style: TextStyle(
                        color: context.theme.colorScheme.secondary
                            .withOpacity(0.5),
                        fontSize: ScreenUtil().setSp(14)))
              ],
            );
          }),
          Obx(() {
            return CupertinoSwitch(
              value: controller.currentIsGold.value == true,
              onChanged: (bool value) {
                controller.setIsGold(value);
              },
              activeColor: IrisColor.primaryColor,
            );
          }),
        ]);
  }

  Widget header() {
    return Container(
        margin: EdgeInsets.only(left: ScreenUtil().setWidth(20), right: 0),
        child: Row(
          children: <Widget>[
            Expanded(flex: 1, child: Container()),
            Expanded(
              flex: 2,
              child: Builder(builder: (context) {
                return Text(
                  'Filters',
                  style: TextStyle(
                      color: context.theme.colorScheme.secondary,
                      fontWeight: FontWeight.bold,
                      fontSize: ScreenUtil().setSp(20)),
                  textAlign: TextAlign.center,
                );
              }),
            ),
            Expanded(
                flex: 1,
                child: InkWell(
                    onTap: () {
                      controller.currentIsGold.value = false;
                    },
                    child: Container(
                        width: ScreenUtil().setWidth(44),
                        alignment: Alignment.center,
                        child: Text('Reset',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(16),
                                color: IrisColor.irisBlueLight,
                                fontWeight: FontWeight.w500))))),
          ],
        ));
  }

  Widget subTitle(String subTitle, BuildContext context) {
    return Text(subTitle,
        style: TextStyle(
            fontSize: ScreenUtil().setSp(16),
            color: context.theme.colorScheme.secondary,
            fontWeight: FontWeight.w500));
  }

  Widget title(String title, BuildContext context) {
    return Text(title,
        style: TextStyle(
            fontSize: ScreenUtil().setSp(20),
            color: context.theme.colorScheme.secondary,
            fontWeight: FontWeight.bold));
  }
}
