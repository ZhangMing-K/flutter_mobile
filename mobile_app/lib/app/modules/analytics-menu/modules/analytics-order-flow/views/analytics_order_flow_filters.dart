import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';
import 'package:iris_mobile/app/modules/analytics-menu/modules/analytics-order-flow/controllers/analytics_order_flow_controller.dart';
import 'package:iris_mobile/app/modules/analytics-menu/modules/analytics-order-flow/controllers/analytics_order_flow_filters_controller.dart';
import 'package:iris_mobile/app/modules/analytics-menu/modules/analytics-order-flow/views/widgets/slider.dart';
import 'package:iris_mobile/app/modules/analytics-menu/shared/gold_gradient_wrapper/gold_gradient_wrapper.dart';
import 'package:unicons/unicons.dart';

typedef ApplyCallback = void Function(
    bool isGold, double minPortfolio, double minTradeAmount);

class OrderFlowFiltersScreen extends StatelessWidget {
  final AnalyticsOrderFlowController orderFlowController;
  final AnalyticsOrderFlowFiltersController controller;
  final bool appliedIsGold;
  final double appliedMinPortfolio;
  final double appliedMinTradeAmount;
  final ApplyCallback onApply;
  //final bool isGoldMember;

  OrderFlowFiltersScreen({
    Key? key,
    required this.controller,
    required this.appliedIsGold,
    required this.appliedMinPortfolio,
    // required this.isGoldMember,
    required this.appliedMinTradeAmount,
    required this.orderFlowController,
    required this.onApply,
  }) : super(key: key) {
    controller.currentIsGold.value = appliedIsGold;
    controller.currentMinPortfolio.value = appliedMinPortfolio;
    controller.currentMinTradeAmount.value = appliedMinTradeAmount;
  }

  Widget applyButton() {
    return Builder(builder: (context) {
      final isKeyboardOpen = context.isKeyboardOpen;
      return Obx(() {
        int changedNumber = 0;
        if (appliedIsGold != controller.currentIsGold.value) {
          controller.isVisible.value = true;
          changedNumber += 1;
        }
        if (appliedMinPortfolio != controller.currentMinPortfolio.value) {
          controller.isVisible.value = true;
          changedNumber += 1;
        }
        if (appliedMinTradeAmount != controller.currentMinTradeAmount.value) {
          controller.isVisible.value = true;
          changedNumber += 1;
        }
        if (orderFlowController.selectedAssetList.isNotEmpty) {
          controller.isVisible.value = true;
          changedNumber += 1;
        }
        return controller.isVisible.value && !isKeyboardOpen
            ? GestureDetector(
                onTap: () {
                  onApply(
                    controller.currentIsGold.value,
                    controller.currentMinPortfolio.value,
                    controller.currentMinTradeAmount.value,
                  );

                  orderFlowController.query('');
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
                          Text(' ($changedNumber)',
                              style: const TextStyle(color: Colors.white)),
                          // if (!isGoldMember)
                          //   Container(
                          //       padding: const EdgeInsets.only(left: 4),
                          //       child: const Icon(
                          //         Icons.lock,
                          //         color: Colors.white,
                          //       ))
                        ]),
                  );
                }),
              )
            : Container();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Column(
        //   children: [

        //   ],
        // ),
        header(),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(
                left: ScreenUtil().setWidth(20),
                right: ScreenUtil().setWidth(20)),
            child: Obx(() {
              final searchList = orderFlowController.searchAssetList.toList();
              final query = orderFlowController.query.value;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: ScreenUtil().setWidth(24)),
                  searchField(),
                  Container(
                    // height: 10,
                    child: filters(),
                  ),
                  if (query.isEmpty) ...[
                    SizedBox(height: ScreenUtil().setWidth(24)),
                    Expanded(
                      child: ListView(
                        children: [
                          filterIsGold(),
                          SizedBox(height: ScreenUtil().setWidth(30)),
                          minimumPercentOfPortfolio(),
                          SizedBox(height: ScreenUtil().setWidth(30)),
                          minimumTradeAmount(),
                        ],
                      ),
                    )
                  ] else
                    Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: searchList.length,
                          itemBuilder: (context, index) {
                            final asset = searchList[index];
                            return IrisAssetListTile(
                              color: Colors.transparent,
                              asset: asset,
                              onTap: () {
                                HapticFeedback.lightImpact();
                                orderFlowController.onAssetSelected(asset);
                              },
                            );
                          }),
                    )
                ],
              );
            }),
          ),
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
          Row(
            children: [
              IrisGoldGradientRapper(child: title('Gold')),
              Builder(builder: (context) {
                return Text('  (top 10% of traders)',
                    style: TextStyle(
                        color: context.theme.colorScheme.secondary
                            .withOpacity(0.5),
                        fontSize: ScreenUtil().setSp(14)));
              })
            ],
          ),
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

  Widget filters() {
    return Wrap(
      children: [
        ...orderFlowController.selectedAssetList
            .map(
              (asset) => Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Chip(
                  deleteIcon: const Icon(Icons.close),
                  onDeleted: () {
                    orderFlowController.onAssetSelected(asset);
                  },
                  label: Text(asset.symbol!),
                ),
              ),
            )
            .toList(),
      ],
    );
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
              return Obx(() => Text(
                    orderFlowController.query.isEmpty ? 'Filters' : 'Search',
                    style: TextStyle(
                        color: context.theme.colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenUtil().setSp(20)),
                    textAlign: TextAlign.center,
                  ));
            }),
          ),
          Expanded(
            flex: 1,
            child: Obx(() {
              final showList = orderFlowController.query.isNotEmpty;
              return InkWell(
                onTap: () {
                  if (showList) {
                    orderFlowController.onDone();
                  } else {
                    controller.onReset();
                    orderFlowController.selectedAssetList.clear();
                    orderFlowController.query('');
                  }
                },
                child: Container(
                  width: ScreenUtil().setWidth(44),
                  alignment: Alignment.center,
                  child: Text(
                    showList ? 'Done' : 'Reset',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(16),
                        color: IrisColor.irisBlueLight,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget minimumPercentOfPortfolio() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() {
          return subTitle(
            'Minimum percent of portfolio :  ${controller.currentMinPortfolio.value.formatCompact()}%',
          );
        }),
        Obx(() {
          return FilterSlider(
              value: controller.currentMinPortfolio.value,
              onChanged: controller.onMinPortfolioChanged);
        }),
      ],
    );
  }

  Widget minimumTradeAmount() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() {
          return subTitle(
            'Minimum trade amount :  \$${controller.currentMinTradeAmount.value.formatCompact()}',
          );
        }),
        Obx(() {
          return FilterSlider(
              value: controller.currentMinTradeAmount.value,
              min: 0,
              max: 10000,
              onChanged: controller.onMinTradeAmountChanged);
        }),
      ],
    );
  }

  Widget searchField() {
    return Focus(
      onFocusChange: (hasFocus) {
        if (hasFocus) {
          controller.isVisible.value = false;
        }
      },
      child: Builder(builder: (context) {
        return Obx(() => Focus(
              onFocusChange: (hasFocus) {
                if (hasFocus) {
                  orderFlowController.query.refresh();
                }
              },
              child: TextFormField(
                initialValue: orderFlowController.query.value,
                autocorrect: false,
                focusNode: orderFlowController.searchNode,
                style: TextStyle(color: context.theme.colorScheme.secondary),
                decoration: InputDecoration(
                  hintText: 'Stock/Crypto',
                  hintStyle: TextStyle(
                      color:
                          context.theme.colorScheme.secondary.withOpacity(0.5)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  prefixIcon: const Icon(UniconsLine.search),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  fillColor:
                      context.theme.colorScheme.secondary.withOpacity(.15),
                ),
                onChanged: orderFlowController.query,
              ),
            ));
      }),
    );
  }

  Widget subTitle(String subTitle) {
    return Builder(builder: (context) {
      return Text(subTitle,
          style: TextStyle(
              fontSize: ScreenUtil().setSp(16),
              color: context.theme.colorScheme.secondary,
              fontWeight: FontWeight.w500));
    });
  }

  Widget title(String title) {
    return Builder(builder: (context) {
      return Text(title,
          style: TextStyle(
              fontSize: ScreenUtil().setSp(20),
              color: context.theme.colorScheme.secondary,
              fontWeight: FontWeight.bold));
    });
  }
}
